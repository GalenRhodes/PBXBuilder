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

@implementation PBXNativeTarget {
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            NSString *key = self.productTypeDescription;
            if([key isEqualToString:@"com.apple.product-type.application"]) _productType = PBX_PRODUCTTYPE_APPLICATION;
            else if([key isEqualToString:@"com.apple.product-type.tool"]) _productType = PBX_PRODUCTTYPE_TOOL;
            else if([key isEqualToString:@"com.apple.product-type.library.static"]) _productType = PBX_PRODUCTTYPE_LIBRARYSTATIC;
            else if([key isEqualToString:@"com.apple.product-type.library.dynamic"]) _productType = PBX_PRODUCTTYPE_LIBRARYDYNAMIC;
            else if([key isEqualToString:@"com.apple.product-type.kernel-extension"]) _productType = PBX_PRODUCTTYPE_KERNELEXTENSION;
            else if([key isEqualToString:@"com.apple.product-type.kernel-extension.iokit"]) _productType = PBX_PRODUCTTYPE_KERNELEXTENSIONIOKIT;
            else _productType = PBX_PRODUCTTYPE_NONE;
        }

        return self;
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
