/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: NSData+Moscow.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/16/19
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

#ifndef __PBXBUILDER_NSDATA_MOSCOW_H__
#define __PBXBUILDER_NSDATA_MOSCOW_H__

#import <Moscow/Tools.h>

#if GNUSTEP

typedef NS_OPTIONS(NSUInteger, NSDataReadingOptions) {
    NSDataReadingMappedIfSafe = 1UL << 0,	// Hint to map the file in if possible and safe
    NSDataReadingUncached     = 1UL << 1,	// Hint to get the file not to be cached in the kernel
    NSDataReadingMappedAlways = 1UL << 3,	// Hint to map the file in if possible. This takes precedence over NSDataReadingMappedIfSafe if both are given.
};

#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSData(Moscow)

    -(NSData *)copyIfSameObject:(id)other;

#if GNUSTEP

    +(nullable instancetype)dataWithContentsOfFile:(NSString *)path options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr;

#endif

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_NSDATA_MOSCOW_H__
