/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXFileReference.h
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

#ifndef __PBXBUILDER_PBXFILEREFERENCE_H__
#define __PBXBUILDER_PBXFILEREFERENCE_H__

#import "PBXFileElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface PBXFileReference : PBXFileElement

    /*
     * 83E1B3932370808500427C23 = {
     *     isa = PBXFileReference;
     *     explicitFileType = "compiled.mach-o.executable";
     *     includeInIndex = 0;
     *     path = PBXBuilder;
     *     sourceTree = BUILT_PRODUCTS_DIR;
     * };
     *
     */

    @property(copy, readonly, nullable) NSString *explicitFileType;
    @property(copy, readonly, nullable) NSString *path;
    @property(copy, readonly, nullable) NSString *sourceTree;
    @property(readonly)/*            */ BOOL     includeInIndex;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXFILEREFERENCE_H__
