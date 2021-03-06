/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXTarget+PBXBuilder.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 12/19/19
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

#import "PBXTools.h"

@implementation PBXTarget(PBXBuilder)

    -(BOOL)isBuilt:(PBXRunInfo *)runInfo {
        return [runInfo hasTargetBeenBuilt:self.itemId];
    }

    -(NSInteger)completeBuild:(PBXRunInfo *)runInfo error:(NSError **)pError {
        [runInfo.builtTargets addObject:self];
        return 0;
    }

    -(NSInteger)build:(PBXRunInfo *)runInfo error:(NSError **)pError {
        if(![self isBuilt:runInfo]) {
            for(PBXTargetDependency *dep in self.dependencies) {
                NSInteger res = [dep.target build:runInfo error:pError];
                if(res) return res;
            }
#ifdef DEBUG
            NSUInteger   mx1 = 0;
            for(NSString *s in XCBuildConfiguration.allBuildConfigurationNames) mx1 = MAX(mx1, s.length);
            NSArray<XCBuildConfiguration *> *buildConfigurations = self.buildConfigurationList.buildConfigurations;

            for(XCBuildConfiguration *buildConfig in buildConfigurations) {
                PGPrintf(PBXFormat3, PBXMessageTarget, self.name, ((runInfo.targetNameMaxLength - self.name.length) + 1), @"Build Configuration", buildConfig.name);
                [buildConfig debugPrint];
            }
#endif
        }

        return 0;
    }

@end
