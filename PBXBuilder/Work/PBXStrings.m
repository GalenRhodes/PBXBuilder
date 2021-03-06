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

#import "PBXTools.h"

NSString *const PGProjErrorDomain = @"com.projectgalen.PBXBuilder";

NSString *const PGFoundProjectFilesKey = @"PGFoundProjectFilesKey";

NSString *const PGPBXFilename           = @"project.pbxproj";
NSString *const PBXProjectFileExtension = @"xcodeproj";

NSString *const PBXActionBuild   = @"build";
NSString *const PBXActionClean   = @"clean";
NSString *const PBXActionInstall = @"install";

NSString *const PBXOptionProject     = @"-project";
NSString *const PBXOptionTarget      = @"-target";
NSString *const PBXOptionAllTargets  = @"-alltargets";
NSString *const PBXOptionBuildConfig = @"-configuration";

NSString *const PBXMessageAction         = @"ACTION";
NSString *const PBXMessageBuilding       = @"Building the following project";
NSString *const PBXMessageProject        = @"Project";
NSString *const PBXMessageNothingToDo    = @"Nothing to do!";
NSString *const PBXMessageTarget         = @"Target";
NSString *const PBXMessageBuildPhase     = @"Build Phase";
NSString *const PBXMessageConfiguration  = @"Build Configuration";
NSString *const PBXMessageSuccess        = @"SUCCESS";
NSString *const PBXMessageBuildDirectory = @"build directory";
NSString *const PBXMessageWorking        = @"working...\e[10D";
NSString *const PBXMessageRemoving       = @"REMOVING";
NSString *const PBXMessageCreating       = @"CREATING";

NSString *const PBXFormat3     = @"\e[0m\e[97;40m    ] [\e[38;5;6m%@\e[97m] \e[38;5;223m%@\e[97m;\e[%luC[\e[38;5;6m%@\e[97m] \e[38;5;223m%@\e[97m\n";
NSString *const PBXFormat4     = @"\n\e[0m\e[97;40m%@: %@";
NSString *const PBXFormat5     = @"\n\e[0m\e[97;40m%@:";
NSString *const PBXFormat6     = @"\n\n\e[0m\e[97;40m%@: %@...\n";
NSString *const PBXFormat7     = @"\e[0m\e[97;40m    ] [\e[38;5;6m%@\e[97m] %@\e[97m - \e[38;5;32m%@\e[97m";
NSString *const PBXFormat8     = @"\e[38;5;46m%@\e[97m\e[0J\n";
NSString *const PBXFormat10    = @"%@ \e[38;5;180m%@";
NSString *const PBXFormat11    = @"\e[38;5;32m%@";
NSString *const PBXFormatError = @"\n\n\e[38;5;226m\e[48;5;196mERROR:\e[40;97m (\e[38;5;51m%@\e[97m) - \e[38;5;226m%@\e[97m\n";

NSString *const PBXMessageDoubleLF = @"\n\n";
NSString *const PBXMessageSingleLF = @"\n";

NSString *const PBXPrintErrorProjectList = @"\e[0m\e[38;2;0;0;255m\e[40m%2lu\e[97m> \e[36m%@ \e[33m==> \e[97m\"\e[32m%@\e[97m\"\e[0m\n";


