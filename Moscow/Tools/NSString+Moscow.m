/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: NSString+Moscow.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 12/15/19
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

#import "NSString+Moscow.h"
#import "NSRegularExpression+Moscow.h"
#import "Tools.h"

NSString *const PGMacroPattern = @"((?<!\\\\)(?:\\\\\\\\)*)\\$\\{(\\w+)\\}";

NSString *const PGErrMsgStringNotLongEnough = @"String must have a length of at least %lu. Current length %lu";

NSArray<NSString *> *split(NSString *string, NSString *pattern, NSInteger limit);

NSString *stringByReplacingMatches(NSString *_Nonnull string,
                                   NSMatchingOptions options,
                                   NSRange range,
                                   NSString *_Nonnull pattern,
                                   NSRegularExpressionOptions rxOptions,
                                   PGReplaceBlock _Nonnull block,
                                   NSError **error);

NS_INLINE BOOL foo(NSString *s, NSRange r) {
    return ((r.location == 0) && (r.length == s.length));
}

@implementation NSString(Moscow)

    -(NSString *)stringByDupToLength:(NSUInteger)length {
        NSUInteger slen = self.length;

        if(slen) {
            if(length == 0) return @"";
            if(slen == length) return self.copy;
            if(slen > length) return [self substringToIndex:length];

            NSMutableString *str = [NSMutableString new];
            do { [str appendString:self]; } while((str.length + slen) <= length);
            if(str.length < length) [str appendString:[self substringToIndex:(length - str.length)]];
            return str;
        }

        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGFormat(PGErrMsgStringNotLongEnough, (NSUInteger)1, slen) userInfo:nil];
    }

    -(NSArray<NSTextCheckingResult *> *)matchesForPattern:(NSString *)pattern {
        return [self matchesForPattern:pattern options:0 error:NULL];
    }

    -(NSArray<NSTextCheckingResult *> *)matchesForPattern:(NSString *)pattern error:(NSError **)error {
        return [self matchesForPattern:pattern options:0 error:error];
    }

    -(NSArray<NSTextCheckingResult *> *)matchesForPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:error];
        return (regex ? [regex matchesInString:self options:0 range:self.range] : nil);
    }

    -(NSString *)stringByPaddingToLength:(NSUInteger)length {
        return [self stringByPaddingToLength:length withString:@" " startingAtIndex:0];
    }

    -(NSString *)stringByPaddingToLength:(NSUInteger)length withString:(NSString *)padding {
        return [self stringByPaddingToLength:length withString:padding startingAtIndex:0];
    }

    -(NSString *)stringByLeftPaddingToLength:(NSUInteger)length {
        return [self stringByLeftPaddingToLength:length withString:@" " startingAtIndex:0];
    }

    -(NSString *)stringByLeftPaddingToLength:(NSUInteger)length withString:(NSString *)padding {
        return [self stringByLeftPaddingToLength:length withString:padding startingAtIndex:0];
    }

    -(NSString *)stringByLeftPaddingToLength:(NSUInteger)length withString:(NSString *)padding startingAtIndex:(NSUInteger)idx {
        NSUInteger selfLength    = self.length;
        NSUInteger paddingLength = padding.length;

        if(selfLength < length) {
            if(paddingLength == 0) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Padding is empty" userInfo:nil];
            if(idx >= paddingLength) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Index beyond length of padding" userInfo:nil];

            NSMutableString *str         = [NSMutableString stringWithCapacity:length];
            NSUInteger      neededLength = (length - selfLength);
            [str appendString:[padding substringWithRange:NSMakeRange(idx, MIN(neededLength, (paddingLength - idx)))]];
            while((str.length + paddingLength) <= neededLength) [str appendString:padding];
            if(str.length < neededLength) [str appendString:[padding substringWithRange:NSMakeRange(0, (neededLength - str.length))]];
            [str appendString:self];

            return str;
        }

        return self;
    }

    -(NSString *)stringByMakingAbsolutePath {
        NSString *path = self;

        if([path isEqualToString:@"."] || [path hasPrefix:@"./"]) {
            path = PGFormat(@"%@%@", NSFileManager.defaultManager.currentDirectoryPath, [path substringFromIndex:1]);
        }
        else if([path isEqualToString:@".."] || [path hasPrefix:@"../"]) {
            path = PGFormat(@"%@%@", NSFileManager.defaultManager.currentDirectoryPath.stringByDeletingLastPathComponent, [path substringFromIndex:2]);
        }

        return path.stringByStandardizingPath.copy;
    }

    -(NSRange)range {
        return NSMakeRange(0, self.length);
    }

    -(NSString *)substringFrom:(NSUInteger)fromIdx to:(NSUInteger)toIdx {
        return ((fromIdx < toIdx) ? [self substringWithRange:NSMakeRange(fromIdx, (toIdx - fromIdx))] : @"");
    }

    -(NSArray<NSString *> *)split:(NSString *)pattern limit:(NSInteger)limit {
        /*
         * If we are a mutable string then make a copy so that stuff doesn't change while we're working.
         */
        return split((([self isKindOfClass:[NSMutableString class]]) ? self.copy : self), pattern, limit);
    }

    -(NSArray<NSString *> *)split:(NSString *)pattern {
        /*
         * If we are a mutable string then make a copy so that stuff doesn't change while we're working.
         */
        return split((([self isKindOfClass:[NSMutableString class]]) ? self.copy : self), pattern, 0);
    }

    -(NSString *)nullIfEmpty {
        return ((self.length) ? self : nil);
    }

    -(BOOL)matches:(NSString *)pattern {
        return foo(self, [NSRegularExpression rangeOfFirstMatchInString:self pattern:pattern]);
    }

    -(BOOL)matches:(NSString *)pattern error:(NSError **)error {
        return foo(self, [NSRegularExpression rangeOfFirstMatchInString:self pattern:pattern error:error]);
    }

    -(BOOL)matches:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error {
        return foo(self, [NSRegularExpression rangeOfFirstMatchInString:self pattern:pattern rxOptions:options error:error]);
    }

    -(BOOL)contains:(NSString *)pattern {
        return NSRangeValid([NSRegularExpression rangeOfFirstMatchInString:self pattern:pattern]);
    }

    -(BOOL)contains:(NSString *)pattern error:(NSError **)error {
        return NSRangeValid([NSRegularExpression rangeOfFirstMatchInString:self pattern:pattern error:error]);
    }

    -(BOOL)contains:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error {
        return NSRangeValid([NSRegularExpression rangeOfFirstMatchInString:self pattern:pattern rxOptions:options error:error]);
    }

    -(NSString *)trim {
        return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    }

    -(NSString *)copyIfSameObjectAs:(NSString *)other {
        return ((self == other) ? self.copy : self);
    }

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range
                                         options:(NSMatchingOptions)options
                                         pattern:(NSString *)pattern
                                       rxOptions:(NSRegularExpressionOptions)rxOptions
                                      usingBlock:(PGReplaceBlock)block
                                           error:(NSError **)error {
        return stringByReplacingMatches(self, options, range, pattern, rxOptions, block, error);
    }

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range
                                         options:(NSMatchingOptions)options
                                         pattern:(NSString *)pattern
                                      usingBlock:(PGReplaceBlock)block
                                           error:(NSError **)error {
        return stringByReplacingMatches(self, options, range, pattern, 0, block, error);
    }

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range
                                         pattern:(NSString *)pattern
                                       rxOptions:(NSRegularExpressionOptions)rxOptions
                                      usingBlock:(PGReplaceBlock)block
                                           error:(NSError **)error {
        return stringByReplacingMatches(self, 0, range, pattern, rxOptions, block, error);
    }

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block error:(NSError **)error {
        return stringByReplacingMatches(self, 0, range, pattern, 0, block, error);
    }

    -(NSString *)stringByReplacingMatchesWithOptions:(NSMatchingOptions)options
                                             pattern:(NSString *)pattern
                                           rxOptions:(NSRegularExpressionOptions)rxOptions
                                          usingBlock:(PGReplaceBlock)block
                                               error:(NSError **)error {
        return stringByReplacingMatches(self, options, self.range, pattern, rxOptions, block, error);
    }

    -(NSString *)stringByReplacingMatchesWithOptions:(NSMatchingOptions)options pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block error:(NSError **)error {
        return stringByReplacingMatches(self, options, self.range, pattern, 0, block, error);
    }

    -(NSString *)stringByReplacingMatchesWithPattern:(NSString *)pattern rxOptions:(NSRegularExpressionOptions)rxOptions usingBlock:(PGReplaceBlock)block error:(NSError **)error {
        return stringByReplacingMatches(self, 0, self.range, pattern, rxOptions, block, error);
    }

    -(NSString *)stringByReplacingMatchesWithPattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block error:(NSError **)error {
        return stringByReplacingMatches(self, 0, self.range, pattern, 0, block, error);
    }

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range
                                         options:(NSMatchingOptions)options
                                         pattern:(NSString *)pattern
                                       rxOptions:(NSRegularExpressionOptions)rxOptions
                                      usingBlock:(PGReplaceBlock)block {
        return stringByReplacingMatches(self, options, range, pattern, rxOptions, block, NULL);
    }

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range options:(NSMatchingOptions)options pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block {
        return stringByReplacingMatches(self, options, range, pattern, 0, block, NULL);
    }

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range pattern:(NSString *)pattern rxOptions:(NSRegularExpressionOptions)rxOptions usingBlock:(PGReplaceBlock)block {
        return stringByReplacingMatches(self, 0, range, pattern, rxOptions, block, NULL);
    }

    -(NSString *)stringByReplacingMatchesInRange:(NSRange)range pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block {
        return stringByReplacingMatches(self, 0, range, pattern, 0, block, NULL);
    }

    -(NSString *)stringByReplacingMatchesWithOptions:(NSMatchingOptions)options
                                             pattern:(NSString *)pattern
                                           rxOptions:(NSRegularExpressionOptions)rxOptions
                                          usingBlock:(PGReplaceBlock)block {
        return stringByReplacingMatches(self, options, self.range, pattern, rxOptions, block, NULL);
    }

    -(NSString *)stringByReplacingMatchesWithOptions:(NSMatchingOptions)options pattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block {
        return stringByReplacingMatches(self, options, self.range, pattern, 0, block, NULL);
    }

    -(NSString *)stringByReplacingMatchesWithPattern:(NSString *)pattern rxOptions:(NSRegularExpressionOptions)rxOptions usingBlock:(PGReplaceBlock)block {
        return stringByReplacingMatches(self, 0, self.range, pattern, rxOptions, block, NULL);
    }

    -(NSString *)stringByReplacingMatchesWithPattern:(NSString *)pattern usingBlock:(PGReplaceBlock)block {
        return stringByReplacingMatches(self, 0, self.range, pattern, 0, block, NULL);
    }

    -(NSString *)stringByReplacingMacros:(PGMacroBlock)block {
        PGReplaceBlock macroBlock = ^NSString *(NSTextCheckingResult *match, BOOL *pStop) {
            NSString *macroRepl = block([self substringWithRange:[match rangeAtIndex:2]], pStop);
            return (macroRepl ? PGFormat(@"%@%@", [self substringWithRange:[match rangeAtIndex:1]], macroRepl) : [self substringWithRange:match.range]);
        };
        return stringByReplacingMatches(self, 0, self.range, PGMacroPattern, 0, macroBlock, NULL);
    }

