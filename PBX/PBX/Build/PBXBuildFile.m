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
#import "PBXProjectFile.h"

@implementation PBXBuildFile {
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSDictionary<NSString *, id> *)settings {
        return ((NSDictionary *)[self iv:@"settings"] ?: [NSDictionary new]);
    }

    -(NSArray<NSString *> *)attributes {
        return ((NSArray<NSString *> *)self.settings[@"ATTRIBUTES"] ?: [NSArray new]);
    }

    -(BOOL)isPublic {
        for(NSString *str in self.attributes) if([str isEqualToString:@"Public"]) return YES;
        return NO;
    }

    -(BOOL)isPrivate {
        for(NSString *str in self.attributes) if([str isEqualToString:@"Private"]) return YES;
        return NO;
    }

    -(PBXFileReference *)fileRef {
        return [self itemForKey:@"fileRef"];
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        PBXAppendItem(str, indent, @"fileRef", self.fileRef);
        PBXAppendItem(str, indent, @"isPublic", [PGBool boolObj:self.isPublic]);
        PBXAppendItem(str, indent, @"isPrivate", [PGBool boolObj:self.isPrivate]);
        PBXAppendItem(str, indent, @"settings", self.settings);
        PBXAppendItem(str, indent, @"attributes", self.attributes);
        return str;
    }

@end
