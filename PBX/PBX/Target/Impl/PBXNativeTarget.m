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
#import "PBXProjectFile.h"
#import "PBXPrivate.h"

@implementation PBXNativeTarget {
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            self.buildConfigurationList.target = self;

            @try {
#pragma clang diagnostic push
#pragma ide diagnostic ignored "RedundantCast"
                //@f:0
                _productType = (PBXProductType)((NSNumber *)(PBXNativeTarget.productTypeDescriptionsMap[(self.productTypeDescription ?: @"")] ?: @(PBX_PRODUCTTYPE_NONE))).unsignedIntegerValue;
                //@f:1
#pragma clang diagnostic pop
            }
            @catch(NSException *exception) {
                NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
            }
        }

        return self;
    }

    +(NSDictionary<NSNumber *, NSString *> *)productTypesMap {
        static NSDictionary<NSNumber *, NSString *> *_dict = nil;
        static dispatch_once_t                      _flag  = 0;
        dispatch_once(&_flag, ^{
            NSDictionary<NSString *, NSNumber *>        *dict  = self.productTypeDescriptionsMap;
            NSMutableDictionary<NSNumber *, NSString *> *mdict = [NSMutableDictionary dictionaryWithCapacity:dict.count];
            [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) { mdict[obj] = key; }];
            _dict = mdict;
        });
        return _dict;
    }

    +(NSDictionary<NSString *, NSNumber *> *)productTypeDescriptionsMap {
        static NSDictionary    *_desc    = nil;
        static dispatch_once_t _descFlag = 0;
        dispatch_once(&_descFlag, ^{
            _desc = @{
                @"com.apple.product-type.application"                        : @(PBX_PRODUCTTYPE_APPLICATION),
                @"com.apple.product-type.application.watchapp"               : @(PBX_PRODUCTTYPE_APPLICATION_WATCH),
                @"com.apple.product-type.application.watchapp2"              : @(PBX_PRODUCTTYPE_APPLICATION_WATCH2),
                @"com.apple.product-type.application.watchapp2-container"    : @(PBX_PRODUCTTYPE_APPLICATION_WATCH2_CONTAINER),
                @"com.apple.product-type.application.messages"               : @(PBX_PRODUCTTYPE_APPLICATION_MESSAGES),
                @"com.apple.product-type.tool"                               : @(PBX_PRODUCTTYPE_TOOL),
                @"com.apple.product-type.bundle"                             : @(PBX_PRODUCTTYPE_BUNDLE),
                @"com.apple.product-type.bundle.unit-test"                   : @(PBX_PRODUCTTYPE_BUNDLE_UNIT_TEST),
                @"com.apple.product-type.bundle.ui-testing"                  : @(PBX_PRODUCTTYPE_BUNDLE_UI_TEST),
                @"com.apple.product-type.framework"                          : @(PBX_PRODUCTTYPE_FRAMEWORK),
                @"com.apple.product-type.library.static"                     : @(PBX_PRODUCTTYPE_LIBRARY_STATIC),
                @"com.apple.product-type.library.dynamic"                    : @(PBX_PRODUCTTYPE_LIBRARY_DYNAMIC),
                @"com.apple.product-type.kernel-extension"                   : @(PBX_PRODUCTTYPE_KERNEL_EXTENSION),
                @"com.apple.product-type.kernel-extension.iokit"             : @(PBX_PRODUCTTYPE_KERNEL_EXTENSION_IOKIT),
                @"com.apple.product-type.app-extension"                      : @(PBX_PRODUCTTYPE_APP_EXTENSION),
                @"com.apple.product-type.app-extension.messages"             : @(PBX_PRODUCTTYPE_MESSAGES_EXTENSION),
                @"com.apple.product-type.app-extension.messages-sticker-pack": @(PBX_PRODUCTTYPE_STICKER_PACK),
                @"com.apple.product-type.tv-app-extension"                   : @(PBX_PRODUCTTYPE_TV_EXTENSION),
                @"com.apple.product-type.watchkit-extension"                 : @(PBX_PRODUCTTYPE_WATCH_EXTENSION),
                @"com.apple.product-type.watchkit2-extension"                : @(PBX_PRODUCTTYPE_WATCH2_EXTENSION),
                @"com.apple.product-type.xpc-service"                        : @(PBX_PRODUCTTYPE_XPC_SERVICE),
            };
        });
        return _desc;
    }

    -(NSString *)productInstallPath {
        return [self iv:@"productInstallPath"];
    }

    -(NSString *)productTypeDescription {
        return [self iv:@"productType"];
    }

    -(PBXFileReference *)productReference {
        return [self itemForKey:@"productReference"];
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        PBXAppendItem(str, indent, @"productInstallPath", self.productInstallPath);
        PBXAppendItem(str, indent, @"productType", self.productTypeDescription);
        PBXAppendItem(str, indent, @"productReference", self.productReference);
        return str;
    }

@end
