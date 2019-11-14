/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXItem.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/4/19
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

#import "PBXItem.h"
#import "PGProjectFile.h"
#import "Tools.h"

@implementation PBXItem {
        NSRecursiveLock *_lock;
    }

    @synthesize itemId = _itemId;
    @synthesize projectFile = _projectFile;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super init];

        if(self) {
            if(itemId) {
                _lock        = [NSRecursiveLock new];
                _projectFile = projectFile;
                _itemId      = [itemId copy];
            }
            else {
                return nil;
            }
        }

        return self;
    }

    -(NSString *)objType {
        return [self iv:@"isa"];
    }

    -(nullable id)iv:(NSString *)key {
        NSDictionary<NSString *, NSDictionary<NSString *, id> *> *dict = self.projectFile.projectPBX[self.itemId];
        return dict[key];
    }

    -(BOOL)ivBool:(NSString *)key {
        return ([[self iv:key] description] ?: @"0").boolValue;
    }

    -(NSInteger)ivInt:(NSString *)key {
        return ([[self iv:key] description] ?: @"0").integerValue;
    }

    -(NSUInteger)ivUInt:(NSString *)key {
        BOOL f = NO;
        return (NSUInteger)[NSScanner atoull:key success:&f];
    }

    -(id)itemForKey:(NSString *)key {
        return (key ? [self itemForID:[[self iv:key] description]] : nil);
    }

    -(id)itemForID:(NSString *)itemId {
        return (itemId ? [self.projectFile itemForID:itemId] : nil);
    }

    -(void)lock {
        [_lock lock];
    }

    -(void)unlock {
        [_lock unlock];
    }

@end
