//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import <Moscow/Moscow.h>

int main(int argc, const char *argv[]) {
    int returnCode = 0;

    @autoreleasepool {
//        NSString *out = nil;
//        NSString *err = nil;
        NSError *error = nil;
//        NSInteger rc = PGExecuteApplication(@"/bin/bash", @[ @"-c", @"printenv" ], &out, &error);

//        PGPrintf(@"Return Code: %li\n", rc);
//        if(error) PGPrintf(@"ERROR: %@ - %@", @(error.code), error.localizedDescription);
//        PGPrintf(@"Output:\n\n%@\n", out);

//        NSDictionary<NSString *, NSString *> *env = NSProcessInfo.processInfo.environment;
//        PGPrintf(@"ENV:\n\n%@\n", env);
//        PGPrintStr(@"ENV:\n\n");
//        [env enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
//            PGPrintf(@"\e[0J\e[0m\e[1;32m%@\e[1;37m=\e[1;36m%@\e[0m\n", key, obj);
//        }];

        PGExecute *exe = [PGExecute exeWithAppPath:@"/bin/bash" arguments:@[ @"-c", @"printenv" ] error:&error];

        if(exe) {
            NSInteger ec = [exe executeAndWaitUntilExit:&error];
            PGPrintf(@"Exit Code: %@\n", @(ec));
            if(exe.lastError) PGPrintf(@"LAST ERROR: (%@) - %@\n", @(exe.lastError.code), exe.lastError.localizedDescription);
            if(error) PGPrintf(@"ERROR: (%@) - %@\n", @(error.code), error.localizedDescription);
            PGPrintf(@"STDOUT:\n%@\n", exe.stdOut);
            PGPrintf(@"STDERR:\n%@\n", exe.stdErr);
        }
        else {
            PGPrintf(@"ERROR: (%@) - %@\n", @(error.code), error.localizedDescription);
        }

//        NSError   *error   = nil;
//        PGRunInfo *runInfo = [[PGRunInfo alloc] initWithCommandLine:argv argCount:argc error:&error];
//
//        if(runInfo) {
//            PGPrintStr(@"\nBuilding the following project(s):\n");
//            for(PBXProjectFile *projectFile in runInfo.projects) PGPrintf(@"    Project: %@\n", projectFile.projectName);
//        }
//        else {
//            PGPrintf(@"\nERROR: %@; %@\n", @(error.code), error.localizedDescription);
//
//            if(error.code == PBX_MULTIPLE_PROJECT_FILES_FOUND) {
//                NSArray<NSArray<NSString *> *> *foundFiles = error.userInfo[PGFoundProjectFilesKey];
//                NSUInteger                     maxLength   = 0, x = 0;
//
//                for(NSArray<NSString *> *f in foundFiles) {
//                    maxLength = MAX(maxLength, f[0].length);
//                }
//
//                for(NSArray<NSString *> *f in foundFiles) {
//                    NSString *projnam = [f[0] stringByPaddingToLength:maxLength withString:@" " startingAtIndex:0];
//                    PGPrintf(@"%2lu> %@ ==> \"%@\"\n", ++x, projnam, f[1]);
//                }
//
//                PGPrintStr(@"\n");
//            }
//
//            returnCode = (int)error.code;
//        }
    }

    return returnCode;
}

