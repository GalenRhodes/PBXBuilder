//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import <Moscow/Moscow.h>
#import <PBX/PBX.h>
#import "PGRunInfo.h"
#import "PBXTools.h"

int pbxBuilder() {
    int       returnCode = 0;
    NSError   *error     = nil;
    PGRunInfo *runInfo   = [[PGRunInfo alloc] init:&error];

    if(runInfo) {
        PGPrintStr(@"\nBuilding the following project(s):\n");
        for(PBXProjectFile *projectFile in runInfo.projects) PGPrintf(@"    Project: %@\n", projectFile.projectName);
    }
    else {
        PGPrintf(@"\nERROR: %@; %@\n", @(error.code), error.localizedDescription);

        if(error.code == PBX_MULTIPLE_PROJECT_FILES_FOUND) {
            NSArray<NSArray<NSString *> *> *foundFiles = error.userInfo[PGFoundProjectFilesKey];
            NSUInteger                     maxLength   = 0, x = 0;

            for(NSArray<NSString *> *f in foundFiles) {
                maxLength = MAX(maxLength, f[0].length);
            }

            for(NSArray<NSString *> *f in foundFiles) {
                NSString *projnam = [f[0] stringByPaddingToLength:maxLength withString:@" " startingAtIndex:0];
                PGPrintf(@"%2lu> %@ ==> \"%@\"\n", ++x, projnam, f[1]);
            }

            PGPrintStr(@"\n");
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

