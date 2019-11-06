/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: Tools.m
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

#import "Tools.h"

dispatch_queue_t PGWorkQueue(void) {
    static dispatch_queue_t _workQueue     = NULL;
    static dispatch_once_t  _workQueueOnce = 0;

    _dispatch_once(&_workQueueOnce, ^{ _workQueue = dispatch_queue_create("PGWorkQueue", DISPATCH_QUEUE_SERIAL); });
    return _workQueue;
}

@implementation NSString(PBXBuilder)

    -(BOOL)matches:(NSString *)pattern {
        NSError *error = nil;
        return [self matches:pattern error:&error];
    }

    -(BOOL)matches:(NSString *)pattern error:(NSError **)error {
        return [self matches:pattern options:0 error:error];
    }

    -(BOOL)matches:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:error];
        NSUInteger          len    = self.length;
        NSRange             range  = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, len)];
        return ((range.location == 0) && (range.length == len));
    }

    -(BOOL)contains:(NSString *)pattern {
        NSError *error = nil;
        return [self contains:pattern options:0 error:&error];
    }

    -(BOOL)contains:(NSString *)pattern error:(NSError **)error {
        return [self contains:pattern options:0 error:error];
    }

    -(BOOL)contains:(NSString *)pattern options:(NSRegularExpressionOptions)options error:(NSError **)error {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:error];
        NSUInteger          len    = self.length;
        NSRange             range  = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, len)];
        return NO;
    }

@end
