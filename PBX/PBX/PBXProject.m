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

#import <Moscow/Moscow.h>
#import "PBXProjectFile.h"
#import "PBX.h"

NSArray<PBXTarget *> *sortTargetsByDependencies(NSArray<PBXTarget *> *srcArrayX);

@implementation PBXProject {
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            _mainGroup       = [self itemForKey:@"mainGroup"];
            _productRefGroup = [self itemForKey:@"productRefGroup"];
            _targets         = sortTargetsByDependencies([self ivx:@"targets"]);
        }

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

    -(NSDictionary<NSString *, id> *)attributes {
        return ([self iv:@"attributes"] ?: [NSDictionary new]);
    }

    -(PBXTarget *)targetWithName:(NSString *)name {
        for(PBXTarget *target in self.targets) if([target.name isEqualToString:name]) return target;
        return nil;
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        PBXAppendItem(str, indent, @"compatibilityVersion", self.compatibilityVersion);
        PBXAppendItem(str, indent, @"developmentRegion", self.developmentRegion);
        PBXAppendItem(str, indent, @"hasScannedForEncodings", @(self.hasScannedForEncodings));
        PBXAppendItem(str, indent, @"knownRegions", self.knownRegions);
        PBXAppendItem(str, indent, @"projectDirPath", self.projectDirPath);
        PBXAppendItem(str, indent, @"projectRoot", self.projectRoot);
        PBXAppendItem(str, indent, @"buildConfigurationList", self.buildConfigurationList);
        PBXAppendItem(str, indent, @"targets", self.targets);
        PBXAppendItem(str, indent, @"attributes", self.attributes);
        PBXAppendItem(str, indent, @"productRefGroup", self.productRefGroup);
        PBXAppendItem(str, indent, @"mainGroup", self.mainGroup);
        return str;
    }

@end

BOOL isTargetInArray(PBXTarget *target, NSArray<PBXTarget *> *dstArray) {
    for(PBXTargetDependency *dep in target.dependencies) if(![dstArray containsObject:dep.target]) return NO;
    return YES;
}

BOOL moveDepTargets(NSMutableArray<PBXTarget *> *srcArray, NSMutableArray<PBXTarget *> *dstArray) {
    BOOL didSomething = NO;

    for(PBXTarget *target in srcArray) {
        if(isTargetInArray(target, dstArray)) {
            [dstArray addObject:target];
            didSomething = YES;
        }
    }

    if(didSomething) [srcArray removeObjectsInArray:dstArray];
    return didSomething;
}

BOOL moveNonDepTargets(NSMutableArray<PBXTarget *> *srcArray, NSMutableArray<PBXTarget *> *dstArray) {
    BOOL didSomething = NO;

    for(PBXTarget *target in srcArray) {
        if(target.dependencies.count == 0) {
            [dstArray addObject:target];
            didSomething = YES;
        }
    }

    if(didSomething) [srcArray removeObjectsInArray:dstArray];
    return didSomething;
}

NSArray<PBXTarget *> *sortTargetsByDependencies(NSArray<PBXTarget *> *srcArrayX) {
    NSMutableArray<PBXTarget *> *srcArray = [NSMutableArray arrayWithArray:srcArrayX];
    NSMutableArray<PBXTarget *> *dstArray = [NSMutableArray new];

    /*
     * Now let's sort the targets by internal dependencies.
     * Start by finding the targets with no dependencies and
     * adding them to the destination array first.
     */
    BOOL didSomething = moveNonDepTargets(srcArray, dstArray);

    /*
     * Now do the same with the remaining targets whose dependencies are all in the
     * destination array. Repeat until either no more targets remain in the source
     * array or any remaining targets have no internal dependencies (ie: their
     * dependencies are all external).
     */
    while(didSomething && (srcArray.count > 0)) didSomething = moveDepTargets(srcArray, dstArray);

    /*
     * Copy any remaining targets over.
     */
    if(srcArray.count) {
        [dstArray addObjectsFromArray:srcArray];
        [srcArray removeAllObjects];
    }

    return dstArray;
}

