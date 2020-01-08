//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import <Moscow/Moscow.h>
#import <PBX/PBX.h>
#import "PBXTools.h"

const NSUInteger T = 4;

NSInteger pbxBuilder() {
    NSInteger  returnCode = 0;
    NSError    *error     = nil;
    PBXRunInfo *runInfo   = [[PBXRunInfo alloc] init:&error];

    if(runInfo) {
        PBXProjectFile *projectFile = runInfo.projectToBuild;

        PGPrintf(PBXFormat3, PBXMessageProject, projectFile.projectName, 1, @"Path", projectFile.projectPath);

#ifdef DEBUG
        PBXProject *project = projectFile.project;

        for(XCBuildConfiguration *buildConfig in project.buildConfigurationList.buildConfigurations) {
            PGPrintf(PBXFormat3, PBXMessageProject, projectFile.projectName, 1, PBXMessageConfiguration, buildConfig.name);
            [buildConfig debugPrint];
        }
#endif

        NSArray<PBXTarget *> *targets = runInfo.targetsToBuild;
        NSString             *xcbc    = runInfo.buildConfigurationName;
        NSUInteger           i1       = (MAX(PBXMessageTarget.length, PBXMessageConfiguration.length) + (T * 2));

        PGPrintf(PBXFormat5, PBXMessageBuilding);
        PGPrintf(PBXFormat4, PGpLeft(PBXMessageProject, (PBXMessageProject.length + T)), projectFile.projectName);
        PGPrintf(PBXFormat4, PGpLeft(PBXMessageConfiguration, i1), xcbc);
        for(PBXTarget *target in targets) PGPrintf(PBXFormat4, PGpLeft(PBXMessageTarget, i1), target.name);

        PGPrintStr(PBXMessageDoubleLF);

        /*
         * CLEAN ACTION
         */
        if([runInfo.actions containsObject:PBXActionClean]) {
            projectFile.userInfo[PBX_UI_CURRENT_ACTION] = PBXActionClean;
            PGPrintf(PBXFormat6, PBXMessageAction, PGFormat(PBXFormat11, PBXActionClean.capitalizedString));
            PGPrintf(PBXFormat7, PBXMessageRemoving, PGFormat(PBXFormat10, PBXMessageBuildDirectory, runInfo.buildDir), PBXMessageWorking);

            BOOL isDir     = NO;
            BOOL doesExist = [NSFileManager.defaultManager fileExistsAtPath:runInfo.buildDir isDirectory:&isDir];

            if(doesExist && isDir) {
                if([NSFileManager.defaultManager removeItemAtPath:runInfo.buildDir error:&error]) PGPrintf(PBXFormat8, PBXMessageSuccess);
                else return printError2(PBX_COCOA_ERROR, error);
            }
            else if(doesExist && !isDir) return printError2(pbxMakeError(PBX_DIR_IS_FILE, PGFormat(PBXErrMsgDirIsFile, runInfo.buildDir), nil));
            else PGPrintf(PBXFormat8, PBXMessageNothingToDo);
        }

        /*
         * BUILD ACTION
         */
        if([runInfo.actions containsObject:PBXActionBuild]) {
            projectFile.userInfo[PBX_UI_CURRENT_ACTION] = PBXActionBuild;
            PGPrintf(PBXFormat6, PBXMessageAction, PGFormat(PBXFormat11, PBXActionBuild.capitalizedString));
            PGPrintf(PBXFormat7, PBXMessageCreating, PGFormat(PBXFormat10, PBXMessageBuildDirectory, runInfo.buildDir), PBXMessageWorking);

            NSFileManager *fm = NSFileManager.defaultManager;

            if([fm createDirectoryAtPath:runInfo.buildDir withIntermediateDirectories:YES attributes:nil error:&error]) PGPrintf(PBXFormat8, PBXMessageSuccess);
            else return printError2(error);

            for(PBXTarget *target in targets) {
                NSInteger res = [target build:runInfo error:&error];
                if(res) return printError(error);
            }
        }

        /*
         * INSTALL ACTION
         */
        if([runInfo.actions containsObject:PBXActionInstall]) {
            projectFile.userInfo[PBX_UI_CURRENT_ACTION] = PBXActionInstall;
            PGPrintf(PBXFormat6, PBXMessageAction, PGFormat(PBXFormat11, PBXActionInstall.capitalizedString));
        }
    }
    else {
        returnCode = printError(error);

        if(error.code == PBX_MULTIPLE_PROJECTS_FOUND) {
            NSDictionary<NSString *, NSString * > *foundFiles = error.userInfo[PGFoundProjectFilesKey];
            NSUInteger                            maxLength   = 0, x = 0;

            for(NSString *key in foundFiles.allKeys) maxLength = MAX(maxLength, key.length);
            for(NSString *key in foundFiles.allKeys) PGPrintf(PBXPrintErrorProjectList, ++x, [key stringByPaddingToLength:maxLength], foundFiles[key]);
            PGPrintStr(PBXMessageSingleLF);
        }
    }

    return returnCode;
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        return (int)pbxBuilder();
    }
}

