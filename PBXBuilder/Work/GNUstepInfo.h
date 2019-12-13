/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: GNUstepInfo.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/15/19
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

#ifndef __PBXBUILDER_GNUSTEPINFO_H__
#define __PBXBUILDER_GNUSTEPINFO_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface GNUstepInfo : NSObject

    @property(nullable, readonly, copy) NSString            *gnustepConfig;
    @property(nullable, readonly, copy) NSString            *ccPath;
    @property(nullable, readonly, copy) NSString            *cxxPath;
    @property(nullable, readonly, copy) NSString            *applcationPath;
    @property(nullable, readonly, copy) NSString            *toolsPath;
    @property(nullable, readonly, copy) NSString            *libraryPath;
    @property(nullable, readonly, copy) NSString            *headersPath;
    @property(nullable, readonly, copy) NSString            *libsPath;
    @property(nullable, readonly, copy) NSString            *docPath;
    @property(nullable, readonly, copy) NSString            *manPath;
    @property(nullable, readonly, copy) NSString            *infoPath;
    @property(readonly)/*            */ NSUInteger          cpuCount;
    @property(readonly)/*            */ NSArray<NSString *> *objcOpts;
    @property(readonly)/*            */ NSArray<NSString *> *linkBaseOpts;
    @property(readonly)/*            */ NSArray<NSString *> *linkGuiOpts;

    -(instancetype)init:(NSError **)pError NS_DESIGNATED_INITIALIZER;

    +(instancetype)info:(NSError **)pError;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_GNUSTEPINFO_H__
