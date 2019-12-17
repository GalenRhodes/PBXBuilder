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
        PGPrintf(@"    Project: %@\n", runInfo.projectToBuild.projectName);
    }
    else {
        PGPrintf(@"\n%@; %@\n", @(error.code), error.localizedDescription);

        if(error.code == PBX_MULTIPLE_PROJECTS_FOUND) {
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

NSDictionary<NSString *, NSString *> *locateFiles2(NSString *dir) {
    NSMutableDictionary<NSString *, NSString *> *results  = [NSMutableDictionary new];
    NSDirectoryEnumerator                       *dirEnum  = [NSFileManager.defaultManager enumeratorAtPath:dir];
    NSString                                    *filename = dirEnum.nextObject;

    PGPrintf(@"\nEnumerating Across: %@\n\n", dir);

    while(filename) {
        NSError      *error        = nil;
        NSString     *fullFilename = PGFormat(@"%@/%@", dir, filename);
        NSDictionary *attrs        = dirEnum.fileAttributes;

        if([@"project.pbxproj" isEqualToString:filename.lastPathComponent]) {
            PGPrintf(@"> %@\n", fullFilename);
            NSString *a = fullFilename.stringByDeletingLastPathComponent.lastPathComponent;
            PGPrintf(@"> %@\n", a);

            if([@"xcodeproj" isEqualToString:a.pathExtension]) {
                results[a.stringByDeletingPathExtension] = fullFilename;
            }
        }
        else if([NSFileTypeSymbolicLink isEqualToString:attrs[NSFileType]]) {
            NSString     *newFullFilename = fullFilename.stringByResolvingSymlinksInPath;
            NSDictionary *_attrs          = [NSFileManager.defaultManager attributesOfItemAtPath:newFullFilename error:&error];

            if([NSFileTypeDirectory isEqualToString:_attrs[NSFileType]]) {
                NSDictionary<NSString *, NSString *> *subResults = locateFiles2(newFullFilename);
                if(subResults.count) [results addEntriesFromDictionary:subResults];
            }
        }

        filename = dirEnum.nextObject;
    }

    return results;
};

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSDictionary<NSString *, NSString *> *z = locateFiles2(NSFileManager.defaultManager.currentDirectoryPath);

        PGPrintf(@"Located %lu project(s):\n", z.count);

        [z enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
            PGPrintf(@"   %@ ====> %@\n", key, obj);
        }];

        return 0;
        // return pbxBuilder();
    }
}

