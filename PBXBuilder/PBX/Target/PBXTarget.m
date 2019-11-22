/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXTarget.m
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

#import "PBXTarget.h"
#import "XCConfigurationList.h"
#import "PBXBuildPhase.h"
#import "PBXTargetDependency.h"
#import "PGProjectFile.h"
#import <Moscow/Moscow.h>

@implementation PBXTarget {
        NSArray<PBXBuildPhase *>       *_buildPhases;
        NSArray<PBXTargetDependency *> *_dependencies;
        dispatch_once_t                _buildPhasesOnce;
        dispatch_once_t                _dependenciesOnce;
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSString *)name {
        return [self iv:@"name"];
    }

    -(NSString *)productName {
        return [self iv:@"productName"];
    }

    -(XCConfigurationList *)buildConfigurationList {
        return [self itemForKey:@"buildConfigurationList"];
    }

    -(NSArray<PBXBuildPhase *> *)buildPhases {
        dispatch_once(&_buildPhasesOnce, ^{
            NSMutableArray<PBXBuildPhase *> *array = [NSMutableArray new];
            NSArray<NSString *>             *list  = [self iv:@"buildPhases"];
            [list enumerateObjectsUsingBlock:^(NSString *itemId, NSUInteger idx, BOOL *stop) { [array addObjectWithCheck:[self itemForID:itemId]]; }];
            _buildPhases = [array copy];
        });
        return _buildPhases;
    }

    -(NSArray<PBXTargetDependency *> *)dependencies {
        dispatch_once(&_dependenciesOnce, ^{
            NSMutableArray<PBXTargetDependency *> *array = [NSMutableArray new];
            NSArray<NSString *>                   *list  = [self iv:@"dependencies"];
            [list enumerateObjectsUsingBlock:^(NSString *itemId, NSUInteger idx, BOOL *stop) { [array addObjectWithCheck:[self itemForID:itemId]]; }];
            _dependencies = [array copy];
        });
        return _dependencies;
    }

@end
