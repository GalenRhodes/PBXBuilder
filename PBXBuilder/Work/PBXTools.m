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

NSString *const PGFoundProjectFilesKey = @"PGFoundProjectFilesKey";
NSString *const PGProjErrorDomain      = @"com.projectgalen.PBXBuilder";

NSError *pbxMakeError(NSInteger code, NSString *reason, NSDictionary *userInfo) {
    if((reason = reason.trim).length == 0) reason = @"Unknown error";
    NSMutableDictionary *tUserInfo                = userInfo ? userInfo.mutableCopy : [NSMutableDictionary new];
    tUserInfo[NSLocalizedDescriptionKey] = reason;
    return [NSError errorWithDomain:PGProjErrorDomain code:code userInfo:tUserInfo];
}

void printfc(NSUInteger maxLength, NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    if(str.length > maxLength) str = [str substringWithRange:NSMakeRange(0, maxLength)];
    PGPrintStr(str);
    PGPrintStr(@"\n");
    va_end(args);
}

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
            setpptr(error, [NSError errorWithDomain:PGProjErrorDomain code:PBX_MULTIPLE_PROJECTS_FOUND userInfo:info]);
            return PBX_MULTIPLE_PROJECTS_FOUND;
        }
        else {
            NSString *reason = PGFormat(@"No projects were located in the search path \"%@\".", dir);
            setpptr(error, [NSError errorWithDomain:PGProjErrorDomain code:PBX_PROJECT_NOT_FOUND userInfo:@{ NSLocalizedDescriptionKey: reason }]);
            return PBX_PROJECT_NOT_FOUND;
        }
    }
    else {
        setpptr(error, [NSError errorWithDomain:e.domain code:PBX_INVALID_REGEX_PATTERN userInfo:e.userInfo]);
        return PBX_INVALID_REGEX_PATTERN;
    }
}

NSString *indentLines(NSString *str, NSUInteger delta) {
    if(str.length && delta) {
        NSUInteger          mx      = 0;
        NSString            *pad    = [@"|" stringByLeftPaddingToLength:delta];
        NSMutableString     *buffer = [NSMutableString new];
        NSArray<NSString *> *lines  = [str split:@"\\r\\n?|\\n"];

        if(lines.count == 0) lines = @[ str ];

        for(NSString *ln in lines) {
            [buffer appendFormat:@"%@ %@\n", pad, ln];
            mx = MAX(mx, ln.length);
        }

        [buffer appendFormat:@"%@_%@|", pad, [@"_" stringByDupToLength:mx]];
        return buffer;
    }

    return str;
}

NSString *makeUnderline(NSString *str) {
    switch(str.length) {//@f:0
        case 0: return @"";
        case 1: return @"||";
        case 2: return @"|_|";
        case 3: return @"|__|";
        case 4: return @"|___|";
        case 5: return @"|____|";
        case 6: return @"|_____|";
        case 7: return @"|______|";
        case 8: return @"|_______|";
        case 9: return @"|________|";
        default: return PGFormat(@"|%@|", [@"_______________" stringByDupToLength:(str.length - 1)]);
    } //@f:1
}
