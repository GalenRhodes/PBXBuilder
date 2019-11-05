//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <DiscRecordingUI/DiscRecordingUI.h>

int main(int argc, const char *argv[]) {
    int returnCode = 0;

    @autoreleasepool {
        NSPropertyListFormat pbxFormat    = NSPropertyListOpenStepFormat;
        NSString             *pbxProjPath = @"~/Projects/2019/PBXBuilder/PBXBuilder.xcodeproj/project.pbxproj";
        NSError              *error       = nil;
        NSInputStream        *stream      = [NSInputStream inputStreamWithFileAtPath:pbxProjPath.stringByExpandingTildeInPath];

        [stream open];
        while(stream.streamStatus == NSStreamStatusOpening);

        if(stream.streamStatus == NSStreamStatusError) {
            NSLog(@"Error: %@", stream.streamError.localizedDescription);
            returnCode = 1;
        }
        else {
            NSDictionary<NSString *, id> *data = [NSPropertyListSerialization propertyListWithStream:stream options:NSPropertyListImmutable format:&pbxFormat error:&error];

            id obj = data[@"objectVersion"];
            NSLog(@"objectVersion type> %@; Value> %@", NSStringFromClass([obj class]), [obj description]);

            obj = @(([obj description].integerValue));
            NSLog(@"objectVersion type> %@; Value> %@", NSStringFromClass([obj class]), [obj description]);
        }
    }

    return returnCode;
}
