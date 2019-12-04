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

#import <Cocoa/Cocoa.h>

FOUNDATION_EXPORT double              PBXVersionNumber;
FOUNDATION_EXPORT const unsigned char PBXVersionString[];

#import <PBX/PBXProject.h>
#import <PBX/PBXAggregateTarget.h>
#import <PBX/PBXNativeTarget.h>
#import <PBX/PBXLegacyTarget.h>
#import <PBX/PBXTarget.h>
#import <PBX/PBXTargetDependency.h>
#import <PBX/PBXContainerItemProxy.h>
#import <PBX/PBXGroup.h>
#import <PBX/PBXVariantGroup.h>
#import <PBX/PBXFileReference.h>
#import <PBX/PBXFileElement.h>
#import <PBX/PBXFileElementTypes.h>
#import <PBX/PBXItem.h>
#import <PBX/PBXCopyFilesBuildPhase.h>
#import <PBX/PBXSourcesBuildPhase.h>
#import <PBX/PBXFrameworksBuildPhase.h>
#import <PBX/PBXAppleScriptBuildPhase.h>
#import <PBX/PBXResourcesBuildPhase.h>
#import <PBX/PBXShellScriptBuildPhase.h>
#import <PBX/PBXHeadersBuildPhase.h>
#import <PBX/PBXBuildPhase.h>
#import <PBX/XCConfigurationList.h>
#import <PBX/XCBuildConfiguration.h>
#import <PBX/PBXBuildFile.h>


