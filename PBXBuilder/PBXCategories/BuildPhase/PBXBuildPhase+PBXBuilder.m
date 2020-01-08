/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXBuildPhase+PBXBuilder.m
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

NSString *const PBXFormatDoingWithFile = @"\e[0m\e[97;40m\e[4C]\e[10C[\e[38;5;6m%@\e[97m] \e[38;5;180m%@\e[97m - \e[38;5;32m%@";
NSString *const PBXMessageFailed       = @"\e[91mFAILED\e[0m\e[0K";

@implementation PBXBuildPhase(PBXBuilder)

    -(NSInteger)build:(PBXRunInfo *)runInfo target:(PBXTarget *)target error:(NSError **)pError {
        PBXBuildPhasePerFile blk = ^NSInteger(PBXBuildFile *f, NSError **e) { return 0; };
        return [self doPerFile:blk action:@"BUILDING" silent:NO error:pError];
    }

    -(NSInteger)doPerFile:(PBXBuildPhasePerFile)perFileBlock action:(NSString *)action silent:(BOOL)silent error:(NSError **)pError {
        for(PBXBuildFile *file in self.files) {
            if(!silent) PGPrintf(PBXFormatDoingWithFile, action, (file.fileRef.name ?: file.fileRef.path), PBXMessageWorking);
            NSInteger res = perFileBlock(file, pError);

            if(res) {
                if(!silent) PGPrintStr(PBXMessageFailed);
                return res;
            }

            if(!silent) PGPrintf(PBXFormat8, PBXMessageSuccess);
        }

        return 0;
    }

    -(NSUInteger)maxFilenameLength {
        NSUInteger mx = 0;

        for(PBXBuildFile *f in self.files) {
            NSString *fn = (f.fileRef.name ?: f.fileRef.path);
            if(fn.length > mx) mx = fn.length;
        }

        return mx;
    }

@end
