//
//  main.m
//  PBXBuilder
//
//  Created by Galen Rhodes on 11/4/19.
//  Copyright © 2019 Project Galen. All rights reserved.
//

#import "Tools.h"
#import "GNUstepInfo.h"

NSString const *xcodePluginsPath = @"/Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins";
NSString const *clangXcodeMap    = @"Clang LLVM 1.0.xcplugin/Contents/Resources/Clang LLVM 1.0.xcspec";

void printArgs(NSArray<NSString *> *args) {
    NSUInteger c = 0;

    for(NSString *s in args) {
        PGPrintf(@"%2lu> %@\n", ++c, s);
    }
}

int main(int argc, const char *argv[]) {
    int returnCode = 0;

    @autoreleasepool {
        NSPropertyListFormat pbxFormat      = NSPropertyListOpenStepFormat;
        NSString             *pbxProjPath1  = @"~/Projects/2019/PBXBuilder/PBXBuilder.xcodeproj/project.pbxproj";
        // NSString             *pbxProjPath1 = [NSString stringWithUTF8String:argv[1]];
        // NSString             *pbxProjPath2 = PGFormat(@"%@/%@", xcodePluginsPath, clangXcodeMap);
        NSError              *error         = nil;
        NSString             *plistFilename = pbxProjPath1.stringByExpandingTildeInPath;

        PGPrintf(@"Reading: %@\n", plistFilename);

        NSData *plistData = [NSData dataWithContentsOfFile:plistFilename options:NSDataReadingMappedIfSafe error:&error];

        if(!plistData) {
            PGPrintf(@"Error: %@\n", error.localizedDescription);
            returnCode = 1;
        }
        else {
            GNUstepInfo *info = [[GNUstepInfo alloc] init:&error];
            PGPrintStr(@"Getting GNUstep parameters...\n");
            PGPrintf(@"\nConfig: \"%@\"\n", info.gnustepConfig);

            PGPrintStr(@"\nCompiler Flags:\n");
            printArgs(info.objcOpts);

            PGPrintStr(@"\nLinker Flags:\n");
            printArgs(info.linkOpts);

            PGPrintStr(@"\nGUI Linker Flags:\n");
            printArgs(info.linkGuiOpts);

            PGPrintf(@"\n%20s: %lu\n", "cpuCount", info.cpuCount);
            PGPrintf(@"%20s: \"%@\"\n", "ccPath", info.ccPath);
            PGPrintf(@"%20s: \"%@\"\n", "applcationPath", info.applcationPath);
            PGPrintf(@"%20s: \"%@\"\n", "toolsPath", info.toolsPath);
            PGPrintf(@"%20s: \"%@\"\n", "libraryPath", info.libraryPath);
            PGPrintf(@"%20s: \"%@\"\n", "headersPath", info.headersPath);
            PGPrintf(@"%20s: \"%@\"\n", "libsPath", info.libsPath);
            PGPrintf(@"%20s: \"%@\"\n", "docPath", info.docPath);
            PGPrintf(@"%20s: \"%@\"\n", "manPath", info.manPath);
            PGPrintf(@"%20s: \"%@\"\n", "infoPath", info.infoPath);
        }
    }

    return returnCode;
}

