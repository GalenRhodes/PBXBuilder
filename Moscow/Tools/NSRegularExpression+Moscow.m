/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: NSRegularExpression+Moscow.m
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

#import "NSRegularExpression+Moscow.h"
#import "NSString+Moscow.h"
#import "Tools.h"

NSRange PGRangeOfFirstMatchInString(NSString *_Nonnull s, NSMatchingOptions o, NSRange r, NSString *_Nonnull p, NSRegularExpressionOptions ro, NSError **e);

NSRegularExpression *_Nullable PGCachedRegexWithPattern(NSString *_Nonnull p, NSRegularExpressionOptions ro, NSError **e);

NSArray<NSTextCheckingResult *> *_Nullable PGMatchesInString(NSString *_Nonnull s,
                                                             NSMatchingOptions o,
                                                             NSRange r,
                                                             NSString *_Nonnull p,
                                                             NSRegularExpressionOptions ro,
                                                             NSError **e);

@implementation NSRegularExpression(Moscow)

    -(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r {
        return [self matchesInString:s options:0 range:r];
    }

    -(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s {
        return [self matchesInString:s options:0 range:s.range];
    }

    -(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o {
        return [self matchesInString:s options:o range:s.range];
    }

    -(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o {
        return [self rangeOfFirstMatchInString:s options:o range:s.range];
    }

    -(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r {
        return [self rangeOfFirstMatchInString:s options:0 range:r];
    }

    -(NSRange)rangeOfFirstMatchInString:(NSString *)s {
        return [self rangeOfFirstMatchInString:s options:0 range:s.range];
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s
                                options:(NSMatchingOptions)o
                                  range:(NSRange)r
                                pattern:(NSString *)p
                              rxOptions:(NSRegularExpressionOptions)ro
                                  error:(NSError **)e {
        return PGRangeOfFirstMatchInString(s, o, r, p, ro, e);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p error:(NSError **)e {
        return PGRangeOfFirstMatchInString(s, o, r, p, 0, e);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e {
        return PGRangeOfFirstMatchInString(s, 0, r, p, ro, e);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p error:(NSError **)e {
        return PGRangeOfFirstMatchInString(s, 0, r, p, 0, e);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e {
        return PGRangeOfFirstMatchInString(s, o, s.range, p, ro, e);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p error:(NSError **)e {
        return PGRangeOfFirstMatchInString(s, o, s.range, p, 0, e);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e {
        return PGRangeOfFirstMatchInString(s, 0, s.range, p, ro, e);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s pattern:(NSString *)p error:(NSError **)e {
        return PGRangeOfFirstMatchInString(s, 0, s.range, p, 0, e);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro {
        return PGRangeOfFirstMatchInString(s, o, r, p, ro, NULL);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p {
        return PGRangeOfFirstMatchInString(s, o, r, p, 0, NULL);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro {
        return PGRangeOfFirstMatchInString(s, 0, r, p, ro, NULL);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p {
        return PGRangeOfFirstMatchInString(s, 0, r, p, 0, NULL);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro {
        return PGRangeOfFirstMatchInString(s, o, s.range, p, ro, NULL);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p {
        return PGRangeOfFirstMatchInString(s, o, s.range, p, 0, NULL);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro {
        return PGRangeOfFirstMatchInString(s, 0, s.range, p, ro, NULL);
    }

    +(NSRange)rangeOfFirstMatchInString:(NSString *)s pattern:(NSString *)p {
        return PGRangeOfFirstMatchInString(s, 0, s.range, p, 0, NULL);
    }

    +(instancetype)regularExpressionWithPattern:(NSString *)p error:(NSError **)error {
        return [self regularExpressionWithPattern:p options:0 error:error];
    }

    +(instancetype)regularExpressionWithPattern:(NSString *)p {
        return [self regularExpressionWithPattern:p options:0 error:NULL];
    }

    +(instancetype)cachedRegularExpressionWithPattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e {
        return PGCachedRegexWithPattern(p, ro, e);
    }

    +(instancetype)cachedRegularExpressionWithPattern:(NSString *)p error:(NSError **)e {
        return PGCachedRegexWithPattern(p, 0, e);
    }

    +(instancetype)cachedRegularExpressionWithPattern:(NSString *)p {
        return PGCachedRegexWithPattern(p, 0, NULL);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e {
        return PGMatchesInString(s, 0, r, p, ro, e);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s pattern:(NSString *)p error:(NSError **)e {
        return PGMatchesInString(s, 0, s.range, p, 0, e);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro error:(NSError **)e {
        return PGMatchesInString(s, 0, s.range, p, ro, e);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p error:(NSError **)e {
        return PGMatchesInString(s, 0, r, p, 0, e);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro {
        return PGMatchesInString(s, 0, r, p, ro, NULL);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s pattern:(NSString *)p {
        return PGMatchesInString(s, 0, s.range, p, 0, NULL);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro {
        return PGMatchesInString(s, 0, s.range, p, ro, NULL);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s range:(NSRange)r pattern:(NSString *)p {
        return PGMatchesInString(s, 0, r, p, 0, NULL);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s
                                                options:(NSMatchingOptions)o
                                                  range:(NSRange)r
                                                pattern:(NSString *)p
                                              rxOptions:(NSRegularExpressionOptions)ro
                                                  error:(NSError **)e {
        return PGMatchesInString(s, o, r, p, ro, e);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p error:(NSError **)e {
        return PGMatchesInString(s, o, s.range, p, 0, e);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s
                                                options:(NSMatchingOptions)o
                                                pattern:(NSString *)p
                                              rxOptions:(NSRegularExpressionOptions)ro
                                                  error:(NSError **)e {
        return PGMatchesInString(s, o, s.range, p, ro, e);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p error:(NSError **)e {
        return PGMatchesInString(s, o, r, p, 0, e);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro {
        return PGMatchesInString(s, o, r, p, ro, NULL);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p {
        return PGMatchesInString(s, o, s.range, p, 0, NULL);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o pattern:(NSString *)p rxOptions:(NSRegularExpressionOptions)ro {
        return PGMatchesInString(s, o, s.range, p, ro, NULL);
    }

    +(NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)s options:(NSMatchingOptions)o range:(NSRange)r pattern:(NSString *)p {
        return PGMatchesInString(s, o, r, p, 0, NULL);
    }

@end

NSRange PGRangeOfFirstMatchInString(NSString *s, NSMatchingOptions o, NSRange r, NSString *p, NSRegularExpressionOptions ro, NSError **e) {
    NSRegularExpression *rx   = PGCachedRegexWithPattern(p, ro, e);
    NSRange             range = NSMakeRange(NSNotFound, 0);

    if(rx) {
        @synchronized(rx) {
            range = [rx rangeOfFirstMatchInString:s options:o range:r];
        }
    }

    return range;
}

NSArray<NSTextCheckingResult *> *PGMatchesInString(NSString *s, NSMatchingOptions o, NSRange r, NSString *p, NSRegularExpressionOptions ro, NSError **e) {
    NSRegularExpression             *regex   = PGCachedRegexWithPattern(p, ro, e);
    NSArray<NSTextCheckingResult *> *results = nil;

    if(regex) {
        @synchronized(regex) {
            results = [regex matchesInString:s options:o range:r];
        }
    }

    return results;
}

NSRegularExpression *PGCachedRegexWithPattern(NSString *p, NSRegularExpressionOptions ro, NSError **e) {
    static NSMutableDictionary<NSString *, NSRegularExpression *> *regexCache    = nil;
    static dispatch_once_t                                        regexCacheFlag = 0;

    dispatch_once(&regexCacheFlag, ^{ regexCache = [NSMutableDictionary new]; });

    @synchronized(regexCache) {
        NSString            *key   = PGFormat(@"KEYÐ%@Ð%@", p, @(ro));
        NSRegularExpression *regex = regexCache[key];

        if(!regex) {
            regex = [NSRegularExpression regularExpressionWithPattern:p options:ro error:e];
            if(regex) regexCache[key] = regex;
        }

        return regex;
    }
}
