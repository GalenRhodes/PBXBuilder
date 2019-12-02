/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGBool.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 12/2/19
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

#ifndef __PBXBUILDER_PGBOOL_H__
#define __PBXBUILDER_PGBOOL_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGBool : NSObject

    @property(nonatomic, readonly) BOOL boolValue;

    +(PGBool *)boolObj:(BOOL)boolValue;

    +(PGBool *)boolYes;

    +(PGBool *)boolNo;

    -(NSString *)description;

    -(BOOL)isEqual:(id)other;

    -(BOOL)isEqualToABool:(PGBool *)aBool;

    -(NSUInteger)hash;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PGBOOL_H__