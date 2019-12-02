/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: XCConfigurationList.m
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

#import "XCConfigurationList.h"
#import "XCBuildConfiguration.h"
#import "PGProjectFile.h"

@implementation XCConfigurationList {
        NSArray         *_buildConfigurations;
        dispatch_once_t _buildConfigurationsOnce;
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(BOOL)defaultConfigurationIsVisible {
        return [self ivBool:@"defaultConfigurationIsVisible"];
    }

    -(NSString *)defaultConfigurationName {
        return [self iv:@"defaultConfigurationName"];
    }

    -(NSArray<XCBuildConfiguration *> *)buildConfigurations {
        dispatch_once(&_buildConfigurationsOnce, ^{
            NSArray<NSString *> *list  = [self iv:@"buildConfigurations"];
            NSMutableArray      *array = [NSMutableArray arrayWithCapacity:list.count ?: 10];

            [list enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) { [array addObjectWithCheck:[self itemForID:str]]; }];
            _buildConfigurations = array;
        });

        return _buildConfigurations;
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        id item = boolStr(self.defaultConfigurationIsVisible);
        PBXAppendItem(str, indent, @"defaultConfigurationIsVisible", item);
        PBXAppendItem(str, indent, @"defaultConfigurationName", self.defaultConfigurationName);
        PBXAppendItem(str, indent, @"buildConfigurations", self.buildConfigurations);
        return str;
    }

@end
