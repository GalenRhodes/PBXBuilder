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

FOUNDATION_EXPORT NSString *const PGErrMsgAlreadyExecuted;
FOUNDATION_EXPORT NSString *const PGErrMsgNotYetExecuted;
FOUNDATION_EXPORT NSString *const PGErrMsgStillExecuting;
FOUNDATION_EXPORT NSString *const PGErrMsgEmptyEnvVar;
FOUNDATION_EXPORT NSString *const PGErrMsgNoExecPath;

FOUNDATION_EXPORT NSString *const PGStderrOutputKey;

@interface PGExecute : NSObject

    @property(readonly, copy)/*      */ NSString                             *executablePath;
    @property(copy)/*                */ NSArray<NSString *>                  *arguments;
    @property(copy)/*                */ NSDictionary<NSString *, NSString *> *environment;
    @property(readonly)/*            */ BOOL                                 isRunning;
    @property(readonly)/*            */ BOOL                                 wasLaunched;
    @property(readonly)/*            */ NSInteger                            exitCode;
    @property(nullable, readonly, copy) NSString                             *stdOut;
    @property(nullable, readonly, copy) NSString                             *stdErr;
    @property(nullable, readonly)/*  */ NSTask                               *task;
    @property(nullable, readonly)/*  */ NSError                              *lastError;

    -(instancetype)initWithAppPath:(NSString *)executablePath
                         arguments:(nullable NSArray<NSString *> *)arguments
                       environment:(nullable NSDictionary<NSString *, NSString *> *)environment
                   mergeDefaultEnv:(BOOL)mergeEnv
                           execute:(BOOL)execute
                             error:(NSError **)error;

    +(instancetype)exeWithAppPath:(NSString *)executablePath
                        arguments:(nullable NSArray<NSString *> *)arguments
                      environment:(nullable NSDictionary<NSString *, NSString *> *)environment
                  mergeDefaultEnv:(BOOL)mergeEnv
                          execute:(BOOL)execute
                            error:(NSError **)error;

    +(instancetype)exeWithAppPath:(NSString *)executablePath
                        arguments:(nullable NSArray<NSString *> *)arguments
                      environment:(nullable NSDictionary<NSString *, NSString *> *)environment
                          execute:(BOOL)execute
                            error:(NSError **)error;

    +(instancetype)exeWithAppPath:(NSString *)executablePath
                        arguments:(nullable NSArray<NSString *> *)arguments
                      environment:(nullable NSDictionary<NSString *, NSString *> *)environment
                            error:(NSError **)error;

    +(instancetype)exeWithAppPath:(NSString *)executablePath arguments:(nullable NSArray<NSString *> *)arguments execute:(BOOL)execute error:(NSError **)error;

    +(instancetype)exeWithAppPath:(NSString *)executablePath arguments:(nullable NSArray<NSString *> *)arguments error:(NSError **)error;

    -(instancetype)execute:(NSError **)error;

    -(NSInteger)waitUntilExit:(NSError **)error;

    -(NSInteger)executeAndWaitUntilExit:(NSError **)error;

    -(void)appendArgument:(NSString *)argument;

    -(void)appendEnvironment:(NSString *)name value:(nullable NSString *)value;

    -(void)appendEnvironment:(NSDictionary<NSString *, NSString *> *)environment;

    -(void)removeEnvironment:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PGEXECUTE_H__
