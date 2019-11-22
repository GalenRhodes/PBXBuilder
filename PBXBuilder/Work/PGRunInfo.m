/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGRunInfo.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/4/19
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

#import "PGRunInfo.h"
#import "GNUstepInfo.h"
#import <Moscow/Moscow.h>

NSString *const PGProjErrorDomain = @"com.projectgalen.PBXBuilder";

@implementation PGRunInfo {
    }

    @synthesize programPath = _programPath;
    @synthesize gnustepInfo = _gnustepInfo;
    @synthesize projects = _projects;

    -(instancetype)initWithCommandLine:(const char *_Nonnull *_Nonnull)argv argCount:(int)argc error:(NSError **)pError {
        self = [super init];

        if(self) {
            NSError *error = nil;
            if(argc < 1) {
                NSString *reason = @"There has to be at least one command-line argument.";
                setpptr(pError, [NSError errorWithDomain:PGProjErrorDomain code:100 userInfo:@{ NSLocalizedDescriptionKey: reason }]);
                return nil;
            }

            _programPath = [NSString stringWithUTF8String:argv[0]];
            _gnustepInfo = [[GNUstepInfo alloc] init:&error];
            PGPrintStr(@"Getting GNUstep parameters...\n");
            PGPrintf(@"\nConfig: \"%@\"\n", _gnustepInfo.gnustepConfig);

            PGPrintStr(@"\nCompiler Flags:\n");
            [self printOptions:_gnustepInfo.objcOpts];

            PGPrintStr(@"\nBase Linker Flags:\n");
            [self printOptions:_gnustepInfo.linkBaseOpts];

            PGPrintStr(@"\nGUI Linker Flags:\n");
            [self printOptions:_gnustepInfo.linkGuiOpts];

            PGPrintf(@"\n%20s: %lu\n", "cpuCount", _gnustepInfo.cpuCount);
            PGPrintf(@"%20s: \"%@\"\n", "ccPath", _gnustepInfo.ccPath);
            PGPrintf(@"%20s: \"%@\"\n", "cxxPath", _gnustepInfo.cxxPath);
            PGPrintf(@"%20s: \"%@\"\n", "applcationPath", _gnustepInfo.applcationPath);
            PGPrintf(@"%20s: \"%@\"\n", "toolsPath", _gnustepInfo.toolsPath);
            PGPrintf(@"%20s: \"%@\"\n", "libraryPath", _gnustepInfo.libraryPath);
            PGPrintf(@"%20s: \"%@\"\n", "headersPath", _gnustepInfo.headersPath);
            PGPrintf(@"%20s: \"%@\"\n", "libsPath", _gnustepInfo.libsPath);
            PGPrintf(@"%20s: \"%@\"\n", "docPath", _gnustepInfo.docPath);
            PGPrintf(@"%20s: \"%@\"\n", "manPath", _gnustepInfo.manPath);
            PGPrintf(@"%20s: \"%@\"\n", "infoPath", _gnustepInfo.infoPath);

            int i = 1;

            while(i < argc) {
                const char *arg = argv[i++];

                if(*arg) {
                    if(*arg == '-') {
                        NSString *reason = PGFormat(@"Unrecognized command-line options: \"%s\"", arg);
                        setpptr(pError, [NSError errorWithDomain:PGProjErrorDomain code:100 userInfo:@{ NSLocalizedDescriptionKey: reason }]);
                        return nil;
                    }
                    else {
                        NSString *str = [NSString stringWithUTF8String:arg].trim;

                        if(str.length) {
                            NSString *path     = str.stringByStandardizingPath;
                            NSString *filename = path.lastPathComponent;

                            if(![filename isEqualToString:@"project.pbxproj"]) {
                                NSString  *y = nil;
                                NSInteger x  = PGExecuteApplication(@"find", @[ path, @"-name", @"\"project.pbxproj\"" ], &y, &error);

                                if(x || ((y = y.trim).length == 0)) {
                                    NSString *reason = PGFormat(@"ERROR (%li): Failed to locate project file.", x);
                                    setpptr(pError, [NSError errorWithDomain:PGProjErrorDomain code:100 userInfo:@{ NSLocalizedDescriptionKey: reason }]);
                                    return nil;
                                }

                                NSArray<NSString *> *array = [y split:@"(\\r\\n?|\\n)*"];
                            }
                        }
                    }
                }
            }
        }

        return self;
    }

    -(void)printOptions:(NSArray<NSString *> *)opts {
        NSUInteger   c = 0;
        for(NSString *s in opts) PGPrintf(@"%2lu> %@\n", ++c, s);
    }

@end
