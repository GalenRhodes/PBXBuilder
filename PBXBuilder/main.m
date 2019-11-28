//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import <Moscow/Moscow.h>
#import "PGRunInfo.h"
#import "PGProjectFile.h"
#import "PBXTools.h"
#import "PBX.h"

int main(int argc, const char *argv[]) {
    int returnCode = 0;

    @autoreleasepool {
        NSError   *error   = nil;
        PGRunInfo *runInfo = [[PGRunInfo alloc] initWithCommandLine:argv argCount:argc error:&error];

        if(runInfo) {
            PGPrintStr(@"\nBuilding the following project(s):\n");

            for(PGProjectFile *projectFile in runInfo.projects) {
                PGPrintf(@"     - \"%@\"\n", projectFile.projectName);
                PGPrintStr([projectFile.project description]);
            }
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
    }

    return returnCode;
}

