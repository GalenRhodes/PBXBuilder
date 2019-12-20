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
#import "PBXBuilderTypes.h"
#import "PBXStrings.h"
#import "PBXBuilderErrorMessages.h"
#import "GNUstepInfo.h"
#import "PBXRunInfo.h"
#import "PBXNativeTarget+PBXBuilder.h"
#import "PBXTarget+PBXBuilder.h"
#import "PBXBuildPhase+PBXBuilder.h"
#import "PBXHeadersBuildPhase+PBXBuilder.h"
#import "PBXCopyFilesBuildPhase+PBXBuilder.h"
#import "PBXFrameworksBuildPhase+PBXBuilder.h"
#import "PBXResourcesBuildPhase+PBXBuilder.h"
#import "PBXSourcesBuildPhase+PBXBuilder.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, PBXPrintStatusOptions) {
    PBX_PS_EOL = (1 << 0), // Stay at end-of-line
    PBX_PS_LF  = (1 << 1), // Move to next line (implies PBX_PS_EOL)
};

FOUNDATION_EXPORT PBXErrorCodes parseFindProjectResults(NSString *dir,
                                                        NSArray<NSString *> *array,
                                                        NSString *_Nullable *_Nullable pProjectName,
                                                        NSString *_Nullable *_Nullable pProjectFilename,
                                                        NSError **error);

FOUNDATION_EXPORT void printfc(NSUInteger maxLength, NSString *format, ...)  NS_FORMAT_FUNCTION(2, 3);

FOUNDATION_EXPORT NSError *pbxMakeError(NSInteger code, NSString *reason, NSDictionary *_Nullable userInfo);

FOUNDATION_EXPORT BOOL pbxMakeErr(NSError **pError, NSInteger code, NSString *fmt, ...) NS_FORMAT_FUNCTION(3, 4);

FOUNDATION_EXPORT NSString *indentLines(NSString *str, NSUInteger delta);

FOUNDATION_EXPORT NSString *makeUnderline(NSString *str);

FOUNDATION_EXPORT NSDictionary<NSString *, NSString *> *locateProjectFiles(NSString *dir, NSFileManager *fm);

FOUNDATION_EXPORT NSInteger printError(NSInteger returnCode, NSError *error) PG_OVERLOADED;

FOUNDATION_EXPORT NSInteger printError(NSError *error) PG_OVERLOADED;

FOUNDATION_EXPORT NSInteger printError2(NSInteger returnCode, NSError *error) PG_OVERLOADED;

FOUNDATION_EXPORT NSInteger printError2(NSError *error) PG_OVERLOADED;

FOUNDATION_EXPORT void printStatus(NSString *status, ANSIGraphicsRendition color, NSUInteger options) PG_OVERLOADED;

FOUNDATION_EXPORT void printStatus(NSString *status, ANSIGraphicsRendition color) PG_OVERLOADED;

FOUNDATION_EXPORT void printSuccess(void);

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PGXTOOLS_H__
