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
#import "PGProjectFile.h"

@implementation PBXBuildPhase {
    }

    @synthesize files = _files;
    @synthesize buildActionMask = _buildActionMask;
    @synthesize runOnlyForDeploymentPostprocessing = _runOnlyForDeploymentPostprocessing;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            _runOnlyForDeploymentPostprocessing = [self ivBool:@"runOnlyForDeploymentPostprocessing"];
            _buildActionMask                    = [self ivInt:@"buildActionMask"];

            NSMutableArray      *array = (NSMutableArray *)_files = [NSMutableArray new];
            NSArray<NSString *> *refs  = (NSArray<NSString *> *)[self iv:@"files"];

            [refs enumerateObjectsUsingBlock:^(NSString *itemId, NSUInteger idx, BOOL *stop) {
                PBXBuildFile *buildFile = (PBXBuildFile *)[self.projectFile itemForID:itemId];
                if(buildFile) [array addObject:buildFile];
            }];
        }

        return self;
    }

@end
