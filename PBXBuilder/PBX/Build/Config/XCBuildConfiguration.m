/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: XCBuildConfiguration.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/4/19
 *
 * Copyright © 2019 Project Galen. All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *//************************************************************************/

#import "XCBuildConfiguration.h"

/*

/Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins

/Clang LLVM 1.0.xcplugin/Contents/Resources/Clang LLVM 1.0.xcspec
/CoreBuildTasks.xcplugin/Contents/Resources/Ld.xcspec
/XCLanguageSupport.xcplugin/Contents/Resources/SwiftBuildSettings.xcspec
/XCLanguageSupport.xcplugin/Contents/Resources/SwiftBuildSteps.xcspec
/XCLanguageSupport.xcplugin/Contents/Resources/Swift.xcspec

 */

@implementation XCBuildConfiguration {
    }

    @synthesize name = _name;
    @synthesize buildSettings = _buildSettings;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            _name          = [[self iv:@"name"] copy];
            _buildSettings = ([((NSDictionary<NSString *, id> *)[self iv:@"buildSettings"]) copy] ?: [NSDictionary new]);
        }

        return self;
    }

@end
