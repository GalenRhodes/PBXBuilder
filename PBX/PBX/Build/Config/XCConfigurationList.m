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
#import "PBXProjectFile.h"
#import "PBXPrivate.h"

@implementation XCConfigurationList {
        PBXNativeTarget *_target;
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            _buildConfigurations = [self ivx:@"buildConfigurations"];
            for(XCBuildConfiguration *bc in _buildConfigurations) bc.configurationList = self;
        }

        return self;
    }

    -(BOOL)defaultConfigurationIsVisible {
        return [self ivBool:@"defaultConfigurationIsVisible"];
    }

    -(NSString *)defaultConfigurationName {
        return [self iv:@"defaultConfigurationName"];
    }

    -(XCBuildConfiguration *)defaultConfiguration {
        return [self buildConfigurationForName:self.defaultConfigurationName];
    }

    -(XCBuildConfiguration *)buildConfigurationForName:(NSString *)name {
        for(XCBuildConfiguration *xcbc in self.buildConfigurations) if([name isEqualToString:xcbc.name]) return xcbc;
        return nil;
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        id item = [PGBool boolObj:self.defaultConfigurationIsVisible];
        PBXAppendItem(str, indent, @"defaultConfigurationIsVisible", item);
        PBXAppendItem(str, indent, @"defaultConfigurationName", self.defaultConfigurationName);
        PBXAppendItem(str, indent, @"buildConfigurations", self.buildConfigurations);
        return str;
    }

    -(PBXNativeTarget *)target {
        return _target;
    }

    -(void)setTarget:(PBXNativeTarget *)target {
        _target = target;
    }

@end
