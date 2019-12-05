/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXCopyFilesBuildPhase.m
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

#import "PBXCopyFilesBuildPhase.h"
#import "PBXProjectFile.h"

@implementation PBXCopyFilesBuildPhase {
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSString *)dstPath {
        return [self iv:@"dstPath"];
    }

    -(NSInteger)dstSubfolderSpec {
        return [self ivInt:@"dstSubfolderSpec"];
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        PBXAppendItem(str, indent, @"dstPath", self.dstPath);
        PBXAppendItem(str, indent, @"dstSubfolderSpec", @(self.dstSubfolderSpec));
        return str;
    }
@end
