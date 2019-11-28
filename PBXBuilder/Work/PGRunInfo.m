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
#import "PBXTools.h"
#import "PGProjectFile.h"
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

            NSMutableArray<PGProjectFile *> *projectsList = [NSMutableArray new];
            _projects = projectsList;

            while(i < argc) {
                const char *arg = argv[i++];

                if(*arg) {
                    if(*arg == '-') {
                        NSString *reason = PGFormat(@"Unrecognized command-line options: \"%s\"", arg);
                        setpptr(pError, [NSError errorWithDomain:PGProjErrorDomain code:100 userInfo:@{ NSLocalizedDescriptionKey: reason }]);
                        return nil;
                    }
                    else {
                        /*
                         * Seriously GNUstep?  We're returning "id" instead of "instancetype"? What year is it?
                         */
                        NSString *str = ((NSString *)[NSString stringWithUTF8String:arg]).trim;

                        if(str.length) {
                            NSFileManager *fm              = NSFileManager.defaultManager;
                            NSString      *path            = str.stringByStandardizingPath;
                            NSString      *filename        = path.lastPathComponent;
                            BOOL          isDir            = NO;
                            NSString      *projectName     = nil;
                            NSString      *projectFilename = nil;

                            if([filename isEqualToString:@"project.pbxproj"]) {
                                if([fm fileExistsAtPath:filename isDirectory:&isDir]) {
                                    if(!isDir) {
                                        projectFilename = filename;
                                        projectName     = filename.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent.lastPathComponent;
                                    }
                                    else {
                                        NSString *reason = PGFormat(@"ERROR: File is a directory: \"%@\"\n", path);
                                        error = [NSError errorWithDomain:PGProjErrorDomain code:PBX_INVALID_PROJECT_FILENAME userInfo:@{ NSLocalizedDescriptionKey: reason }];
                                        setpptr(pError, error);
                                        return nil;
                                    }
                                }
                                else {
                                    NSString *reason = PGFormat(@"ERROR: File does not exist: \"%@\"\n", path);
                                    error = [NSError errorWithDomain:PGProjErrorDomain code:PBX_INVALID_PROJECT_FILENAME userInfo:@{ NSLocalizedDescriptionKey: reason }];
                                    setpptr(pError, error);
                                    return nil;
                                }
                            }
                            else {
                                NSArray   *files = PGFindByName(path, @"project.pbxproj", &error);
                                NSInteger rc     = (files ? parseFindProjectResults(path, files, &projectName, &projectFilename, &error) : error.code);

                                if(rc) {
                                    setpptr(pError, error);
                                    return nil;
                                }
                            }

                            if(projectName.length && projectFilename.length) {
                                NSString      *projectPath = projectFilename.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent;
                                PGProjectFile *projectFile = [[PGProjectFile alloc] initWithProjectName:projectName projectPath:projectPath error:&error];

                                if(projectFile) {
                                    [projectsList addObject:projectFile];
                                }
                                else {
                                    setpptr(pError, error);
                                    return nil;
                                }
                            }
                            else {
                                NSString *reason = PGFormat(@"ERROR: No project found in path: \"%@\"\n", path);
                                setpptr(pError, [NSError errorWithDomain:PGProjErrorDomain code:PBX_NO_PROJECT_FILE_FOUND userInfo:@{ NSLocalizedDescriptionKey: reason }]);
                                return nil;
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
