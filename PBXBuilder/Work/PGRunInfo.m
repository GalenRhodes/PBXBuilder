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

NSString *const PGPBXFilename           = @"project.pbxproj";
NSString *const PBXProjectFileExtension = @"xcodeproj";

NSString *const PGErrMsgNoProgramPath        = @"ERROR: Program path missing";
NSString *const PGErrMsgUnknownCmdLineOption = @"ERROR: Unrecognized command-line options: \"%@\"";
NSString *const PGErrMsgNoProjectFound       = @"ERROR: No project found in path: \"%@\"";
NSString *const PGErrMsgProjectNotFound      = @"ERROR: Project \"%@\" not found in path \"%@\".";
NSString *const PGErrMsgMissingProjectName   = @"ERROR: Missing project name after \"-project\"";
NSString *const PGErrMsgMultipleProjects     = @"ERROR: Multiple projects found. Use the \"-project\" option to specify which project to use.";
NSString *const PGErrMsgMissingTargetName    = @"ERROR: Missing target name after \"-target\"";
NSString *const PGErrMsgTargetNotFound       = @"ERROR: Target \"%@\" not found in project \"%@\"";
NSString *const PGErrMsgUnknownBuildConfig   = @"ERROR: Unknown build configuration: \"%@\"";

NSString *const PBXDefaultBuildConfig = @"Release";

NSString *const PBXActionBuild   = @"build";
NSString *const PBXActionClean   = @"clean";
NSString *const PBXActionInstall = @"install";

NSString *const PBXOptionProject     = @"-project";
NSString *const PBXOptionTarget      = @"-target";
NSString *const PBXOptionAllTargets  = @"-alltargets";
NSString *const PBXOptionBuildConfig = @"-configuration";

NSDictionary<NSString *, NSString *> *locateProjectFiles(NSString *dir, NSFileManager *fm);

void handleSymbolicLink(NSString *symlink, NSMutableDictionary<NSString *, NSString *> *results, NSFileManager *fm);

void handleFilename(NSMutableDictionary<NSString *, NSString *> *results, NSString *fullFilename);

