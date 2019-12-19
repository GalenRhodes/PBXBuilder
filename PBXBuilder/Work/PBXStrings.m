/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXStrings.m
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

#import "PBXStrings.h"

NSString *const PGPBXFilename           = @"project.pbxproj";
NSString *const PBXProjectFileExtension = @"xcodeproj";

NSString *const PBXDefaultBuildConfig = @"Release";

NSString *const PBXActionBuild   = @"build";
NSString *const PBXActionClean   = @"clean";
NSString *const PBXActionInstall = @"install";

NSString *const PBXOptionProject     = @"-project";
NSString *const PBXOptionTarget      = @"-target";
NSString *const PBXOptionAllTargets  = @"-alltargets";
NSString *const PBXOptionBuildConfig = @"-configuration";

NSString *const PBXMessageAction           = @"ACTION";
NSString *const PBXMessageBuilding         = @"Building the following project";
NSString *const PBXMessageProject          = @"Project";
NSString *const PBXMessageRemovingBuildDir = @"Removing build directory";
NSString *const PBXMessageCreatingBuildDir = @"Creating build directory";
NSString *const PBXMessageNothingToDo      = @"Nothing to do!";
NSString *const PBXMessageTarget           = @"Target";
NSString *const PBXMessageBuildPhase       = @"Build Phase";
NSString *const PBXMessageConfiguration    = @"Configuration";
NSString *const PBXMessageSuccess          = @"Success!";
