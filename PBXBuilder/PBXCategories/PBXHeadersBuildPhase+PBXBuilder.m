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
        NSInteger res = [super build:runInfo target:target error:pError];
        if(res) return res;

        NSFileManager *fm          = NSFileManager.defaultManager;
        NSString      *destPublic  = PGFormat(@"%@/headers/%@/%@", runInfo.buildDir, @"public", target.name);
        NSString      *destPrivate = PGFormat(@"%@/headers/%@/%@", runInfo.buildDir, @"private", target.name);

        if(![fm createDirectoryAtPath:destPublic withIntermediateDirectories:YES attributes:nil error:pError]) return (*pError).code;
        if(![fm createDirectoryAtPath:destPrivate withIntermediateDirectories:YES attributes:nil error:pError]) return (*pError).code;

        for(PBXBuildFile *file in self.files) {
            NSString *dest = PGFormat(@"%@/%@", (file.isPublic ? destPublic : destPrivate), file.fileRef.path);
            NSString *src  = file.fileRef.realPath;
            PGPrintf(@"Copying \"%@\" to \"%@\"...\n", src, dest);
            //if(![fm copyItemAtPath:src toPath:dest error:pError]) return (*pError).code;
        }

        /*
         * DO BUILDPHASE STUFF.
         */
        return res;
    }

@end
