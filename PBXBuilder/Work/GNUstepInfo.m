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

@implementation GNUstepInfo {
    }

    @synthesize gnustepConfig = _gnustepConfig;
    @synthesize ccPath = _ccPath;
    @synthesize cxxPath = _cxxPath;
    @synthesize applcationPath = _applcationPath;
    @synthesize toolsPath = _toolsPath;
    @synthesize libraryPath = _libraryPath;
    @synthesize headersPath = _headersPath;
    @synthesize libsPath = _libsPath;
    @synthesize docPath = _docPath;
    @synthesize manPath = _manPath;
    @synthesize infoPath = _infoPath;
    @synthesize objcOpts = _objcOpts;
    @synthesize linkBaseOpts = _linkBaseOpts;
    @synthesize linkGuiOpts = _linkGuiOpts;
    @synthesize cpuCount = _cpuCount;

    -(instancetype)init {
        return (self = [self init:NULL]);
    }

    -(instancetype)init:(NSError **)pError {
        self = [super init];

        if(self) {
            if(pError) *pError = nil;
            NSError  *error = nil;
            NSString *str   = nil;

            if(PGExecuteApplication(@"which", @[ @"gnustep-config" ], &str, &error)) {
                setpptr(pError, error);
                return nil;
            }

            _gnustepConfig = str.trim.copy;

            NSArray<NSString *> *results = [self getGNUstepEnv:@[
                @"--variable=CC",                      // --
                @"--variable=CXX",                     // --
                @"--variable=GNUSTEP_LOCAL_APPS",      // --
                @"--variable=GNUSTEP_LOCAL_TOOLS",     // --
                @"--variable=GNUSTEP_LOCAL_LIBRARY",   // --
                @"--variable=GNUSTEP_LOCAL_HEADERS",   // --
                @"--variable=GNUSTEP_LOCAL_LIBRARIES", // --
                @"--variable=GNUSTEP_LOCAL_DOC",       // --
                @"--variable=GNUSTEP_LOCAL_DOC_MAN",   // --
                @"--variable=GNUSTEP_LOCAL_DOC_INFO",  // --
            ]                                            error:&error];
            if(!results) {
                setpptr(pError, error);
                return nil;
            }

            _ccPath         = results[0];
            _cxxPath        = results[1];
            _applcationPath = results[2];
            _toolsPath      = results[3];
            _libraryPath    = results[4];
            _headersPath    = results[5];
            _libsPath       = results[6];
            _docPath        = results[7];
            _manPath        = results[8];
            _infoPath       = results[9];

            if(!(_objcOpts = [self getGNUstepFlags:@"--objc-flags" error:&error].mutableCopy)) {
                setpptr(pError, error);
                return nil;
            }

            if(!(_linkBaseOpts = [self getGNUstepFlags:@"--base-libs" error:&error].mutableCopy)) {
                setpptr(pError, error);
                return nil;
            }

            if(!(_linkGuiOpts = [self getGNUstepFlags:@"--gui-libs" error:&error].mutableCopy)) {
                setpptr(pError, error);
                return nil;
            }

            [(NSMutableArray *)_objcOpts addObject:@"-fobjc-arc"];
            [(NSMutableArray *)_objcOpts addObject:@"-fobjc-nonfragile-abi"];
            [(NSMutableArray *)_linkBaseOpts addObject:@"-ldispatch"];
            [(NSMutableArray *)_linkGuiOpts addObject:@"-ldispatch"];

            _cpuCount = [self getCpuCount:&error];
        }

        return self;
    }

    -(NSUInteger)getCpuCount:(NSError **)error {
        NSString *procInfo = [NSString stringWithContentsOfFile:@"/proc/cpuinfo" encoding:NSUTF8StringEncoding error:error];
        if(!procInfo) return 1;

        NSRegularExpression *rx2 = [NSRegularExpression regularExpressionWithPattern:@"processor\\s+:" options:0 error:error];
        if(!rx2) return 1;

        return [rx2 matchesInString:procInfo options:0 range:procInfo.range].count;
    }

    -(NSArray<NSString *> *)getGNUstepEnv:(NSArray<NSString *> *)keys error:(NSError **)error {
        NSError                    *e       = nil;
        NSMutableArray<NSString *> *results = [NSMutableArray arrayWithCapacity:keys.count];

        for(NSUInteger i = 0; i < keys.count; i++) {
            NSString  *k = keys[i];
            NSString  *v = nil;
            NSInteger r  = PGExecuteApplication(_gnustepConfig, @[ k ], &v, &e);

            if(r || !v) {
                setpptr(error, e);
                return nil;
            }

            results[i] = v.trim;
        }

        setpptr(error, nil);
        return results;
    }

    -(NSArray<NSString *> *)getGNUstepFlags:(NSString *)op error:(NSError **)error {
        NSString *taskOutput = nil;
        setpptr(error, nil);
        if(PGExecuteApplication(_gnustepConfig, @[ op ], &taskOutput, error)) return nil;

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

@end
