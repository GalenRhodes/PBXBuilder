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

NSString *const PGErrMsgNoProgramPath        = @"ERROR: Program path missing";
NSString *const PGErrMsgUnknownCmdLineOption = @"ERROR: Unrecognized command-line options: \"%@\"";
NSString *const PGErrMsgNoProjectFound       = @"ERROR: No project found in path: \"%@\"";
NSString *const PGErrMsgProjectNotFound      = @"ERROR: Project \"%@\" not found in path \"%@\".";
NSString *const PGErrMsgMissingProjectName   = @"ERROR: Missing project name after \"-project\"";
NSString *const PGErrMsgMultipleProjects     = @"ERROR: Multiple projects found. Use the \"-project\" option to specify which project to use.";
NSString *const PGErrMsgMissingTargetName    = @"ERROR: Missing target name after \"-target\"";
NSString *const PGErrMsgTargetNotFound       = @"ERROR: Target \"%@\" not found in project \"%@\"";
NSString *const PGErrMsgUnknownBuildConfig   = @"ERROR: Unknown build configuration: \"%@\"";
