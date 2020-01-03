/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: NSRegularExpression+Moscow.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/19/19
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

#ifndef __PBXBUILDER_NSREGULAREXPRESSION_MOSCOW_H__
#define __PBXBUILDER_NSREGULAREXPRESSION_MOSCOW_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSRegularExpression(Moscow)

    -(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r;

    -(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s;

    -(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o;

    -(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o;

    -(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r;

    -(NSRange)rangeOfFirstMatchInString:(NSString *)s;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s
                                options:(NSMatchingOptions)o
                                  range:(NSRange)r
                                pattern:(NSString *)p
                              rxOptions:(NSRegularExpressionOptions)ro
                                  error:(NSError **)e;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p error:(NSError **)e;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p error:(NSError **)e;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p error:(NSError **)e;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s pattern:(NSString *)p error:(NSError **)e;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro;

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s pattern:(NSString *)p;

    +(nullable instancetype)regularExpressionWithPattern:(NSString *)p error:(NSError **)error;

    +(nullable instancetype)regularExpressionWithPattern:(NSString *)p;

    +(nullable instancetype)cachedRegularExpressionWithPattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e;

    +(nullable instancetype)cachedRegularExpressionWithPattern:(NSString *)p error:(NSError **)e;

    +(nullable instancetype)cachedRegularExpressionWithPattern:(NSString *)p;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p error:(NSError **)e;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s
                                                         options:(NSMatchingOptions)o
                                                           range:(NSRange)r
                                                         pattern:(NSString *)p
                                                       rxOptions:(NSRegularExpressionOptions)ro
                                                           error:(NSError **)e;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p error:(NSError **)e;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s
                                                         options:(NSMatchingOptions)o
                                                         pattern:(NSString *)p
                                                       rxOptions:(NSRegularExpressionOptions)ro
                                                           error:(NSError **)e;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p error:(NSError **)e;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s
                                                         options:(NSMatchingOptions)o
                                                           range:(NSRange)r
                                                         pattern:(NSString *)p
                                                       rxOptions:(NSRegularExpressionOptions)ro;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s pattern:(NSString *)p error:(NSError **)e;

    +(nullable NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s pattern:(NSString *)p;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_NSREGULAREXPRESSION_MOSCOW_H__
