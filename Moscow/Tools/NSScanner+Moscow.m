/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: NSScanner+Moscow.m
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

#import "NSScanner+Moscow.h"

@implementation NSScanner(Moscow)

    +(unsigned long long)atoull:(NSString *)str success:(BOOL *)success {
        unsigned long long v = 0;
        BOOL               f = NO;

        if(str.length) {
#ifdef __APPLE__
            f = [[[NSScanner alloc] initWithString:str] scanUnsignedLongLong:&v];
#else
            char *s = strdup(str.UTF8String);
            char *t = NULL;

            v = strtoull(s, &t, 10);
            f = (s != t);
            free(s);
#endif
        }

        if(success) *success = f;
        return v;
    }

//@f:0
#ifndef __APPLE__

    -(BOOL)scanUnsignedLongLong:(unsigned long long *)ullVal {
        char               *s = strdup(self.string.UTF8String);
        char               *t = NULL;
        unsigned long long v  = strtoull(s, &t, 10);
        BOOL               f  = (s != t);

        free(s);
        if(f && ullVal) *ullVal = v;
        return f;
    }

#endif
//@f:1

@end
