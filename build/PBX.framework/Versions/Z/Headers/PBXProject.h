/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXProject.h
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

#ifndef __PBXBUILDER_PBXPROJECT_H__
#define __PBXBUILDER_PBXPROJECT_H__

#import <Cocoa/Cocoa.h>
#import <PBX/PBXItem.h>

@class XCConfigurationList;
@class PBXTarget;
@class PBXGroup;

NS_ASSUME_NONNULL_BEGIN

@interface PBXProject : PBXItem

    @property(readonly, nullable) NSString                     *compatibilityVersion;  // "Xcode 9.3"
    @property(readonly, nullable) NSString                     *developmentRegion;     // en
    @property(readonly)/*      */ BOOL                         hasScannedForEncodings; // 0
    @property(readonly)/*      */ NSArray<NSString *>          *knownRegions;          // (en, Base,)
    @property(readonly, nullable) NSString                     *projectDirPath;        // ""
    @property(readonly, nullable) NSString                     *projectRoot;           // ""
    @property(readonly, nullable) XCConfigurationList          *buildConfigurationList;
    @property(readonly)/*      */ NSArray<PBXTarget *>         *targets;
    @property(readonly)/*      */ NSDictionary<NSString *, id> *attributes;
    @property(readonly, nullable) PBXGroup                     *productRefGroup;
    @property(readonly, nullable) PBXGroup                     *mainGroup;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile;

    -(PBXTarget *)targetWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXPROJECT_H__
