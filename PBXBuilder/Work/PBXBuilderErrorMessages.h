/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXBuilderErrorMessages.h
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

#ifndef __PBXBUILDER_PBXBUILDERERRORMESSAGES_H__
#define __PBXBUILDER_PBXBUILDERERRORMESSAGES_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const PGErrMsgNoProgramPath;
FOUNDATION_EXPORT NSString *const PGErrMsgUnknownCmdLineOption;
FOUNDATION_EXPORT NSString *const PGErrMsgNoProjectFound;
FOUNDATION_EXPORT NSString *const PGErrMsgProjectNotFound;
FOUNDATION_EXPORT NSString *const PGErrMsgMissingProjectName;
FOUNDATION_EXPORT NSString *const PGErrMsgMultipleProjects;
FOUNDATION_EXPORT NSString *const PGErrMsgMissingTargetName;
FOUNDATION_EXPORT NSString *const PGErrMsgTargetNotFound;
FOUNDATION_EXPORT NSString *const PGErrMsgUnknownBuildConfig;
FOUNDATION_EXPORT NSString *const PGErrMsgMissingBuildConfig;
FOUNDATION_EXPORT NSString *const PBXErrMsgDirIsFile;

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXBUILDERERRORMESSAGES_H__
