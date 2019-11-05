/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXGroup.m
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

#import "PBXGroup.h"
#import "PGProjectFile.h"
#import "PBXFileReference.h"

@implementation PBXGroup {
    }

    @synthesize name = _name;
    @synthesize path = _path;
    @synthesize sourceTree = _sourceTree;
    @synthesize children = _children;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            _name       = [[self iv:@"name"] copy];
            _path       = [[self iv:@"path"] copy];
            _sourceTree = [[self iv:@"sourceTree"] copy];
            _children   = [NSMutableArray new];

            NSArray<NSString *> *childrenIDs = [self iv:@"children"];

            [childrenIDs enumerateObjectsUsingBlock:^(NSString *childId, NSUInteger idx, BOOL *stop) {
                PBXFileReference *item = (PBXFileReference *)[self.projectFile itemForID:childId];
                if(item) [((NSMutableArray *)_children) addObject:item];
            }];
        }

        return self;
    }

@end
