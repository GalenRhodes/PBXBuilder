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

#import <PBX/PBXFileElement.h>
#include "PBXFileElementTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface PBXFileReference : PBXFileElement

    @property(readonly) PBXFileType     explicitFileType;
    @property(readonly) PBXFileType     lastKnownFileType;
    @property(readonly) PBXFileEncoding fileEncoding;
    @property(readonly) BOOL            includeInIndex;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXFILEREFERENCE_H__
