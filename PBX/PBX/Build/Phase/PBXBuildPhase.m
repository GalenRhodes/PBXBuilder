/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXBuildPhase.m
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

#import "PBXBuildPhase.h"
#import "PBXBuildFile.h"
#import "PBXProjectFile.h"

@implementation PBXBuildPhase {
        NSArray<PBXBuildFile *> *_files;
        dispatch_once_t         _filesOnce;
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSArray<PBXBuildFile *> *)files {
        dispatch_once(&_filesOnce, ^{
            NSMutableArray      *array = [NSMutableArray new];
            NSArray<NSString *> *refs  = (NSArray<NSString *> *)[self iv:@"files"];
            [refs enumerateObjectsUsingBlock:^(NSString *itemId, NSUInteger idx, BOOL *stop) { [array addObjectWithCheck:[self itemForID:itemId]]; }];
            _files = array;
        });
        return _files;
    }

    -(NSInteger)buildActionMask {
        return [self ivInt:@"buildActionMask"];
    }

    -(BOOL)runOnlyForDeploymentPostprocessing {
        return [self ivBool:@"runOnlyForDeploymentPostprocessing"];
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        PBXAppendItem(str, indent, @"files", self.files);
        PBXAppendItem(str, indent, @"buildActionMask", @(self.buildActionMask));
        PBXAppendItem(str, indent, @"runOnlyForDeploymentPostprocessing", [PGBool boolObj:self.runOnlyForDeploymentPostprocessing]);
        return str;
    }

@end
