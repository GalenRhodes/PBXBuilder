/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXBuildFile.m
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

#import "PBXBuildFile.h"
#import "PBXFileReference.h"
#import "PGProjectFile.h"

@implementation PBXBuildFile {
    }

    @synthesize fileRef = _fileRef;
    @synthesize isPublic = _isPublic;  //settings = {ATTRIBUTES = (Public, ); };

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            _fileRef = (PBXFileReference *)[self.projectFile itemForID:[self iv:@"fileRef"]];

            [((NSArray<NSString *> *)((NSDictionary *)[self iv:@"settings"])[@"ATTRIBUTES"]) enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
                if([str isEqualToString:@"Public"]) {
                    self->_isPublic = YES;
                    *stop = YES;
                }
            }];
        }

        return self;
    }

@end
