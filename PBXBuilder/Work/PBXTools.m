/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGXTools.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/26/19
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
#import "PBXTools.h"
#import "PGRunInfo.h"

NSString *const PGFoundProjectFilesKey = @"PGFoundProjectFilesKey";

PBXErrorCodes parseFindProjectResults(NSString *dir, NSArray<NSString *> *array, NSString **pProjectName, NSString **pProjectFilename, NSError **error) {
    NSError             *e     = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=/)([^/.]+)\\.xcodeproj/project.pbxproj" options:0 error:&e];

    setpptr(pProjectName, nil);
    setpptr(pProjectFilename, nil);

    if(regex) {
        NSMutableArray<NSArray<NSString *> *> *files = [NSMutableArray new];

        NSUInteger maxLength = 0;

        for(NSString *path in array) {
            NSTextCheckingResult *r = [regex firstMatchInString:path options:0 range:path.range];

            if(r) {
                NSRange range = [r rangeAtIndex:1];

                if(range.location != NSNotFound) {
                    NSString *projName = [path substringWithRange:range];
                    maxLength = MAX(maxLength, projName.length);
                    [files addObject:@[ projName, path ]];
                }
            }
        }

        if(files.count == 1) {
            NSArray<NSString *> *q = files[0];

            setpptr(pProjectName, q[0]);
            setpptr(pProjectFilename, q[1]);
            setpptr(error, nil);
            return PBX_NO_ERROR;
        }
        else if(files.count > 1) {
            NSString     *reason = PGFormat(@"Found multiple projects in the search path \"%@\". Which did you mean?", dir);
            NSDictionary *info   = @{ NSLocalizedDescriptionKey: reason, PGFoundProjectFilesKey: files };
            setpptr(error, [NSError errorWithDomain:PGProjErrorDomain code:PBX_MULTIPLE_PROJECT_FILES_FOUND userInfo:info]);
            return PBX_MULTIPLE_PROJECT_FILES_FOUND;
        }
        else {
            NSString *reason = PGFormat(@"No projects were located in the search path \"%@\".", dir);
            setpptr(error, [NSError errorWithDomain:PGProjErrorDomain code:PBX_NO_PROJECT_FILE_FOUND userInfo:@{ NSLocalizedDescriptionKey: reason }]);
            return PBX_NO_PROJECT_FILE_FOUND;
        }
    }
    else {
        setpptr(error, [NSError errorWithDomain:e.domain code:PBX_INVALID_REGEX_PATTERN userInfo:e.userInfo]);
        return PBX_INVALID_REGEX_PATTERN;
    }
}