@implementation PGRunInfo {
    }

    -(instancetype)init:(NSError **)pError {
        self = [super init];

        if(self) {
            NSArray<NSString *> *args = NSProcessInfo.processInfo.arguments;
            NSUInteger          argc  = args.count;

            if((argc == 0) || (_programPath = args[0].stringByMakingAbsolutePath) == nil) {
                @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:PGErrMsgNoProgramPath userInfo:nil];
            }
            if((_gnustepInfo = [GNUstepInfo info:pError]) == nil) return nil;
            if(![self parseCommandLineArguments:[args subarrayWithRange:NSMakeRange(1, (argc - 1))] pError:pError]) return nil;
        }

        return self;
    }

    -(BOOL)parseCommandLineArguments:(NSArray<NSString *> *)args pError:(NSError **)pError {
        NSDictionary<NSString *, NSString *> *projects = locateProjectFiles(self.workingDir, NSFileManager.defaultManager);

        if(projects.count) {
            NSEnumerator<NSString *> *enArgs = args.objectEnumerator;
            NSString                 *arg    = enArgs.nextObject;

            if(arg) {
                return [self parseCommandLineArguments:enArgs firstArgument:arg projects:projects error:pError];
            }
            else if(projects.count == 1) {
                if((_projectToBuild = [PBXProjectFile projectFileWithName:projects.allKeys[0] path:projects.allValues[0] error:pError])) {
                    _targetsToBuild     = _projectToBuild.project.targets.copy;
                    _buildConfiguration = _projectToBuild.project.buildConfigurationList.defaultConfiguration;
                    _actions            = @[ PBXActionBuild ];
                    return YES;
                }
            }
            else {
                setpptr(pError, pbxMakeError(PBX_MULTIPLE_PROJECTS_FOUND, PGErrMsgMultipleProjects, nil));
            }
        }
        else {
            setpptr(pError, pbxMakeError(PBX_PROJECT_NOT_FOUND, PGFormat(PGErrMsgNoProjectFound, self.workingDir), nil));
        }

        return NO;
    }

    -(BOOL)parseCommandLineArguments:(NSEnumerator<NSString *> *)enArgs
                       firstArgument:(NSString *)arg
                            projects:(NSDictionary<NSString *, NSString *> *)projects
                               error:(NSError **)pError {
        NSMutableArray<NSString *> *targetNames = [NSMutableArray new];
        NSMutableArray<NSString *> *actions     = [NSMutableArray new];
        NSString                   *configName  = PBXDefaultBuildConfig; // The default.
        BOOL                       allTargets   = NO;

        while(arg) {
            if([arg isEqualToString:PBXOptionBuildConfig]) {
                configName = arg;
            }
            else if([arg isEqualToString:PBXOptionProject]) {
                if(![self handleProjectOption:enArgs projects:projects error:pError]) return NO;
            }
            else if([arg isEqualToString:PBXOptionTarget]) {
                if(![self handleTargetOption:enArgs targetNames:targetNames error:pError]) return NO;
            }
            else if([arg isEqualToString:PBXOptionAllTargets]) {
                allTargets = YES;
            }
            else if([arg isEqualToString:PBXActionClean] || [arg isEqualToString:PBXActionBuild] || [arg isEqualToString:PBXActionInstall]) {
                if(![actions containsObject:arg]) [actions addObject:arg];
            }
            else {
                setpptr(pError, pbxMakeError(PBX_UNKNOWN_CMDLINE_OPTION, PGFormat(PGErrMsgUnknownCmdLineOption, arg), nil));
                return NO;
            }

            arg = enArgs.nextObject;
        }

        /*
         * PROJECT
         */
        if(![self getDefaultProject:projects error:pError]) return NO;
        PBXProject *project     = _projectToBuild.project;
        NSString   *projectName = _projectToBuild.projectName;

        /*
         * TARGETS
         */
        if(![self getTargetsForNames:targetNames allTargets:allTargets project:project projectName:projectName error:pError]) return NO;

        /*
         * BUILD CONFIGURATION
         */
        if(![self getBuildConfigForName:configName project:project error:pError]) return NO;

        /*
         * ACTIONS
         */
        if(actions.count == 0) _actions = @[ PBXActionBuild ]; else _actions = actions;

        return YES;
    }

    -(BOOL)getBuildConfigForName:(NSString *)configName project:(PBXProject *)project error:(NSError **)pError {
        if((_buildConfiguration = [project.buildConfigurationList buildConfigurationForName:(configName ?: PBXDefaultBuildConfig)])) return YES;
        setpptr(pError, pbxMakeError(PBX_UNKNOWN_BUILD_CONFIG, PGFormat(PGErrMsgUnknownBuildConfig, configName), nil));
        return NO;
    }

    -(BOOL)getTargetsForNames:(NSMutableArray<NSString *> *)names
                   allTargets:(BOOL)allTargets
                      project:(PBXProject *)project
                  projectName:(NSString *)projectName
                        error:(NSError **)pError {
        if(allTargets || (names.count == 0)) {
            /*
             * By default do all the targets
             */
            _targetsToBuild = project.targets.copy;
        }
        else {
            NSMutableArray<PBXTarget *> *array = [NSMutableArray new];

            for(NSString *targetName in names) {
                PBXTarget *target = [project targetWithName:targetName];

                if(target) {
                    [array addObject:target];
                }
                else {
                    setpptr(pError, pbxMakeError(PBX_TARGET_NOT_FOUND, PGFormat(PGErrMsgTargetNotFound, targetName, projectName), nil));
                    return NO;
                }
            }

            _targetsToBuild = array;
        }

        return YES;
    }

    -(BOOL)getDefaultProject:(NSDictionary<NSString *, NSString *> *)projects error:(NSError **)pError {
        if(!_projectToBuild) {
            if(projects.count == 1) {
                return ((_projectToBuild = [PBXProjectFile projectFileWithName:projects.allKeys[0] path:projects.allValues[0] error:pError]) != nil);
            }
            else {
                setpptr(pError, pbxMakeError(PBX_MULTIPLE_PROJECTS_FOUND, PGErrMsgMultipleProjects, nil));
                return NO;
            }
        }

        return YES;
    }

    -(BOOL)handleTargetOption:(NSEnumerator<NSString *> *)enArgs targetNames:(NSMutableArray<NSString *> *)targetNames error:(NSError **)pError {
        NSString *targetName = enArgs.nextObject;

        if(targetName) {
            if(![targetNames containsObject:targetName]) [targetNames addObject:targetName];
            return YES;
        }
        else {
            setpptr(pError, pbxMakeError(PBX_MISSING_TARGET_NAME, PGErrMsgMissingTargetName, nil));
            return NO;
        }
    }

    -(BOOL)handleProjectOption:(NSEnumerator<NSString *> *)enArgs projects:(NSDictionary<NSString *, NSString *> *)projects error:(NSError **)pError {
        NSString *projectName = enArgs.nextObject;

        if(projectName) {
            NSString *projectPath = projects[projectName];

            if(projectPath) {
                return ((_projectToBuild = [PBXProjectFile projectFileWithName:projectName path:projectPath error:pError]) != nil);
            }
            else {
                setpptr(pError, pbxMakeError(PBX_PROJECT_NOT_FOUND, PGFormat(PGErrMsgProjectNotFound, projectName, self.workingDir), nil));
                return NO;
            }
        }
        else {
            setpptr(pError, pbxMakeError(PBX_MISSING_PROJECT_NAME, PGErrMsgMissingProjectName, nil));
            return NO;
        }
    }

    +(instancetype)runInfo:(NSError **)pError {
        return [[self alloc] init:pError];
    }

