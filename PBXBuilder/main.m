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
        NSPropertyListFormat pbxFormat     = NSPropertyListOpenStepFormat;
        NSString             *pbxProjPath1 = @"~/Projects/2019/PBXBuilder/PBXBuilder.xcodeproj/project.pbxproj";
        // NSString             *pbxProjPath1 = [NSString stringWithUTF8String:argv[1]];
        // NSString             *pbxProjPath2 = PGFormat(@"%@/%@", xcodePluginsPath, clangXcodeMap);
        NSError              *error        = nil;

        NSLog(@"Reading: %@", pbxProjPath1.stringByExpandingTildeInPath);

        NSData *plistData = [NSData dataWithContentsOfFile:pbxProjPath1.stringByExpandingTildeInPath options:NSDataReadingMappedIfSafe error:&error];

        if(!plistData) {
            NSLog(@"Error: %@", error.localizedDescription);
            returnCode = 1;
        }
        else {
            NSDictionary<NSString *, id> *data = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:&pbxFormat error:&error];
            PGPrintPlist(data);

            NSLog(@"Error: %@", error);

            for(NSString *s in data.keyEnumerator) {
                NSLog(@"Key: %@", s);
                [PGFormat(@"Key: %@\n", s) writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:nil];
            }

            //NSLog(@"data: %@", data.description);
            //NSLog(@"data: %@", data.description);
        }
    }

    return returnCode;
}
