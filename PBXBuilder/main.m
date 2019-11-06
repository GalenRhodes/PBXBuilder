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
        NSString             *pbxProjPath2 = PGFormat(@"%@/%@", xcodePluginsPath, clangXcodeMap);
        NSError              *error        = nil;
        NSInputStream        *stream       = [NSInputStream inputStreamWithFileAtPath:pbxProjPath1.stringByExpandingTildeInPath];

        [stream open];
        while(stream.streamStatus == NSStreamStatusOpening);

        if(stream.streamStatus == NSStreamStatusError) {
            NSLog(@"Error: %@", stream.streamError.localizedDescription);
            returnCode = 1;
        }
        else {
            NSDictionary<NSString *, id> *data = [NSPropertyListSerialization propertyListWithStream:stream options:NSPropertyListImmutable format:&pbxFormat error:&error];
            //PGPrintPlist(data);

        }
    }

    return returnCode;
}