@end

NSDictionary<NSString *, NSString *> *locateProjectFiles(NSString *dir, NSFileManager *fm) {
    NSMutableDictionary<NSString *, NSString *> *results  = [NSMutableDictionary new];
    NSDirectoryEnumerator                       *dirEnum  = [fm enumeratorAtPath:dir];
    NSString                                    *filename = dirEnum.nextObject;

    while(filename) {
        NSString     *fullFilename = [dir stringByAppendingPathComponent:filename];
        NSDictionary *attrs        = dirEnum.fileAttributes;

        if([fullFilename.lastPathComponent isEqualToString:PGPBXFilename]) {
            handleFilename(results, fullFilename);
        }
        else if([attrs.fileType isEqualToString:NSFileTypeSymbolicLink]) {
            handleSymbolicLink(fullFilename, results, fm);
        }

        filename = dirEnum.nextObject;
    }

    return results;
}

void handleFilename(NSMutableDictionary<NSString *, NSString *> *results, NSString *fullFilename) {
    NSString *a = fullFilename.stringByDeletingLastPathComponent.lastPathComponent;
    if([a.pathExtension isEqualToString:PBXProjectFileExtension]) results[a.stringByDeletingPathExtension] = fullFilename;
}

void handleSymbolicLink(NSString *symlink, NSMutableDictionary<NSString *, NSString *> *results, NSFileManager *fm) {
    NSError  *error    = nil;
    NSString *filename = [fm destinationOfSymbolicLinkAtPath:symlink error:&error];

    if(filename) {
        NSDictionary *subAttrs = [fm attributesOfItemAtPath:filename error:&error];

        if([subAttrs.fileType isEqualToString:NSFileTypeDirectory]) {
            NSDictionary<NSString *, NSString *> *subResults = locateProjectFiles(filename, fm);
            if(subResults.count) [results addEntriesFromDictionary:subResults];
        }
    }
};

