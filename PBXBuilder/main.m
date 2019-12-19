//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import <Moscow/Moscow.h>
#import <PBX/PBX.h>
#import "PBXRunInfo.h"
#import "PBXTools.h"
#import "PBXStrings.h"
#import "PBXBuilderErrorMessages.h"

NSString *const PBXFormat1 = @"    ] %@\n";
NSString *const PBXFormat2 = @"    ] %@: %@\n";
NSString *const PBXFormat3 = @"    ] %@:[%@]; %@:[%@]\n";
NSString *const PBXFormat4 = @"\n%@: %@";
NSString *const PBXFormat5 = @"\n%@:";
NSString *const PBXFormat6 = @"\n\n%@: %@...\n";

NSString *const PBXMessageDoubleLF = @"\n\n";
NSString *const PBXMessageSingleLF = @"\n";

NSString *const PBXPrintError            = @"\nERROR: (%@) - %@\n";
NSString *const PBXPrintErrorProjectList = @"%2lu> %@ ==> \"%@\"\n";

int printError(int returnCode, NSError *error) {
    PGPrintf(PBXPrintError, @(error.code), error.localizedDescription);
    return (returnCode ?: (int)error.code);
}

int pbxBuildNativeTarget(PBXNativeTarget *target, PBXRunInfo *runInfo, NSError **error) {
    for(PBXBuildPhase *buildPhase in target.buildPhases) {
        PGPrintf(PBXFormat3, PBXMessageTarget, target.name, PBXMessageBuildPhase, NSStringFromClass(buildPhase.class));
    }
    return 0;
}

int pbxBuildTarget(PBXTarget *target, PBXRunInfo *runInfo, NSError **error) {
    if(target && ![runInfo hasTargetBeenBuilt:target.name]) {
        for(PBXTargetDependency *dep in target.dependencies) {
            int res = pbxBuildTarget(dep.target, runInfo, error);
            if(res) return res;
        }

        if([target isKindOfClass:PBXNativeTarget.class]) {
            int res = pbxBuildNativeTarget((PBXNativeTarget *)target, runInfo, error);
            if(res) return res;
        }
        else if([target isKindOfClass:PBXAggregateTarget.class]) {
            /*
             * Don't know what to do with these yet...
             */
        }
        else if([target isKindOfClass:PBXLegacyTarget.class]) {
            /*
             * Don't know what to do with these yet...
             */
        }

        [runInfo.builtTargets addObject:target];
    }

    return 0;
}

int pbxBuilder() {
    int        returnCode = 0;
    NSError    *error     = nil;
    PBXRunInfo *runInfo   = [[PBXRunInfo alloc] init:&error];

    if(runInfo) {

        PBXProjectFile          *projectFile = runInfo.projectToBuild;
        // PBXProject              *project     = projectFile.project;
        NSArray < PBXTarget * > *targets     = runInfo.targetsToBuild;
        XCBuildConfiguration    *xcbc        = runInfo.buildConfiguration;
        NSUInteger              i1           = (MAX(PBXMessageTarget.length, PBXMessageConfiguration.length) + 8);

        PGPrintf(PBXFormat5, PBXMessageBuilding);
        PGPrintf(PBXFormat4, PGpLeft(PBXMessageProject, (PBXMessageProject.length + 4)), projectFile.projectName);
        PGPrintf(PBXFormat4, PGpLeft(PBXMessageConfiguration, i1), xcbc.name);
        for(PBXTarget *target in targets) PGPrintf(PBXFormat4, PGpLeft(PBXMessageTarget, i1), target.name);

        PGPrintStr(PBXMessageDoubleLF);

        /*
         * CLEAN ACTION
         */
        if([runInfo.actions containsObject:PBXActionClean]) {
            PGPrintf(PBXFormat6, PBXMessageAction, PBXActionClean.capitalizedString);
            BOOL isDir     = NO;
            BOOL doesExist = [NSFileManager.defaultManager fileExistsAtPath:runInfo.buildDir isDirectory:&isDir];

            if(doesExist && isDir) {
                PGPrintf(PBXFormat2, PBXMessageRemovingBuildDir, runInfo.buildDir);
                if([NSFileManager.defaultManager removeItemAtPath:runInfo.buildDir error:&error]) {
                    PGPrintf(PBXFormat1, PBXMessageSuccess);
                }
                else {
                    PGPrintf(PBXPrintError, @(error.code), error.localizedDescription);
                    return PBX_COCOA_ERROR;
                }
            }
            else if(doesExist && !isDir) {
                NSError *e = pbxMakeError(PBX_DIR_IS_FILE, PGFormat(PBXErrMsgDirIsFile, runInfo.buildDir), nil);
                printError(PBX_DIR_IS_FILE, e);
            }
            else {
                PGPrintf(PBXFormat1, PBXMessageNothingToDo);
            }
        }

        /*
         * BUILD ACTION
         */
        if([runInfo.actions containsObject:PBXActionBuild]) {
            PGPrintf(PBXFormat6, PBXMessageAction, PBXActionBuild.capitalizedString);
            NSFileManager *fm = NSFileManager.defaultManager;

            PGPrintf(PBXFormat2, PBXMessageCreatingBuildDir, runInfo.buildDir);
            if(![fm createDirectoryAtPath:runInfo.buildDir withIntermediateDirectories:YES attributes:nil error:&error]) {
                PGPrintf(PBXPrintError, @(error.code), error.localizedDescription);
                return (int)error.code;
            }

            for(PBXTarget *target in targets) {
                int res = pbxBuildTarget(target, runInfo, &error);
                if(res) {
                    PGPrintf(PBXPrintError, @(error.code), error.localizedDescription);
                    return (int)error.code;
                }
            }
        }

        /*
         * INSTALL ACTION
         */
        if([runInfo.actions containsObject:PBXActionInstall]) {
            PGPrintf(PBXFormat6, PBXMessageAction, PBXActionInstall.capitalizedString);
        }
    }
    else {
        PGPrintf(PBXPrintError, @(error.code), error.localizedDescription);

        if(error.code == PBX_MULTIPLE_PROJECTS_FOUND) {
            NSDictionary<NSString *, NSString * > *foundFiles = error.userInfo[PGFoundProjectFilesKey];
            NSUInteger                            maxLength   = 0, x = 0;

            for(NSString *key in foundFiles.allKeys) maxLength = MAX(maxLength, key.length);
            for(NSString *key in foundFiles.allKeys) PGPrintf(PBXPrintErrorProjectList, ++x, [key stringByPaddingToLength:maxLength], foundFiles[key]);
            PGPrintStr(PBXMessageSingleLF);
        }

        returnCode = (int)error.code;
    }

    return returnCode;
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        return pbxBuilder();
    }
}

