//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Tools.h"

NSString const *xcodePluginsPath = @"/Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins";
NSString const *clangXcodeMap    = @"Clang LLVM 1.0.xcplugin/Contents/Resources/Clang LLVM 1.0.xcspec";

int main(int argc, const char *argv[]) {
    int returnCode = 0;

    @autoreleasepool {
        NSPropertyListFormat pbxFormat      = NSPropertyListOpenStepFormat;
        NSString             *pbxProjPath1  = @"~/Projects/2019/PBXBuilder/PBXBuilder.xcodeproj/project.pbxproj";
        // NSString             *pbxProjPath1 = [NSString stringWithUTF8String:argv[1]];
        // NSString             *pbxProjPath2 = PGFormat(@"%@/%@", xcodePluginsPath, clangXcodeMap);
        NSError              *error         = nil;
        NSString             *plistFilename = pbxProjPath1.stringByExpandingTildeInPath;

        NSLog(@"Reading: %@", plistFilename);

        NSData *plistData = [NSData dataWithContentsOfFile:plistFilename options:NSDataReadingMappedIfSafe error:&error];

        if(!plistData) {
            NSLog(@"Error: %@", error.localizedDescription);
            returnCode = 1;
        }
        else {
            NSDictionary<NSString *, id> *data = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:&pbxFormat error:&error];
            if(!data) NSLog(@"Error: %@", error.localizedDescription);
            PGPrintPlist(data);
        }
    }

    return returnCode;
}
