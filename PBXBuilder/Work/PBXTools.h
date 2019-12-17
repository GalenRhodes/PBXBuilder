/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGXTools.h
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

#ifndef __PBXBUILDER_PGXTOOLS_H__
#define __PBXBUILDER_PGXTOOLS_H__

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, PBXErrorCodes) {
    PBX_NO_ERROR = 0,
    PBX_INVALID_REGEX_PATTERN,
    PBX_UNKNOWN_CMDLINE_OPTION,
    PBX_PROJECT_NOT_FOUND,
    PBX_MULTIPLE_PROJECTS_FOUND,
    PBX_MISSING_PROJECT_NAME,
    PBX_INVALID_PROJECT_FILE,
    PBX_TARGET_NOT_FOUND,
    PBX_MISSING_TARGET_NAME,
    PBX_UNKNOWN_BUILD_CONFIG
};

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const PGProjErrorDomain;
FOUNDATION_EXPORT NSString *const PGFoundProjectFilesKey;

FOUNDATION_EXPORT PBXErrorCodes parseFindProjectResults(NSString *dir,
                                                        NSArray<NSString *> *array,
                                                        NSString *_Nullable *_Nullable pProjectName,
                                                        NSString *_Nullable *_Nullable pProjectFilename,
                                                        NSError **error);

FOUNDATION_EXPORT void printfc(NSUInteger maxLength, NSString *format, ...)  NS_FORMAT_FUNCTION(2, 3);

FOUNDATION_EXPORT NSError *pbxMakeError(NSInteger code, NSString *reason, NSDictionary *_Nullable userInfo);

FOUNDATION_EXPORT NSString *indentLines(NSString *str, NSUInteger delta);

FOUNDATION_EXPORT NSString *makeUnderline(NSString *str);

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PGXTOOLS_H__
