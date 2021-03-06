/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXTarget.h
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

#ifndef __PBXBUILDER_PBXTARGET_H__
#define __PBXBUILDER_PBXTARGET_H__

#import <Cocoa/Cocoa.h>
#import <PBX/PBXItem.h>

@class XCConfigurationList;
@class PBXBuildPhase;
@class PBXTargetDependency;

NS_ASSUME_NONNULL_BEGIN

@interface PBXTarget : PBXItem

    @property(nullable, readonly) NSString                       *name;
    @property(nullable, readonly) NSString                       *productName;
    @property(nullable, readonly) XCConfigurationList            *buildConfigurationList;
    @property(readonly)/*      */ NSArray<PBXBuildPhase *>       *buildPhases;
    @property(readonly)/*      */ NSArray<PBXTargetDependency *> *dependencies;
    @property(readonly, copy)/**/ NSString                       *buildDir;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXTARGET_H__
