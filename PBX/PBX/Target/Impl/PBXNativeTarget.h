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
    PBX_PRODUCTTYPE_NONE = 0,             //
    PBX_PRODUCTTYPE_APPLICATION,          // com.apple.product-type.application
    PBX_PRODUCTTYPE_TOOL,                 // com.apple.product-type.tool
    PBX_PRODUCTTYPE_LIBRARYSTATIC,        // com.apple.product-type.library.static
    PBX_PRODUCTTYPE_LIBRARYDYNAMIC,       // com.apple.product-type.library.dynamic
    PBX_PRODUCTTYPE_KERNELEXTENSION,      // com.apple.product-type.kernel-extension
    PBX_PRODUCTTYPE_KERNELEXTENSIONIOKIT, // com.apple.product-type.kernel-extension.iokit
};

NS_ASSUME_NONNULL_BEGIN

@interface PBXNativeTarget : PBXTarget

    @property(nullable, readonly) NSString         *productInstallPath;
    @property(readonly)/*      */ PBXProductType   productType;
    @property(nullable, readonly) NSString         *productTypeDescription;
    @property(nullable, readonly) PBXFileReference *productReference;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PGXNATIVETARGET_H__
