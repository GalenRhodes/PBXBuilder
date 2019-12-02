/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGBool.m
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

#import "PGBool.h"

@implementation PGBool {
    }

    @synthesize boolValue = _boolValue;

    -(instancetype)initWithBool:(BOOL)boolValue {
        self = [super init];

        if(self) {
            _boolValue = boolValue;
        }

        return self;
    }

    +(PGBool *)boolObj:(BOOL)boolValue {
        static PGBool          *_yes = nil;
        static PGBool          *_no  = nil;
        static dispatch_once_t _once = 0;

        dispatch_once(&_once, ^{
            _yes = [[PGBool alloc] initWithBool:YES];
            _no  = [[PGBool alloc] initWithBool:NO];
        });

        return (boolValue ? _yes : _no);
    }

    +(PGBool *)boolYes {
        return [self boolObj:YES];
    }

    +(PGBool *)boolNo {
        return [self boolObj:NO];
    }

    -(NSString *)description {
        return (self.boolValue ? @"YES" : @"NO");
    }

    -(BOOL)isEqual:(id)other {
        return (other && ((other == self) || ([other isKindOfClass:self.class] && [self isEqualToABool:other])));
    }

    -(BOOL)isEqualToABool:(PGBool *)aBool {
        return (aBool && ((aBool == self) || (aBool.boolValue == self.boolValue)));
    }

    -(NSUInteger)hash {
        return (NSUInteger)self.boolValue;
    }

@end
