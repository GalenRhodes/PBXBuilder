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

NSInteger printError2(NSError *error) PG_OVERLOADED {
    return printError2(0, error);
}

NSInteger printError2(NSInteger returnCode, NSError *error) PG_OVERLOADED {
    PGPrintStr(@"\e[91mFAILURE\e[0m\e[0K");
    return printError(returnCode, error);
}

NSInteger printError(NSInteger returnCode, NSError *error) PG_OVERLOADED {
    PGPrintf(PBXFormatError, @(error.code), error.localizedDescription);
    return (returnCode ?: error.code);
}

NSInteger printError(NSError *error) PG_OVERLOADED {
    return printError(0, error);
}

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

BOOL pbxMakeErr(NSError **pError, NSInteger code, NSString *fmt, ...) {
    if(pError) {
        va_list ap;
        va_start(ap, fmt);
        NSString *reason = [[NSString alloc] initWithFormat:fmt arguments:ap];
        NSError  *error  = pbxMakeError(code, reason, nil);
        *pError = error;
        va_end(ap);
    }
    return NO;
};

void handleFilename(NSMutableDictionary<NSString *, NSString *> *results, NSString *fullFilename) {
    NSString *a = fullFilename.stringByDeletingLastPathComponent.lastPathComponent;
    if([a.pathExtension isEqualToString:PBXProjectFileExtension]) results[a.stringByDeletingPathExtension] = fullFilename;
}

void handleSymbolicLink(NSString *symlink, NSMutableDictionary<NSString *, NSString *> *results, NSFileManager *fm) {
    NSError  *error    = nil;
    NSString *filename = [fm destinationOfSymbolicLinkAtPath:symlink error:&error];

    if(filename) {
        NSDictionary *subAttrs = [fm attributesOfItemAtPath:filename error:&error];

        if([subAttrs.fileType isEqualToString:NSFileTypeDirectory]) {
            NSDictionary<NSString *, NSString *> *subResults = locateProjectFiles(filename, fm);
            if(subResults.count) [results addEntriesFromDictionary:subResults];
        }
    }
}

NSDictionary<NSString *, NSString *> *locateProjectFiles(NSString *dir, NSFileManager *fm) {
    NSMutableDictionary<NSString *, NSString *> *results  = [NSMutableDictionary new];
    NSDirectoryEnumerator                       *dirEnum  = [fm enumeratorAtPath:dir];
    NSString                                    *filename = dirEnum.nextObject;

    while(filename) {
        NSString     *fullFilename = [dir stringByAppendingPathComponent:filename];
        NSDictionary *attrs        = dirEnum.fileAttributes;

        if([fullFilename.lastPathComponent isEqualToString:PGPBXFilename]) {
            handleFilename(results, fullFilename);
        }
        else if([attrs.fileType isEqualToString:NSFileTypeSymbolicLink]) {
            handleSymbolicLink(fullFilename, results, fm);
        }

        filename = dirEnum.nextObject;
    }

    return results;
}

void printSuccess(void) {
    printStatus(@"SUCCESS", ANSI_GR_FG_GREEN, PBX_PS_LF);
}

void printStatus(NSString *status, ANSIGraphicsRendition color) PG_OVERLOADED {
    printStatus(status, color, PBX_PS_EOL);
}

void printStatus(NSString *status, ANSIGraphicsRendition color, NSUInteger options) PG_OVERLOADED {
    BOOL     savePos = ((options & (PBX_PS_EOL | PBX_PS_LF)) == 0);
    BOOL     newLine = ((options & PBX_PS_LF) == PBX_PS_LF);
    NSString *out    = PGFormat(@"\e[0J\e[0;1;97m [\e[22;%@m%@\e[1;97m]\e[0m", @(color), status);

    if(savePos) PGPrintf(@"\e[s%@\e[u", out); else if(newLine) PGPrintf(@"%@\n", out); else PGPrintStr(out);
}
