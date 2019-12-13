/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: GNUstepInfo.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/15/19
 *
 * Copyright © 2019 Project Galen. All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *//************************************************************************/

#import <Moscow/Moscow.h>
#import "GNUstepInfo.h"
#import "PBXTools.h"

@interface GNUstepInfo()

    @property(nullable, copy) NSString *ccPath;
    @property(nullable, copy) NSString *cxxPath;
    @property(nullable, copy) NSString *applcationPath;
    @property(nullable, copy) NSString *toolsPath;
    @property(nullable, copy) NSString *libraryPath;
    @property(nullable, copy) NSString *headersPath;
    @property(nullable, copy) NSString *libsPath;
    @property(nullable, copy) NSString *docPath;
    @property(nullable, copy) NSString *manPath;
    @property(nullable, copy) NSString *infoPath;

@end

@implementation GNUstepInfo {
    }

    -(instancetype)init {
        return (self = [self init:NULL]);
    }

    -(instancetype)init:(NSError **)pError {
        self = [super init];

        if(self) {
            setpptr(pError, nil);
            if(![self getGNUstepConfig:pError]) return nil;
            if(![self getGNUstepEnvironment:pError]) return nil;
            if(!(_objcOpts     = [self getGNUstepFlags:@"--objc-flags" error:pError].mutableCopy)) return nil;
            if(!(_linkBaseOpts = [self getGNUstepFlags:@"--base-libs" error:pError].mutableCopy)) return nil;
            if(!(_linkGuiOpts  = [self getGNUstepFlags:@"--gui-libs" error:pError].mutableCopy)) return nil;

            [(NSMutableArray *)_objcOpts addObject:@"-fobjc-arc"];
            [(NSMutableArray *)_objcOpts addObject:@"-fobjc-nonfragile-abi"];
            [(NSMutableArray *)_linkBaseOpts addObject:@"-ldispatch"];
            [(NSMutableArray *)_linkGuiOpts addObject:@"-ldispatch"];

            _cpuCount = [self getCpuCount:pError];
        }

        return self;
    }

    +(instancetype)info:(NSError **)pError {
        return [[self alloc] init:pError];
    }

    -(BOOL)getGNUstepConfig:(NSError **)pError {
        PGExecute *exe = [PGExecute exeWithAppPath:@"/bin/bash" arguments:@[ @"-c", @"which gnustep-config" ] execute:YES error:pError];
        if(!exe || [exe waitUntilExit:pError]) return NO;
        _gnustepConfig = exe.stdOut.trim;
        return YES;
    }

    -(BOOL)getGNUstepEnvironment:(NSError **)pError {
        NSDictionary<NSString *, NSString *> *fuck = @{
            @"ccPath"        : @"--variable=CC",
            @"cxxPath"       : @"--variable=CXX",
            @"applcationPath": @"--variable=GNUSTEP_LOCAL_APPS",
            @"toolsPath"     : @"--variable=GNUSTEP_LOCAL_TOOLS",
            @"libraryPath"   : @"--variable=GNUSTEP_LOCAL_LIBRARY",
            @"headersPath"   : @"--variable=GNUSTEP_LOCAL_HEADERS",
            @"libsPath"      : @"--variable=GNUSTEP_LOCAL_LIBRARIES",
            @"docPath"       : @"--variable=GNUSTEP_LOCAL_DOC",
            @"manPath"       : @"--variable=GNUSTEP_LOCAL_DOC_MAN",
            @"infoPath"      : @"--variable=GNUSTEP_LOCAL_DOC_INFO"
        };

        __block BOOL    error = NO;
        __block NSError *e    = nil;

        [fuck enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
            PGExecute *exe2 = [PGExecute exeWithAppPath:_gnustepConfig arguments:@[ obj ] execute:YES error:&e];
            if(exe2 && ([exe2 waitUntilExit:&e] == 0)) [self setValue:exe2.stdOut.trim forKey:key]; else *stop = error = YES;
        }];

        if(error) setpptr(pError, (e ?: pbxMakeError(1001001, @"Unknown Error", nil)));
        return !error;
    }

    -(NSUInteger)getCpuCount:(NSError **)pError {
        NSError *error = nil;
        setpptr(pError, nil);

        NSString *procInfo = [NSString stringWithContentsOfFile:@"/proc/cpuinfo" encoding:NSUTF8StringEncoding error:&error];
        if(!procInfo) return 1;

        NSRegularExpression *rx2 = [NSRegularExpression regularExpressionWithPattern:@"processor\\s+:" options:0 error:&error];
        if(!rx2) return 1;

        return [rx2 matchesInString:procInfo options:0 range:procInfo.range].count;
    }

    -(NSArray<NSString *> *)getGNUstepFlags:(NSString *)op error:(NSError **)error {
        PGExecute *exe = [PGExecute exeWithAppPath:_gnustepConfig arguments:@[ op ] execute:YES error:error];
        if(!exe || [exe waitUntilExit:error]) return nil;
        NSString *taskOutput = exe.stdOut;
        setpptr(error, nil);

        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s+" options:0 error:error];
        if(!regex) return nil;

        NSMutableArray<NSString *> *objcOpts = [NSMutableArray arrayWithCapacity:10];
        NSRange                    fullRange = NSMakeRange(0, (taskOutput = taskOutput.trim).length);

        if(fullRange.length) {
            NSArray<NSTextCheckingResult *> *array  = [regex matchesInString:taskOutput options:0 range:fullRange];
            NSUInteger                      lastIdx = 0;

            for(NSTextCheckingResult *tcr in array) {
                NSRange  rng  = tcr.range;
                NSString *opt = [taskOutput substringWithRange:NSMakeRange(lastIdx, (rng.location - lastIdx))].trim;

                /*
                 * Leave out empty opts (doubtful) and duplicates.
                 */
                if(opt.length && ![objcOpts containsObject:opt]) [objcOpts addObject:opt];
                lastIdx = (rng.location + rng.length);
            }
        }

        return objcOpts;
    }

    -(NSString *)description {
        __block NSUInteger ml = 0;
        NSString           *q = @"\n    | ";

        NSArray<NSString *> *listNames = @[ @"Compiler Flags", @"Base Linker Flags", @"GUI Linker Flags" ];
        NSArray<NSString *> *propNames = @[
            @"cpuCount", @"ccPath", @"cxxPath", @"applcationPath", @"toolsPath", @"libraryPath", @"headersPath", @"libsPath", @"docPath", @"manPath", @"infoPath"
        ];

        [listNames enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) { ml = MAX(ml, key.length); }];
        [propNames enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) { ml = MAX(ml, key.length); }];

        NSMutableString *s = [NSMutableString stringWithFormat:@"Config: \"%@\"", self.gnustepConfig];
        [s appendFormat:@"\n|________%@|", [@"" stringByPaddingToLength:self.gnustepConfig.length withString:@"_" startingAtIndex:0]];

        [propNames enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            id value = [self valueForKey:key];

            [s appendFormat:@"%@%@: ", q, [key stringByLeftPaddingToLength:ml]];

            if(value == nil) [s appendString:@"<NULL>"];
            else if([value isKindOfClass:NSNumber.class]) [s appendString:[value description]];
            else [s appendFormat:@"\"%@\"", value];
        }];

        NSDictionary<NSString *, NSArray<NSString *> *> *lists = @{ listNames[0]: self.objcOpts, listNames[1]: self.linkBaseOpts, listNames[2]: self.linkGuiOpts };
        [listNames enumerateObjectsUsingBlock:^(NSString *hdr, NSUInteger j, BOOL *f2) {
            __block NSUInteger  ml1   = 0;
            NSArray<NSString *> *opts = lists[hdr];
            [s appendFormat:@"%@%@:", q, [hdr stringByLeftPaddingToLength:ml]];
            [opts enumerateObjectsUsingBlock:^(NSString *o, NSUInteger i, BOOL *f1) {
                [s appendFormat:@"%@    | %3lu> %@", q, (i + 1), o];
                ml1 = MAX(ml1, o.length);
            }];
            [s appendFormat:@"%@    |______%@|", q, [@"" stringByPaddingToLength:ml1 withString:@"_" startingAtIndex:0]];
        }];

        return s;
    }

@end
