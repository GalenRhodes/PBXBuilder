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
            NSArray<NSString *>      *arguments = NSProcessInfo.processInfo.arguments;
            NSEnumerator<NSString *> *argEnum   = arguments.objectEnumerator;

            _programPath = argEnum.nextObject.stringByMakingAbsolutePath;
            if(_programPath == nil) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Program path missing" userInfo:nil];

            if((_gnustepInfo = [GNUstepInfo info:pError]) == nil) return nil;
            if((_projects    = [self parseCommandLine:argEnum pError:pError]) == nil) return nil;
#ifdef DEBUG
            PGPrintStr([self description]);
#endif
        }

        return self;
    }

    -(NSArray<PBXProjectFile *> *)parseCommandLine:(NSEnumerator<NSString *> *)argEnum pError:(NSError **)pError {
        NSMutableArray<PBXProjectFile *> *projectsList = [NSMutableArray new];
        NSString                         *arg          = argEnum.nextObject.trim;

        while(arg) {
            if([arg isEqualToString:@"-"]) {
                setpptr(pError, pbxMakeError(PBX_UNKNOWN_CMDLINE_OPTION, PGFormat(@"Unrecognized command-line options: \"%@\"", arg), nil));
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
                            setpptr(pError, pbxMakeError(PBX_INVALID_PROJECT_FILENAME, PGFormat(@"ERROR: File is a directory: \"%@\"\n", path), nil));
                            return nil;
                        }
                    }
                    else {
                        setpptr(pError, pbxMakeError(PBX_INVALID_PROJECT_FILENAME, PGFormat(@"ERROR: File does not exist: \"%@\"\n", path), nil));
                        return nil;
                    }
                }
                else {
                    NSError   *error = nil;
                    NSArray   *files = PGFindByName(path, @"project.pbxproj", &error);
                    NSInteger rc     = (files ? parseFindProjectResults(path, files, &projectName, &projectFilename, &error) : error.code);

                    if(rc) {
                        setpptr(pError, error);
                        return nil;
                    }
                }

                if(projectName.length && projectFilename.length) {
                    NSString       *projectPath = projectFilename.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent;
                    PBXProjectFile *projectFile = [PBXProjectFile projectFileWithName:projectName path:projectPath error:pError];

                    if(projectFile) {
                        [projectsList addObject:projectFile];
                    }
                    else {
                        return nil;
                    }
                }
                else {
                    setpptr(pError, pbxMakeError(PBX_NO_PROJECT_FILE_FOUND, PGFormat(@"ERROR: No project found in path: \"%@\"\n", path), nil));
                    return nil;
                }
            }

            arg = argEnum.nextObject.trim;
        }

        return projectsList;
    }

    +(instancetype)runInfo:(NSError **)pError {
        return [[self alloc] init:pError];
    }

    -(NSString *)workingDir {
        return NSFileManager.defaultManager.currentDirectoryPath;
    }

    -(NSString *)description {
        NSMutableString *str = [NSMutableString stringWithFormat:@"  Application Name: \"%@\"", self.programPath];
        [str appendFormat:@"\n Working Directory: \"%@\"", self.workingDir];
        [self appendGNUstepInfo:str];
        [self appendProjects:str];
        return str;
    }

    -(void)appendGNUstepInfo:(NSMutableString *)str {
        [str appendString:@"\nGNUstep parameters:"];
        [str appendString:@"\n|__________________|"];

        NSString            *s = self.gnustepInfo.description;
        NSArray<NSString *> *l = [s split:@"\\r\\n?|\\n"];
        if(l.count == 0) l = @[ s ];
        for(NSString *sl in l) [str appendFormat:@"\n    | %@", sl];
    }

    -(void)appendProjects:(NSMutableString *)str {
        [str appendString:@"\n          Projects:"];
        [str appendString:@"\n          |________|"];
        NSArray<PBXProjectFile *> *projects = self.projects;
        NSUInteger                y         = projects.count;

        if(y > 0)
            for(NSUInteger x = 0; x < y; ++x) {
                [str appendFormat:@"\n               | %2lu> %@ (%@)", (x + 1), projects[x].projectName, projects[x].projectPath];
            }
        else [str appendString:@"\n               | <none>"];
    }

@end
