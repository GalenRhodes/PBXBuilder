/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXRunInfo.m
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
#import "PBXTools.h"

typedef NSMutableArray<NSString *>                                   *PBXToolOptionsList;
typedef NSMutableDictionary<NSNumber *, PBXToolOptionsList>          *PBXToolOptionsMap;
typedef NSMutableDictionary<NSString *, PBXToolOptionsMap>           *PBXBuildPhaseToolOptionsMap;
typedef NSMutableDictionary<NSString *, PBXBuildPhaseToolOptionsMap> *PBXToolOptions;

@implementation PBXRunInfo {
        PBXToolOptions _additionalToolOptions;
    }

    -(instancetype)init:(NSError **)pError {
        self = [super init];

        if(self) {
            NSArray<NSString *> *args    = NSProcessInfo.processInfo.arguments;
            NSUInteger          argc     = args.count;
            BOOL                badStart = ((argc == 0) || ((_programPath = args[0].stringByMakingAbsolutePath) == nil));

            if(badStart) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:PGErrMsgNoProgramPath userInfo:nil];

            _builtTargets          = [NSMutableArray new];
            _additionalToolOptions = [NSMutableDictionary new];
            _targetNameMaxLength   = 0;
            _workingDir            = NSFileManager.defaultManager.currentDirectoryPath;

            if((_gnustepInfo = [GNUstepInfo GNUstepInfo:pError]) == nil) return nil;
            if(![self parseCommandLineArguments:[args subarrayWithRange:NSMakeRange(1, (argc - 1))] pError:pError]) return nil;

            _buildDir = PGFormat(@"%@/build", self.projectToBuild.projectPath);

            for(PBXTarget *target in _projectToBuild.project.targets) _targetNameMaxLength = MAX(_targetNameMaxLength, target.name.length);

            _projectToBuild.userInfo[PBX_UI_BUILD_DIR] = _buildDir;
        }

        return self;
    }

    -(void)addOptionsForTarget:(PBXTarget *)target buildPhase:(PBXBuildPhase *)buildPhase buildTool:(PBXBuildTools)buildTool toolOption:(NSString *)toolOption {
        PBXBuildPhaseToolOptionsMap buildPhaseMap = _additionalToolOptions[target.itemId];
        if(!buildPhaseMap) _additionalToolOptions[target.itemId] = buildPhaseMap = [NSMutableDictionary new];

        PBXToolOptionsMap buildToolMap = buildPhaseMap[buildPhase.itemId];
        if(!buildToolMap) buildPhaseMap[buildPhase.itemId] = buildToolMap = [NSMutableDictionary new];

        PBXToolOptionsList toolOptionList = buildToolMap[@(buildTool)];
        if(!toolOptionList) buildToolMap[@(buildTool)] = toolOptionList = [NSMutableArray new];

        [toolOptionList addObject:toolOption];
    }

    -(NSArray<NSString *> *)getOptionsForTarget:(PBXTarget *)target buildPhase:(PBXBuildPhase *)buildPhase buildTool:(PBXBuildTools)buildTool {
        return ((target && buildPhase) ? (((NSArray<NSString *> *)_additionalToolOptions[target.itemId][buildPhase.itemId][@(buildTool)]) ?: @[]) : @[]);
    }

    -(BOOL)hasTargetBeenBuilt:(NSString *)itemId {
        for(PBXTarget *target in self.builtTargets) if([target.itemId isEqualToString:itemId]) return YES;
        return NO;
    }

    -(BOOL)parseCommandLineArguments:(NSArray<NSString *> *)args pError:(NSError **)pError {
        NSDictionary<NSString *, NSString *> *projects = locateProjectFiles(self.workingDir, NSFileManager.defaultManager);
        if(projects.count) return [self parseCommandLineArguments:args.objectEnumerator withProjects:projects error:pError];
        else return pbxMakeErr(pError, PBX_PROJECT_NOT_FOUND, PGErrMsgNoProjectFound, self.workingDir);
    }

    -(BOOL)parseCommandLineArguments:(NSEnumerator<NSString *> *)enArgs withProjects:(NSDictionary<NSString *, NSString *> *)projects error:(NSError **)pError {
        NSString *arg = enArgs.nextObject;
        if(arg) return [self parseCommandLineArguments:enArgs firstArgument:arg projects:projects error:pError];
        else if(projects.count == 1) return [self setDefaultProjectForNoOptions:projects error:pError];
        else return [self getMultiProjError:projects error:pError];
    }

    -(BOOL)parseCommandLineArguments:(NSEnumerator<NSString *> *)enArgs
                       firstArgument:(NSString *)arg
                            projects:(NSDictionary<NSString *, NSString *> *)projects
                               error:(NSError **)pError {
        NSMutableArray<NSString *> *targetNames = [NSMutableArray new];
        NSMutableArray<NSString *> *actions     = [NSMutableArray new];
        BOOL                       allTargets   = NO;

        _buildConfigurationName = XCBuildConfigNameDefault; // The default.

        while(arg) {
            if([arg isEqualToString:PBXOptionBuildConfig]) {
                NSString *configName = enArgs.nextObject;

                if(!configName) {
                    return pbxMakeErr(pError, PBX_MISSING_BUILD_CONFIG, @"%@", PGErrMsgMissingBuildConfig);
                }
                else if(![XCBuildConfiguration.allBuildConfigurationNames containsObject:configName]) {
                    return pbxMakeErr(pError, PBX_UNKNOWN_BUILD_CONFIG, PGErrMsgUnknownBuildConfig, configName);
                }
                else {
                    _buildConfigurationName = configName;
                }
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
                return pbxMakeErr(pError, PBX_UNKNOWN_CMDLINE_OPTION, PGErrMsgUnknownCmdLineOption, arg);
            }

            arg = enArgs.nextObject;
        }

        /*
         * PROJECT
         */
        if(![self setDefaultProject:projects error:pError]) return NO;
        PBXProject *project     = _projectToBuild.project;
        NSString   *projectName = _projectToBuild.projectName;

        /*
         * TARGETS
         */
        if(![self getTargetsForNames:targetNames allTargets:allTargets project:project projectName:projectName error:pError]) return NO;

        /*
         * ACTIONS
         */
        if(actions.count == 0) _actions = @[ PBXActionBuild ]; else _actions = actions;

        return YES;
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
                if(target) [array addObject:target]; else return pbxMakeErr(pError, PBX_TARGET_NOT_FOUND, PGErrMsgTargetNotFound, targetName, projectName);
            }

            _targetsToBuild = array;
        }

        return YES;
    }

    -(BOOL)setDefaultProject:(NSDictionary<NSString *, NSString *> *)projects error:(NSError **)pError {
        return ((!_projectToBuild) ?
                ((projects.count == 1) ? ((_projectToBuild = [self getFirstProjectFile:projects error:pError]) != nil) : [self getMultiProjError:projects error:pError]) :
                YES);
    }

    -(BOOL)getMultiProjError:(NSDictionary<NSString *, NSString *> *)projects error:(NSError **)pError {
        setpptr(pError, pbxMakeError(PBX_MULTIPLE_PROJECTS_FOUND, PGErrMsgMultipleProjects, @{ PGFoundProjectFilesKey: projects.copy }));
        return NO;
    }

    -(BOOL)setDefaultProjectForNoOptions:(NSDictionary<NSString *, NSString *> *)projects error:(NSError **)pError {
        if((_projectToBuild = [self getFirstProjectFile:projects error:pError])) {
            _targetsToBuild         = _projectToBuild.project.targets.copy;
            _buildConfigurationName = XCBuildConfigNameDefault;
            _actions                = @[ PBXActionBuild ];
            return YES;
        }

        return NO;
    }

    -(PBXProjectFile *)getFirstProjectFile:(NSDictionary<NSString *, NSString *> *)projects error:(NSError **)pError {
        return [PBXProjectFile projectFileWithName:projects.allKeys[0] path:projects.allValues[0] error:pError];
    }

    -(BOOL)handleTargetOption:(NSEnumerator<NSString *> *)enArgs targetNames:(NSMutableArray<NSString *> *)targetNames error:(NSError **)pError {
        NSString *targetName = enArgs.nextObject;

        if(targetName) {
            if(![targetNames containsObject:targetName]) [targetNames addObject:targetName];
            return YES;
        }
        else {
            return pbxMakeErr(pError, PBX_MISSING_TARGET_NAME, @"%@", PGErrMsgMissingTargetName);
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
                return pbxMakeErr(pError, PBX_PROJECT_NOT_FOUND, PGErrMsgProjectNotFound, projectName, self.workingDir);
            }
        }
        else {
            return pbxMakeErr(pError, PBX_MISSING_PROJECT_NAME, @"%@", PGErrMsgMissingProjectName);
        }
    }

    +(instancetype)runInfo:(NSError **)pError {
        return [[self alloc] init:pError];
    }

@end
