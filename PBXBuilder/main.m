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

int main(int argc, const char *argv[]) {
    int returnCode = 0;

    @autoreleasepool {
        NSError   *error   = nil;
        PGRunInfo *runInfo = [[PGRunInfo alloc] initWithCommandLine:argv argCount:argc error:&error];

        if(runInfo) {
            PGPrintStr(@"\nBuilding the following project(s):\n");

            for(PBXProjectFile *projectFile in runInfo.projects) {
                PGPrintf(@"     Project: %@\n", projectFile.projectName);

                if(projectFile.project.targets.count) {
                    for(PBXTarget *target in projectFile.project.targets) {
                        NSUInteger depCount = target.dependencies.count;

                        PGPrintf(@"     +------------------------------------------------------------------------------------\n");
                        PGPrintf(@"     |        Target: %@\n", target.productName);

                        if(depCount) {
                            PGPrintf(@"     |        %li %@>\n", depCount, depCount == 1 ? @"Dependency" : @"Dependencies");

                            for(PBXTargetDependency *dep in target.dependencies) {
                                PBXNativeTarget       *nativeTarget = dep.target;
                                PBXContainerItemProxy *proxy        = dep.targetProxy;

                                PGPrintf(@"     |        +---------------------------------------------------------------------------\n");
                                PGPrintf(@"     |        |             Name: %@\n", nativeTarget.name);
                                PGPrintf(@"     |        |     Product Name: %@\n", nativeTarget.productName);
                                PGPrintf(@"     |        |     Product Type: %@\n", nativeTarget.productTypeDescription);

                                if(proxy) {
                                    PGPrintf(@"     |        |       Proxy Type: %li\n", proxy.proxyType);
                                    PGPrintf(@"     |        | Container Portal: %@\n", proxy.containerPortal.projectFile.projectName ?: @"<N/A>");
                                }
                            }

                            PGPrintf(@"     |        +---------------------------------------------------------------------------\n");
                        }
                        else {
                            PGPrintf(@"     |        %@>\n", @"No Dependencies");
                        }
                    }

                    PGPrintf(@"     +------------------------------------------------------------------------------------\n");
                }

                // PGPrintf(@"\n%@\n", projectFile.project.description);
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

