/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXStrings.h
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

#ifndef __PBXBUILDER_PBXSTRINGS_H__
#define __PBXBUILDER_PBXSTRINGS_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const PGProjErrorDomain;

FOUNDATION_EXPORT NSString *const PGFoundProjectFilesKey;

FOUNDATION_EXPORT NSString *const PGPBXFilename;
FOUNDATION_EXPORT NSString *const PBXProjectFileExtension;

FOUNDATION_EXPORT NSString *const PBXActionBuild;
FOUNDATION_EXPORT NSString *const PBXActionClean;
FOUNDATION_EXPORT NSString *const PBXActionInstall;

FOUNDATION_EXPORT NSString *const PBXOptionProject;
FOUNDATION_EXPORT NSString *const PBXOptionTarget;
FOUNDATION_EXPORT NSString *const PBXOptionAllTargets;
FOUNDATION_EXPORT NSString *const PBXOptionBuildConfig;

FOUNDATION_EXPORT NSString *const PBXMessageAction;
FOUNDATION_EXPORT NSString *const PBXMessageBuilding;
FOUNDATION_EXPORT NSString *const PBXMessageProject;
FOUNDATION_EXPORT NSString *const PBXMessageNothingToDo;
FOUNDATION_EXPORT NSString *const PBXMessageTarget;
FOUNDATION_EXPORT NSString *const PBXMessageBuildPhase;
FOUNDATION_EXPORT NSString *const PBXMessageConfiguration;
FOUNDATION_EXPORT NSString *const PBXMessageSuccess;
FOUNDATION_EXPORT NSString *const PBXMessageBuildDirectory;
FOUNDATION_EXPORT NSString *const PBXMessageWorking;
FOUNDATION_EXPORT NSString *const PBXMessageRemoving;
FOUNDATION_EXPORT NSString *const PBXMessageCreating;

FOUNDATION_EXPORT NSString *const PBXFormat3;
FOUNDATION_EXPORT NSString *const PBXFormat4;
FOUNDATION_EXPORT NSString *const PBXFormat5;
FOUNDATION_EXPORT NSString *const PBXFormat6;
FOUNDATION_EXPORT NSString *const PBXFormat7;
FOUNDATION_EXPORT NSString *const PBXFormat8;
FOUNDATION_EXPORT NSString *const PBXFormat10;
FOUNDATION_EXPORT NSString *const PBXFormat11;
FOUNDATION_EXPORT NSString *const PBXFormatError;

FOUNDATION_EXPORT NSString *const PBXMessageDoubleLF;
FOUNDATION_EXPORT NSString *const PBXMessageSingleLF;

FOUNDATION_EXPORT NSString *const PBXPrintErrorProjectList;

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXSTRINGS_H__
