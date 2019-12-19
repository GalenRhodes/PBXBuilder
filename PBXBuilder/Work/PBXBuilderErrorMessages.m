/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXBuilderErrorMessages.m
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

#import "PBXBuilderErrorMessages.h"

NSString *const PGErrMsgNoProgramPath        = @"Program path missing";
NSString *const PGErrMsgUnknownCmdLineOption = @"Unrecognized command-line options: \"%@\"";
NSString *const PGErrMsgNoProjectFound       = @"No project found in path: \"%@\"";
NSString *const PGErrMsgProjectNotFound      = @"Project \"%@\" not found in path \"%@\".";
NSString *const PGErrMsgMissingProjectName   = @"Missing project name after \"-project\"";
NSString *const PGErrMsgMultipleProjects     = @"Multiple projects found. Use the \"-project\" option to specify which project to use.";
NSString *const PGErrMsgMissingTargetName    = @"Missing target name after \"-target\"";
NSString *const PGErrMsgTargetNotFound       = @"Target \"%@\" not found in project \"%@\"";
NSString *const PGErrMsgUnknownBuildConfig   = @"Unknown build configuration: \"%@\"";
NSString *const PGErrMsgMissingBuildConfig   = @"Missing build configuration after \"-configuration\"";
NSString *const PBXErrMsgDirIsFile           = @"The file exists but is not a directory: %@";
