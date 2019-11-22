/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: NSString+Moscow.h
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

#ifndef __PBXBUILDER_NSSTRING_MOSCOW_H__
#define __PBXBUILDER_NSSTRING_MOSCOW_H__

#import <Cocoa/Cocoa.h>

FOUNDATION_EXPORT NSString *const PGMacroPattern;

typedef NSString *_Nullable (^PGReplaceBlock)(NSTextCheckingResult *_Nonnull match, BOOL *_Nonnull pStop);

typedef NSString *_Nullable (^PGMacroBlock)(NSString *_Nonnull macro, BOOL *_Nonnull pStop);

NS_ASSUME_NONNULL_BEGIN

@interface NSString(Moscow)

    -(NSString *)stringByReplacingMacros:(PGMacroBlock)block;

    -(NSRange)range;

    -(NSString *)substringFrom:(NSUInteger)fromIdx to:(NSUInteger)toIdx;

    -(NSArray<NSString *> *)split:(NSString *)pattern limit:(NSInteger)limit;

    -(NSArray<NSString *> *)split:(NSString *)pattern;

    -(NSString *)nullIfEmpty;

    -(BOOL)matches:(NSString *)pattern;

    -(BOOL)matches:(NSString *)pattern error:(NSError **)error;

    -(BOOL)matches:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error;

    -(BOOL)contains:(NSString *)pattern;

    -(BOOL)contains:(NSString *)pattern error:(NSError **)error;

    -(BOOL)contains:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error;

    -(NSString *)trim;

    -(NSString *)copyIfSameObjectAs:(NSString *)other;

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range
                                         options:(NSMatchingOptions)options
                                         pattern:(NSString *)pattern
                                       rxOptions:(NSRegularExpressionOptions)rxOptions
                                      usingBlock:(PGReplaceBlock)block
                                           error:(NSError **)error;

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range
                                         options:(NSMatchingOptions)options
                                         pattern:(NSString *)pattern
                                      usingBlock:(PGReplaceBlock)block
                                           error:(NSError **)error;

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range
                                         pattern:(NSString *)pattern
                                       rxOptions:(NSRegularExpressionOptions)rxOptions
                                      usingBlock:(PGReplaceBlock)block
                                           error:(NSError **)error;

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block error:(NSError **)error;

    -(NSString *)stringByReplacingMatchesWithOptions:(NSMatchingOptions)options
                                             pattern:(NSString *)pattern
                                           rxOptions:(NSRegularExpressionOptions)rxOptions
                                          usingBlock:(PGReplaceBlock)block
                                               error:(NSError **)error;

    -(NSString *)stringByReplacingMatchesWithOptions:(NSMatchingOptions)options pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block error:(NSError **)error;

    -(NSString *)stringByReplacingMatchesWithPattern:(NSString *)pattern rxOptions:(NSRegularExpressionOptions)rxOptions usingBlock:(PGReplaceBlock)block error:(NSError **)error;

    -(NSString *)stringByReplacingMatchesWithPattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block error:(NSError **)error;

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range
                                         options:(NSMatchingOptions)options
                                         pattern:(NSString *)pattern
                                       rxOptions:(NSRegularExpressionOptions)rxOptions
                                      usingBlock:(PGReplaceBlock)block;

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range options:(NSMatchingOptions)options pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block;

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range pattern:(NSString *)pattern rxOptions:(NSRegularExpressionOptions)rxOptions usingBlock:(PGReplaceBlock)block;

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block;

    -(NSString *)stringByReplacingMatchesWithOptions:(NSMatchingOptions)options
                                             pattern:(NSString *)pattern
                                           rxOptions:(NSRegularExpressionOptions)rxOptions
                                          usingBlock:(PGReplaceBlock)block;

    -(NSString *)stringByReplacingMatchesWithOptions:(NSMatchingOptions)options pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block;

    -(NSString *)stringByReplacingMatchesWithPattern:(NSString *)pattern rxOptions:(NSRegularExpressionOptions)rxOptions usingBlock:(PGReplaceBlock)block;

    -(NSString *)stringByReplacingMatchesWithPattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_NSSTRING_MOSCOW_H__
