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

NS_INLINE void bar(NSMutableArray<NSString *> *array, NSString *str) {
    if(![array containsObject:str]) [array addObject:str];
}

NSMutableArray<NSString *> *barx(NSArray<NSString *> *array);

@implementation GNUstepInfo {
    }

    -(instancetype)init {
        return (self = [self initGNUstepInfo:NULL]);
    }

    -(instancetype)initGNUstepInfo:(NSError **)pError {
        self = [super init];

        if(self) {
            setpptr(pError, nil);
#ifdef __APPLE__
            _gnustepConfig = @"/opt/objc/bin/gnustep-config";
#else
            if((_gnustepConfig = [PGExecute executeAndGetOutput:@"/bin/bash" arguments:@[ @"-c", @"which gnustep-config" ] error:pError].trim) == nil) return nil;
#endif
            if(![self getGNUstepEnvironment:pError]) return nil;
            if((_objcOpts     = barx([self getGNUstepFlags:@"--objc-flags" error:pError])) == nil) return nil;
            if((_linkBaseOpts = [self getGNUstepFlags:@"--base-libs" error:pError].mutableCopy) == nil) return nil;
            if((_linkGuiOpts  = [self getGNUstepFlags:@"--gui-libs" error:pError].mutableCopy) == nil) return nil;
#ifndef __APPLE__
            [((NSMutableArray *)_objcOpts) addObjectsFromArray:@[ @"-fobjc-arc", @"-fobjc-nonfragile-abi", @"-Ofast", @"-Wno-unknown-pragmas" ]];
            [((NSMutableArray *)_linkBaseOpts) addObject:@"-ldispatch"];
            [((NSMutableArray *)_linkGuiOpts) addObject:@"-ldispatch"];
#endif
            _cpuCount = [self getCpuCount:pError];
        }

        return self;
    }

    +(instancetype)GNUstepInfo:(NSError **)pError {
        return [[self alloc] initGNUstepInfo:pError];
    }

    -(BOOL)getGNUstepEnvironment:(NSError **)pError {
#ifdef __APPLE__
        NSDictionary<NSString *, NSString *> *fuck = @{
            @"ccPath"        : @"/opt/objc/clang9/bin/clang",
            @"cxxPath"       : @"/opt/objc/clang9/bin/clang++",
            @"applcationPath": @"/opt/objc/lib/GNUstep/Applications",
            @"toolsPath"     : @"/opt/objc/bin",
            @"libraryPath"   : @"/opt/objc/lib/GNUstep",
            @"headersPath"   : @"/opt/objc/include",
            @"libsPath"      : @"/opt/objc/lib",
            @"docPath"       : @"/opt/objc/share/GNUstep/Documentation",
            @"manPath"       : @"/opt/objc/share/man",
            @"infoPath"      : @"/opt/objc/share/info"
        };

        for(NSString *key in fuck.allKeys) [self setValue:fuck[key] forKey:key];
#else
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

        for(NSString *key in fuck.allKeys) {
            NSString *out = [PGExecute executeAndGetOutput:_gnustepConfig arguments:@[ fuck[key] ] error:pError].trim;
            if(out) [self setValue:out forKey:key]; else return NO;
        }
#endif
        return YES;
    }

    -(NSUInteger)getCpuCount:(NSError **)pError {
        setpptr(pError, nil);
#ifdef __APPLE__
        NSString *val = [PGExecute executeAndGetOutput:@"/usr/sbin/sysctl" arguments:@[ @"-n", @"hw.ncpu" ] error:pError];
        return (val ? MAX([NSScanner atoull:val success:NULL], 1) : 1);
#else
        return MAX([[NSString stringWithContentsOfFile:@"/proc/cpuinfo" encoding:NSUTF8StringEncoding error:NULL] matchesForPattern:@"processor\\s+:"].count, 1);
#endif
    }

    -(NSArray<NSString *> *)getGNUstepFlags:(NSString *)op error:(NSError **)error {
        setpptr(error, nil);
#ifdef __APPLE__
        return @[];
#else
        return [self splitCommandLine:[PGExecute executeAndGetOutput:_gnustepConfig arguments:@[ op ] error:error].trim];
#endif
    }

    -(NSArray<NSString *> *)splitCommandLine:(NSString *)commandLine {
        NSArray<NSTextCheckingResult *> *array = [commandLine matchesForPattern:@"\\s+"];

        if(array.count) {
            NSMutableArray<NSString *> *objcOpts = [NSMutableArray arrayWithCapacity:10];
            NSUInteger                 lastIdx   = 0;

            for(NSTextCheckingResult *tcr in array) {
                bar(objcOpts, [commandLine substringWithRange:NSMakeRange(lastIdx, (tcr.range.location - lastIdx))]);
                lastIdx = NSMaxRange(tcr.range);
            }

            return objcOpts;
        }

        return [NSArray new];
    }

@end

NSMutableArray<NSString *> *barx(NSArray<NSString *> *array) {
    NSMutableArray<NSString *> *narray = [NSMutableArray new];
    for(NSString               *opt in array) if(!([opt hasPrefix:@"-O"] || [opt hasPrefix:@"-g"])) [narray addObject:opt];
    return narray;
}
