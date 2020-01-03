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

NSString *const XCBuildConfigNameDebug   = @"Debug";
NSString *const XCBuildConfigNameRelease = @"Release";
NSString *const XCBuildConfigNameDefault = XCBuildConfigNameRelease;

/*

    /Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins

    /Clang LLVM 1.0.xcplugin/Contents/Resources/Clang LLVM 1.0.xcspec
    /CoreBuildTasks.xcplugin/Contents/Resources/Ld.xcspec
    /XCLanguageSupport.xcplugin/Contents/Resources/Swift.xcspec

 */

@implementation XCBuildConfiguration {
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSString *)name {
        return [self iv:@"name"];
    }

    -(NSDictionary<NSString *, id> *)buildSettings {
        return ([self iv:@"buildSettings"] ?: [NSDictionary new]);
    }

    -(NSString *)baseConfigurationReference {
        return [self iv:@"baseConfigurationReference"];
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        PBXAppendItem(str, indent, @"name", self.name);
        PBXAppendItem(str, indent, @"baseConfigurationReference", self.baseConfigurationReference);
        PBXAppendItem(str, indent, @"buildSettings", self.buildSettings);
        return str;
    }

    +(NSArray<NSString *> *)allBuildConfigurationNames {
        static NSArray<NSString *> *_configNames;
        static dispatch_once_t     _configNamesOnce;
        dispatch_once(&_configNamesOnce, ^{ _configNames = @[ XCBuildConfigNameDebug, XCBuildConfigNameRelease ]; });
        return _configNames;
    }

@end
