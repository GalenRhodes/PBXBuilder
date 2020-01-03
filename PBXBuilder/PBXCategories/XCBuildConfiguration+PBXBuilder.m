/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: XCBuildConfiguration+PBXBuilder.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 1/3/20
 *
 * Copyright © 2020 Project Galen. All rights reserved.
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

#import "XCBuildConfiguration+PBXBuilder.h"

@implementation XCBuildConfiguration(PBXBuilder)

    -(void)debugPrint {
        NSDictionary<NSString *, id> *settings = self.buildSettings;
        NSArray<NSString *>          *keys     = [settings.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *s1, NSString *s2) { return [s1 compare:s2]; }];
        NSUInteger                   mx2       = 0;

        for(NSString *key in keys) mx2 = MAX(mx2, key.length);
        for(NSString *key in keys) {
            PGPrintf(@"\e[0m\e[97;40m\e[4C]\e[%luC\e[38;5;187m%@\e[38;5;15m = \e[38;5;123m%@\e[0m\n", ((mx2 - key.length) + 20), key, [settings[key] description]);
        }
    }

@end
