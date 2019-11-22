/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXProject.m
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

#import "PBXProject.h"
#import "XCConfigurationList.h"
#import "PGProjectFile.h"
#import "PBXTarget.h"
#import "PBXGroup.h"
#import <Moscow/Moscow.h>

@implementation PBXProject {
        NSArray<PBXTarget *> *_targets;
        dispatch_once_t      _targetsOnce;
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSString *)compatibilityVersion {
        return [self iv:@"compatibilityVersion"];
    }

    -(NSString *)developmentRegion {
        return [self iv:@"developmentRegion"];
    }

    -(BOOL)hasScannedForEncodings {
        return [self ivBool:@"hasScannedForEncodings"];
    }

    -(NSArray<NSString *> *)knownRegions {
        return [self iv:@"knownRegions"];
    }

    -(NSString *)projectDirPath {
        return [self iv:@"projectDirPath"];
    }

    -(NSString *)projectRoot {
        return [self iv:@"projectRoot"];
    }

    -(XCConfigurationList *)buildConfigurationList {
        return [self itemForKey:@"buildConfigurationList"];
    }

    -(NSArray<PBXTarget *> *)targets {
        dispatch_once(&_targetsOnce, ^{
            NSMutableArray<PBXTarget *> *array = [NSMutableArray new];
            NSArray<NSString *>         *refs  = [self iv:@"targets"];
            [refs enumerateObjectsUsingBlock:^(NSString *itemId, NSUInteger idx, BOOL *stop) { [array addObjectWithCheck:[self itemForID:itemId]]; }];
            _targets = array;
        });
        return _targets;
    }

    -(NSDictionary<NSString *, id> *)attributes {
        return ([self iv:@"attributes"] ?: [NSDictionary new]);
    }

    -(PBXGroup *)productRefGroup {
        return [self itemForKey:@"productRefGroup"];
    }

    -(PBXGroup *)mainGroup {
        return [self itemForKey:@"mainGroup"];
    }

@end
