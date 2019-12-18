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

int pbxBuilder() {
    int        returnCode = 0;
    NSError    *error     = nil;
    PBXRunInfo *runInfo   = [[PBXRunInfo alloc] init:&error];

    if(runInfo) {
        PGPrintStr(@"\nBuilding the following project:\n");
        PGPrintf(@"    Project: %@\n", runInfo.projectToBuild.projectName);
    }
    else {
        PGPrintf(@"\n%@; %@\n", @(error.code), error.localizedDescription);

        if(error.code == PBX_MULTIPLE_PROJECTS_FOUND) {
            NSDictionary<NSString *, NSString *> *foundFiles = error.userInfo[PGFoundProjectFilesKey];
            NSUInteger                           maxLength   = 0, x = 0;

            for(NSString *key in foundFiles.allKeys) maxLength = MAX(maxLength, key.length);
            for(NSString *key in foundFiles.allKeys) PGPrintf(@"%2lu> %@ ==> \"%@\"\n", ++x, [key stringByPaddingToLength:maxLength], foundFiles[key]);
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

