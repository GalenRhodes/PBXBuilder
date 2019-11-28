/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBX.h
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

#ifndef ____PBXBUILDER_PBX_H____
#define ____PBXBUILDER_PBX_H____

#import <Cocoa/Cocoa.h>

#import "PBXProject.h"
#import "PBXAggregateTarget.h"
#import "PBXNativeTarget.h"
#import "PBXLegacyTarget.h"
#import "PBXTarget.h"
#import "PBXTargetDependency.h"
#import "PBXContainerItemProxy.h"
#import "PBXGroup.h"
#import "PBXVariantGroup.h"
#import "PBXFileReference.h"
#import "PBXFileElement.h"
#import "PBXFileElementTypes.h"
#import "PBXItem.h"
#import "PBXCopyFilesBuildPhase.h"
#import "PBXSourcesBuildPhase.h"
#import "PBXFrameworksBuildPhase.h"
#import "PBXAppleScriptBuildPhase.h"
#import "PBXResourcesBuildPhase.h"
#import "PBXShellScriptBuildPhase.h"
#import "PBXHeadersBuildPhase.h"
#import "PBXBuildPhase.h"
#import "XCConfigurationList.h"
#import "XCBuildConfiguration.h"
#import "PBXBuildFile.h"

#endif // ____PBXBUILDER_PBX_H____
