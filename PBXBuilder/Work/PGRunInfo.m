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

#import <Moscow/Moscow.h>
#import <PBX/PBX.h>
#import "PGRunInfo.h"
#import "GNUstepInfo.h"
#import "PBXTools.h"

@implementation PGRunInfo {
    }

    -(instancetype)init:(NSError **)pError {
        self = [super init];

        if(self) {
            NSError                  *error     = nil;
            NSArray<NSString *>      *arguments = NSProcessInfo.processInfo.arguments;
            NSEnumerator<NSString *> *argEnum   = arguments.objectEnumerator;

            _programPath = argEnum.nextObject.stringByMakingAbsolutePath;

            if(_programPath == nil) {
                NSString *reason = @"There has to be at least one command-line argument.";
                setpptr(pError, [NSError errorWithDomain:PGProjErrorDomain code:100 userInfo:@{ NSLocalizedDescriptionKey: reason }]);
                return nil;
            }

            _gnustepInfo = [GNUstepInfo info:&error];
#ifdef DEBUG
            PGPrintStr([self description]);
#endif
            NSMutableArray<PBXProjectFile *> *projectsList = [NSMutableArray new];
            NSString                         *arg          = argEnum.nextObject.trim;

            while(arg) {
                if([arg isEqualToString:@"-"]) {
                    NSString *reason = PGFormat(@"Unrecognized command-line options: \"%@\"", arg);
                    setpptr(pError, [NSError errorWithDomain:PGProjErrorDomain code:100 userInfo:@{ NSLocalizedDescriptionKey: reason }]);
                    return nil;
                }
                else if(arg.length) {
                    NSFileManager *fm              = NSFileManager.defaultManager;
                    NSString      *path            = arg.stringByMakingAbsolutePath;
                    NSString      *filename        = path.lastPathComponent;
                    NSString      *projectName     = nil;
                    NSString      *projectFilename = nil;
                    BOOL          isDir            = NO;

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
                        NSString       *projectPath = projectFilename.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent;
                        PBXProjectFile *projectFile = [[PBXProjectFile alloc] initWithProjectName:projectName projectPath:projectPath error:&error];

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

                arg = argEnum.nextObject.trim;
            }

            _projects = projectsList;
        }

        return self;
    }

    -(NSString *)description {
        NSMutableString *s = [NSMutableString stringWithFormat:@"Application Name: \"%@\"\n", _programPath];

        [s appendString:@"Getting GNUstep parameters...\n"];
        [s appendFormat:@"\nConfig: \"%@\"\n", _gnustepInfo.gnustepConfig];

        [s appendString:@"\nCompiler Flags:\n"];
        [self appendOptions:_gnustepInfo.objcOpts buffer:s];

        [s appendString:@"\nBase Linker Flags:\n"];
        [self appendOptions:_gnustepInfo.linkBaseOpts buffer:s];

        [s appendString:@"\nGUI Linker Flags:\n"];
        [self appendOptions:_gnustepInfo.linkGuiOpts buffer:s];

        [s appendFormat:@"\n%20s: %lu\n", "cpuCount", _gnustepInfo.cpuCount];
        [s appendFormat:@"%20s: \"%@\"\n", "ccPath", _gnustepInfo.ccPath];
        [s appendFormat:@"%20s: \"%@\"\n", "cxxPath", _gnustepInfo.cxxPath];
        [s appendFormat:@"%20s: \"%@\"\n", "applcationPath", _gnustepInfo.applcationPath];
        [s appendFormat:@"%20s: \"%@\"\n", "toolsPath", _gnustepInfo.toolsPath];
        [s appendFormat:@"%20s: \"%@\"\n", "libraryPath", _gnustepInfo.libraryPath];
        [s appendFormat:@"%20s: \"%@\"\n", "headersPath", _gnustepInfo.headersPath];
        [s appendFormat:@"%20s: \"%@\"\n", "libsPath", _gnustepInfo.libsPath];
        [s appendFormat:@"%20s: \"%@\"\n", "docPath", _gnustepInfo.docPath];
        [s appendFormat:@"%20s: \"%@\"\n", "manPath", _gnustepInfo.manPath];
        [s appendFormat:@"%20s: \"%@\"\n", "infoPath", _gnustepInfo.infoPath];

        return s;
    }

    -(void)appendOptions:(NSArray<NSString *> *)opts buffer:(NSMutableString *)b {
        NSUInteger   c = 0;
        for(NSString *s in opts) [b appendFormat:@"%2lu> %@\n", ++c, s];
    }

@end
