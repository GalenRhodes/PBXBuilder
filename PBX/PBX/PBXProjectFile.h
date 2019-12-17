/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXProjectFile.h
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

#ifndef __PBXBUILDER_PGPROJECTFILE_H__
#define __PBXBUILDER_PGPROJECTFILE_H__

#import <Cocoa/Cocoa.h>

@class PBXItem;
@class PBXProject;

NS_ASSUME_NONNULL_BEGIN

@interface PBXProjectFile : NSObject

    @property(copy, readonly) NSString                            *projectName;
    @property(copy, readonly) NSString                            *projectPath;
    @property(readonly)/*  */ NSDictionary<NSString *, id>        *projectPBX;
    @property(readonly)/*  */ NSDictionary<NSString *, PBXItem *> *pbxItemCache;
    @property(readonly)/*  */ NSPropertyListFormat                pbxFormat;
    @property(readonly)/*  */ PBXProject                          *project;

    -(instancetype)initWithName:(NSString *)name path:(NSString *)path error:(NSError **)error;

    +(instancetype)projectFileWithName:(NSString *)projectName path:(NSString *)projectPath error:(NSError **)error;

    +(NSDictionary<NSString *, id> *)getPropertyListAtPath:(NSString *)pbxPath format:(NSPropertyListFormat *)format error:(NSError **)error;

    -(nullable id)itemForID:(NSString *)itemId;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PGPROJECTFILE_H__
