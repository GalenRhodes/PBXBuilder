/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: XCBuildConfiguration.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/4/19
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

#ifndef __PBXBUILDER_XCBUILDCONFIGURATION_H__
#define __PBXBUILDER_XCBUILDCONFIGURATION_H__

#import <PBX/PBXItem.h>
#import "PBXVars.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const XCBuildConfigNameDebug;
FOUNDATION_EXPORT NSString *const XCBuildConfigNameRelease;
FOUNDATION_EXPORT NSString *const XCBuildConfigNameDefault;

FOUNDATION_EXPORT NSString *const PBX_UI_CURRENT_ACTION;
FOUNDATION_EXPORT NSString *const PBX_UI_BUILD_DIR;

@class XCConfigurationList;

typedef NSString *_Nullable (^PBXExpMacroBlock)(NSString *macro, BOOL *stop);

@interface XCBuildConfiguration : PBXItem

    @property(class, readonly)/*   */ NSArray<NSString *>          *allBuildConfigurationNames;
    @property(readonly, nullable)/**/ NSString                     *name;
    @property(readonly, nullable)/**/ NSString                     *baseConfigurationReference;
    @property(readonly)/*          */ NSDictionary<NSString *, id> *buildSettings;
    @property(readonly)/*          */ XCConfigurationList          *configurationList;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile;

    -(id)expandMacrosIn:(id)obj usingBlock:(PBXExpMacroBlock)block;

    -(id)settingForName:(NSString *)name;

    -(id)getDefaultSettingForName:(NSString *)name;

    -(id)getDefaultSetting:(PBXVariable)varId defaultValue:(nullable id)d2;
@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_XCBUILDCONFIGURATION_H__