@end

NSString *stringByReplacingMatches(NSString *string,
                                   NSMatchingOptions options,
                                   NSRange range,
                                   NSString *pattern,
                                   NSRegularExpressionOptions rxOptions,
                                   PGReplaceBlock block,
                                   NSError **error) {
    if(string) {
        NSArray<NSTextCheckingResult *> *matches = [NSRegularExpression matchesInString:string options:options range:range pattern:pattern rxOptions:rxOptions error:error];

        if(matches) {
            if(matches.count) {
                NSMutableString *newString = [NSMutableString stringWithCapacity:string.length];
                NSUInteger      lastLoc    = 0;
                BOOL            stop       = NO;

                for(NSTextCheckingResult *result in matches) {
                    NSRange matchRange = result.range;

                    if(NSRangeValid(matchRange)) {
                        if(matchRange.location) {
                            [newString appendString:[string substringFrom:lastLoc to:matchRange.location]];
                            lastLoc = NSMaxRange(matchRange);
                        }

                        NSString *repString = block(result, &stop);
                        [newString appendString:(repString ?: [string substringWithRange:matchRange])];
                        if(stop) break;
                    }
                }

                if(lastLoc < string.length) [newString appendString:[string substringFromIndex:lastLoc]];
                return newString;
            }

            return string;
        }
    }

    return nil;
}

