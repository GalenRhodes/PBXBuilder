/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: Tools.h
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

#ifndef __PBXBUILDER_TOOLS_H__
#define __PBXBUILDER_TOOLS_H__

#import <Cocoa/Cocoa.h>

typedef void (^PGPrintStructBlock)(NSString *_Nonnull prefix, BOOL addCR);

#ifndef __APPLE__

typedef NS_OPTIONS(NSUInteger, NSDataReadingOptions) {
    NSDataReadingMappedIfSafe = 1UL << 0,	// Hint to map the file in if possible and safe
    NSDataReadingUncached     = 1UL << 1,	// Hint to get the file not to be cached in the kernel
    NSDataReadingMappedAlways = 1UL << 3,	// Hint to map the file in if possible. This takes precedence over NSDataReadingMappedIfSafe if both are given.
};

#endif


NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT dispatch_queue_t PGWorkQueue(void);

FOUNDATION_EXPORT void PGPrintf(NSString *format, ...) NS_FORMAT_FUNCTION(1, 2);

FOUNDATION_EXPORT NSString *PGFormat(NSString *format, ...) NS_FORMAT_FUNCTION(1, 2);

FOUNDATION_EXPORT NSString *PGClassName(id obj);

FOUNDATION_EXPORT void PGPrintPlist(id obj);

@interface NSString(PBXBuilder)

    -(BOOL)matches:(NSString *)pattern;

    -(BOOL)matches:(NSString *)pattern error:(NSError **)error;

    -(BOOL)matches:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error;

    -(BOOL)contains:(NSString *)pattern;

    -(BOOL)contains:(NSString *)pattern error:(NSError **)error;

    -(BOOL)contains:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error;

@end

@interface NSMutableArray(PBXBuilder)

    -(void)addObjectWithCheck:(id)obj;

@end

@interface NSScanner(PBXBuilder)

    +(unsigned long long)atoull:(NSString *)str success:(BOOL *)success;

#ifndef __APPLE__

    -(BOOL)scanUnsignedLongLong:(unsigned long long *)ullVal;

#endif

@end

@interface NSData(PBXBuilder)

//@f:0
#ifndef __APPLE__

    +(nullable instancetype)dataWithContentsOfFile:(NSString *)path options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr;

#endif
//@f:1

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_TOOLS_H__