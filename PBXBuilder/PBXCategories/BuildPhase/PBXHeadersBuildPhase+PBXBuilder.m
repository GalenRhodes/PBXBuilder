/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXHeadersBuildPhase+PBXBuilder.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 12/20/19
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

@implementation PBXHeadersBuildPhase(PBXBuilder)

    -(NSInteger)build:(PBXRunInfo *)runInfo target:(PBXTarget *)target error:(NSError **)pError {
        XCBuildConfiguration *config = [target.buildConfigurationList buildConfigurationForName:runInfo.buildConfigurationName];

        NSString *destPrivate = (config.buildSettings[@"PRIVATE_HEADERS_FOLDER_PATH"]);
        NSString *destPublic  = (config.buildSettings[@"PUBLIC_HEADERS_FOLDER_PATH"]);

        if(!(destPublic && destPrivate)) {
            NSString *frameworkVersion = (config.buildSettings[@"FRAMEWORK_VERSION"] ?: @"A");
            NSString *wrapperExtension = (config.buildSettings[@"WRAPPER_EXTENSION"] ?: @"framework");

            if(!destPublic) destPublic   = PGFormat(@"%@/%@.%@/Versions/%@/Headers", runInfo.buildDir, target.name, wrapperExtension, frameworkVersion);
            if(!destPrivate) destPrivate = PGFormat(@"%@/%@.%@/Versions/%@/PrivateHeaders", runInfo.buildDir, target.name, wrapperExtension, frameworkVersion);
        }

        if(!createDir(destPublic, pError)) return (*pError).code;
        if(!createDir(destPrivate, pError)) return (*pError).code;

        PBXBuildPhasePerFile blk = ^NSInteger(PBXBuildFile *f, NSError **e) {
            PBXFileReference *fr = f.fileRef;
            return (copyFile(fr.realPath, PGFormat(@"%@/%@", (f.isPublic ? destPublic : destPrivate), (fr.name ?: fr.path)), e) ? 0 : (*e).code);
        };

        return [self doPerFile:blk action:@"Copying" silent:NO error:pError];
    }

@end
