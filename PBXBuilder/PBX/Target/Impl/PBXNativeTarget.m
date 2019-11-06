/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGXNativeTarget.m
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

#import "PBXNativeTarget.h"
#import "PBXFileReference.h"
#import "PGProjectFile.h"

@implementation PBXNativeTarget {
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSString *)productInstallPath {
        return [self iv:@"productInstallPath"];
    }

    -(PBXProductType)productType {
        static NSDictionary<NSString *, NSNumber *> *_prodTypes    = nil;
        static dispatch_once_t                      _prodTypesOnce = 0;

        dispatch_once(&_prodTypesOnce, ^{
            _prodTypes = @{
                @"com.apple.product-type.application"           : @(PBX_PRODUCTTYPE_APPLICATION),
                @"com.apple.product-type.tool"                  : @(PBX_PRODUCTTYPE_TOOL),
                @"com.apple.product-type.library.static"        : @(PBX_PRODUCTTYPE_LIBRARYSTATIC),
                @"com.apple.product-type.library.dynamic"       : @(PBX_PRODUCTTYPE_LIBRARYDYNAMIC),
                @"com.apple.product-type.kernel-extension"      : @(PBX_PRODUCTTYPE_KERNELEXTENSION),
                @"com.apple.product-type.kernel-extension.iokit": @(PBX_PRODUCTTYPE_KERNELEXTENSIONIOKIT),
            };
        });

        NSString *key = [self iv:@"productType"];
        NSNumber *num = (key ? _prodTypes[key] : nil);
        return (num ? (PBXProductType)num.unsignedIntegerValue : PBX_PRODUCTTYPE_NONE);
    }

    -(PBXFileReference *)productReference {
        return [self itemForKey:@"productReference"];
    }

@end
