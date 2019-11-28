/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: Tests.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/26/19
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

#import <Moscow/Moscow.h>
#import "Tests.h"
#import "PBXTools.h"

NSString const *xcodePluginsPath = @"/Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins";
NSString const *clangXcodeMap    = @"Clang LLVM 1.0.xcplugin/Contents/Resources/Clang LLVM 1.0.xcspec";

int testFindProjectUsingFind(NSString *dir) {
    NSError *error = nil;
    return parseFindProjectResults(dir, PGFindByName(dir, @"project.pbxproj", &error), NULL, NULL, &error);
}

int testFindProjectUsingNSFileManager(NSString *dir) {
    NSError *error = nil;
    return parseFindProjectResults(dir, PGFindByName(dir, @"project.pbxproj", &error), NULL, NULL, &error);
}

