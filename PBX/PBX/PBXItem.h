/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXItem.h
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

#ifndef __PBXBUILDER_PBXITEM_H__
#define __PBXBUILDER_PBXITEM_H__

#import <Cocoa/Cocoa.h>
#import <Moscow/Moscow.h>

@class PBXProjectFile;

NS_ASSUME_NONNULL_BEGIN

@interface PBXItem : NSObject<NSLocking>

    @property(readonly) NSString                            *itemId;
    @property(readonly) NSString                            *objType;
    @property(readonly) PBXProjectFile                      *projectFile;
    @property(readonly) NSMutableDictionary<NSString *, id> *userInfo;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile;

    -(nullable id)iv:(NSString *)key;

    -(NSArray *)ivx:(NSString *)key;

    -(BOOL)ivBool:(NSString *)key;

    -(NSInteger)ivInt:(NSString *)key;

    -(NSUInteger)ivUInt:(NSString *)key;

    -(nullable id)itemForKey:(NSString *)key;

    -(nullable id)itemForID:(NSString *)itemId;

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent;

@end

NSMutableString *PBXAppendItem(NSMutableString *buffer, NSString *indent, NSString *name, id item);

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXITEM_H__
