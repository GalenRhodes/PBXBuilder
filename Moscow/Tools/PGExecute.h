/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGExecute.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 12/9/19
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

#ifndef __PBXBUILDER_PGEXECUTE_H__
#define __PBXBUILDER_PGEXECUTE_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGExecute : NSObject

    @property(copy)/*                */ NSString                             *executablePath;
    @property(copy)/*                */ NSArray<NSString *>                  *arguments;
    @property(copy)/*                */ NSDictionary<NSString *, NSString *> *environment;
    @property(readonly)/*            */ BOOL                                 isRunning;
    @property(readonly)/*            */ NSInteger                            exitCode;
    @property(readonly, nullable)/*  */ NSError                              *lastError;
    @property(nullable, readonly, copy) NSString                             *stdOut;
    @property(nullable, readonly, copy) NSString                             *stdErr;
    @property(nullable, readonly)/*  */ NSTask                               *task;

    -(instancetype)initWithAppPath:(NSString *)executablePath
                         arguments:(NSArray<NSString *> *)arguments
                       environment:(NSDictionary<NSString *, NSString *> *)environment
                   mergeDefaultEnv:(BOOL)mergeEnv
                           execute:(BOOL)execute;

    -(NSInteger)waitUntilExit:(NSError **)error;

    -(instancetype)execute:(NSError **)error;

    -(NSInteger)executeAndWaitUntilExit:(NSError **)error;

    -(void)appendEnvironment:(NSString *)name value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PGEXECUTE_H__
