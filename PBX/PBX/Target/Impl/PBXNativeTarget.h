/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGXNativeTarget.h
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

#ifndef __PBXBUILDER_PGXNATIVETARGET_H__
#define __PBXBUILDER_PGXNATIVETARGET_H__

#import <PBX/PBXTarget.h>

@class PBXFileReference;

typedef NS_ENUM(NSUInteger, PBXProductType) {
    PBX_PRODUCTTYPE_NONE = 0,                     //
    PBX_PRODUCTTYPE_APPLICATION,                  // com.apple.product-type.application
    PBX_PRODUCTTYPE_APPLICATION_WATCH,            // com.apple.product-type.application.watchapp
    PBX_PRODUCTTYPE_APPLICATION_WATCH2,           // com.apple.product-type.application.watchapp2
    PBX_PRODUCTTYPE_APPLICATION_WATCH2_CONTAINER, // com.apple.product-type.application.watchapp2-container
    PBX_PRODUCTTYPE_APPLICATION_MESSAGES,         // com.apple.product-type.application.messages
    PBX_PRODUCTTYPE_TOOL,                         // com.apple.product-type.tool
    PBX_PRODUCTTYPE_BUNDLE,                       // com.apple.product-type.bundle
    PBX_PRODUCTTYPE_BUNDLE_UNIT_TEST,             // com.apple.product-type.bundle.unit-test
    PBX_PRODUCTTYPE_BUNDLE_UI_TEST,               // com.apple.product-type.bundle.ui-testing
    PBX_PRODUCTTYPE_FRAMEWORK,                    // com.apple.product-type.framework
    PBX_PRODUCTTYPE_LIBRARY_STATIC,               // com.apple.product-type.library.static
    PBX_PRODUCTTYPE_LIBRARY_DYNAMIC,              // com.apple.product-type.library.dynamic
    PBX_PRODUCTTYPE_KERNEL_EXTENSION,             // com.apple.product-type.kernel-extension
    PBX_PRODUCTTYPE_KERNEL_EXTENSION_IOKIT,       // com.apple.product-type.kernel-extension.iokit
    PBX_PRODUCTTYPE_APP_EXTENSION,                // com.apple.product-type.app-extension
    PBX_PRODUCTTYPE_MESSAGES_EXTENSION,           // com.apple.product-type.app-extension.messages
    PBX_PRODUCTTYPE_STICKER_PACK,                 // com.apple.product-type.app-extension.messages-sticker-pack
    PBX_PRODUCTTYPE_TV_EXTENSION,                 // com.apple.product-type.tv-app-extension
    PBX_PRODUCTTYPE_WATCH_EXTENSION,              // com.apple.product-type.watchkit-extension
    PBX_PRODUCTTYPE_WATCH2_EXTENSION,             // com.apple.product-type.watchkit2-extension
    PBX_PRODUCTTYPE_XPC_SERVICE,                  // com.apple.product-type.xpc-service
};

NS_ASSUME_NONNULL_BEGIN

@interface PBXNativeTarget : PBXTarget

    @property(nullable, readonly)/**/ NSString                             *productInstallPath;
    @property(readonly)/*          */ PBXProductType                       productType;
    @property(nullable, readonly)/**/ NSString                             *productTypeDescription;
    @property(nullable, readonly)/**/ PBXFileReference                     *productReference;
    @property(class, readonly)/*   */ NSDictionary<NSString *, NSNumber *> *productTypeDescriptionsMap;
    @property(class, readonly)/*   */ NSDictionary<NSNumber *, NSString *> *productTypesMap;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PGXNATIVETARGET_H__
