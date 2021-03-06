/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXBuilderTypes.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 12/18/19
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

#ifndef __PBXBUILDER_PBXBUILDERTYPES_H__
#define __PBXBUILDER_PBXBUILDERTYPES_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PBXErrorCodes) {
    PBX_NO_ERROR              = 0,
    PBX_COCOA_ERROR           = 1,
    PBX_FILE_IS_DIR,
    PBX_DIR_IS_FILE,
    PBX_INVALID_REGEX_PATTERN = 100,
    PBX_UNKNOWN_CMDLINE_OPTION,
    PBX_PROJECT_NOT_FOUND,
    PBX_MULTIPLE_PROJECTS_FOUND,
    PBX_MISSING_PROJECT_NAME,
    PBX_INVALID_PROJECT_FILE,
    PBX_TARGET_NOT_FOUND,
    PBX_MISSING_TARGET_NAME,
    PBX_UNKNOWN_BUILD_CONFIG,
    PBX_MISSING_BUILD_CONFIG
};

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXBUILDERTYPES_H__