NSArray<NSString *> *split(NSString *string, NSString *pattern, NSInteger limit) {
    /*
     * Is the compiler smart enough to know that the result is supposed to survive
     * beyond the auto release pool?
     */
    NSArray<NSString *> *_array = @[ string ];

    if(pattern.length && (limit != 1)) {
        NSArray<NSTextCheckingResult *> *res = [NSRegularExpression matchesInString:string pattern:pattern];

        if(res.count) {
            NSUInteger last = 0, cc = ((limit > 0) ? MIN(res.count, limit - 1) : res.count);
            NSMutableArray<NSString *> *array = [NSMutableArray arrayWithCapacity:(cc + 1)];

            for(NSUInteger x = 0; x < cc; ++x) {
                NSRange r = res[x].range;

                if((r.location || r.length) && (r.location != NSNotFound)) {
                    [array addObject:[string substringFrom:last to:r.location]];
                    last = NSMaxRange(r);
                }
            }

            [array addObject:[string substringFrom:last to:string.length]];

            if(limit == 0) {
                NSUInteger a1 = array.count, a2 = a1;
                while(a1 && (array[a1 - 1].length == 0)) a1--;

                _array = ((a1 < a2) ? (a1 ? [array subarrayWithRange:NSMakeRange(0, a1)] : @[]) : array.copy);
            }
            else {
                _array = array.copy;
            }
        }
    }

    return _array;
}

