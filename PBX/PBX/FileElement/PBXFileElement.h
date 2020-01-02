/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXFileElement.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/5/19
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

#ifndef __PBXBUILDER_PBXFILEELEMENT_H__
#define __PBXBUILDER_PBXFILEELEMENT_H__

#import <PBX/PBXItem.h>
#import <PBX/PBXFileElementTypes.h>

@class PBXGroup;

NS_ASSUME_NONNULL_BEGIN

@interface PBXFileElement : PBXItem

    @property(class, readonly) NSDictionary<NSString *, NSNumber *> *fileTypeMap;
    @property(class, readonly) NSDictionary<NSString *, NSNumber *> *sourceTreeMap;
    @property(class, readonly) NSDictionary<NSNumber *, NSString *> *fileEncodingMap;

    @property(readonly, nullable) NSString      *name;
    @property(readonly, nullable) NSString      *path;
    @property(readonly)/*      */ PBXSourceTree sourceTree;
    @property(readonly, nullable) NSString      *realPath;
    @property(readonly, nullable) PBXGroup      *parent;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile;

    +(PBXSourceTree)sourceTreeForId:(NSString *)sourceTreeId;

    +(PBXFileEncoding)cleanFileEncoding:(NSUInteger)encodingId;

    +(NSString *)fileEncodingForId:(PBXFileEncoding)encodingId;

    +(PBXFileType)fileTypeForId:(NSString *)typeId;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXFILEELEMENT_H__
