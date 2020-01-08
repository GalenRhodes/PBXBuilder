/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXPrivate.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 1/6/20
 *
 * Copyright © 2020 Project Galen. All rights reserved.
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

#ifndef ____PBX_PBXPRIVATE_H____
#define ____PBX_PBXPRIVATE_H____

#import <PBX/PBX.h>

@class XCConfigurationList;
@class XCBuildConfiguration;
@class PBXNativeTarget;

@interface XCBuildConfiguration()

    @property XCConfigurationList *configurationList;

@end

@interface XCConfigurationList()

    @property PBXNativeTarget *target;

@end

#endif // ____PBX_PBXPRIVATE_H____
