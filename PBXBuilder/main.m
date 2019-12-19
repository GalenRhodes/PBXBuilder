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

NSString *const PBXFormat1 = @"    ] %@\n";
NSString *const PBXFormat2 = @"    ] %@: %@\n";
NSString *const PBXFormat3 = @"    ] %@:[%@]; %@:[%@]\n";
NSString *const PBXFormat4 = @"\n%@: %@";
NSString *const PBXFormat5 = @"\n%@:";
NSString *const PBXFormat6 = @"\n\n%@: %@...\n";

NSString *const PBXMessageDoubleLF = @"\n\n";
NSString *const PBXMessageSingleLF = @"\n";

NSString *const PBXPrintErrorProjectList = @"%2lu> %@ ==> \"%@\"\n";

NSInteger pbxBuilder() {
    NSInteger  returnCode = 0;
    NSError    *error     = nil;
    PBXRunInfo *runInfo   = [[PBXRunInfo alloc] init:&error];

    if(runInfo) {

        PBXProjectFile       *projectFile = runInfo.projectToBuild;
        // PBXProject              *project     = projectFile.project;
        NSArray<PBXTarget *> *targets     = runInfo.targetsToBuild;
        XCBuildConfiguration *xcbc        = runInfo.buildConfiguration;
        NSUInteger           i1           = (MAX(PBXMessageTarget.length, PBXMessageConfiguration.length) + (T * 2));

        PGPrintf(PBXFormat5, PBXMessageBuilding);
        PGPrintf(PBXFormat4, PGpLeft(PBXMessageProject, (PBXMessageProject.length + T)), projectFile.projectName);
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
                if([NSFileManager.defaultManager removeItemAtPath:runInfo.buildDir error:&error]) PGPrintf(PBXFormat1, PBXMessageSuccess);
                else return printError(PBX_COCOA_ERROR, error);
            }
            else if(doesExist && !isDir) printError(pbxMakeError(PBX_DIR_IS_FILE, PGFormat(PBXErrMsgDirIsFile, runInfo.buildDir), nil));
            else PGPrintf(PBXFormat1, PBXMessageNothingToDo);
        }

        /*
         * BUILD ACTION
         */
        if([runInfo.actions containsObject:PBXActionBuild]) {
            PGPrintf(PBXFormat6, PBXMessageAction, PBXActionBuild.capitalizedString);
            NSFileManager *fm = NSFileManager.defaultManager;

            PGPrintf(PBXFormat2, PBXMessageCreatingBuildDir, runInfo.buildDir);
            if(![fm createDirectoryAtPath:runInfo.buildDir withIntermediateDirectories:YES attributes:nil error:&error]) return printError(error);

            for(PBXTarget *target in targets) {
                NSInteger res = [target build:runInfo error:&error];
                if(res) return printError(error);
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

