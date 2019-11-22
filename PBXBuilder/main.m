//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import <Moscow/Moscow.h>

NSString const *xcodePluginsPath = @"/Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins";
NSString const *clangXcodeMap    = @"Clang LLVM 1.0.xcplugin/Contents/Resources/Clang LLVM 1.0.xcspec";

int main(int argc, const char *argv[]) {
    int returnCode = 0;

    @autoreleasepool {
//        NSError   *error   = nil;
//        PGRunInfo *runInfo = [[PGRunInfo alloc] initWithCommandLine:argv argCount:argc error:&error];
//
//        if(!runInfo) {
//            PGPrintf(@"Error: %@\n", error.localizedDescription);
//            return (int)error.code;
//        }
//
//        NSString *pbxProjPath1  = @"~/Projects/2019/PBXBuilder/PBXBuilder.xcodeproj/project.pbxproj";
//        NSString *plistFilename = pbxProjPath1.stringByExpandingTildeInPath;
//
//        PGPrintf(@"Reading: %@\n", plistFilename);
//
//        NSData *plistData = [NSData dataWithContentsOfFile:plistFilename options:NSDataReadingMappedIfSafe error:&error];
//
//        if(!plistData) {
//            PGPrintf(@"Error: %@\n", error.localizedDescription);
//            return (int)error.code;
//        }

    }

    return returnCode;
}

