/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGExecute.m
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

#import "PGExecute.h"
#import "Tools.h"
#import "NSString+Moscow.h"

NSString *const PGErrMsgAlreadyExecuted = @"Already executed";
NSString *const PGErrMsgNotYetExecuted  = @"Not yet executed";
NSString *const PGErrMsgStillExecuting  = @"Still executing";
NSString *const PGErrMsgNoExecPath      = @"No executable path";
NSString *const PGErrMsgEmptyEnvVar     = @"Environment variable name is NULL or empty.";

NSString *const PGStderrOutputKey = @"PGStderrOutputKey";

NSString *const PGErrMsgArgumentNull = @"Argument is NULL";
typedef NSDictionary<NSString *, NSString *> *StringMap;

@interface PGExecute()

    @property(readonly)/*  */ NSRecursiveLock *lock;
    @property(nullable, copy) NSString        *stdOut;
    @property(nullable, copy) NSString        *stdErr;
    @property(nullable)/*  */ NSError         *lastError;
    @property(nullable)/*  */ NSTask          *task;
    @property/*            */ BOOL            wasLaunched;
    @property/*            */ NSInteger       exitCode;

@end

@implementation PGExecute {
        dispatch_queue_t                     _pipeQueue;
        NSInteger                            _exitCode;
        NSDictionary<NSString *, NSString *> *_environment;
        NSArray<NSString *>                  *_arguments;
    }

    -(instancetype)initWithAppPath:(NSString *)executablePath
                         arguments:(NSArray<NSString *> *)arguments
                       environment:(NSDictionary<NSString *, NSString *> *)environment
                   mergeDefaultEnv:(BOOL)mergeEnv
                           execute:(BOOL)execute
                             error:(NSError **)error {
        self = [super init];

        if(self) {
            if(executablePath.length) {
                _lock           = [NSRecursiveLock new];
                _executablePath = executablePath.copy;
                _arguments      = (arguments.copy ? arguments.copy : [NSArray new]);
                _exitCode       = -1;

                if(environment.count) {
                    if(mergeEnv) {
                        NSMutableDictionary<NSString *, NSString *> *env = NSProcessInfo.processInfo.environment.mutableCopy;
                        [env addEntriesFromDictionary:environment];
                        _environment = env;
                    }
                    else {
                        _environment = environment.copy;
                    }
                }
                else {
                    _environment = NSProcessInfo.processInfo.environment.copy;
                }

                if(execute) return [self execute:error];
            }
            else {
                setpptr(error, PGMakeError(1001001, PGErrMsgNoExecPath, nil));
                return nil;
            }
        }

        return self;
    }

    +(instancetype)exeWithAppPath:(NSString *)executablePath
                        arguments:(NSArray<NSString *> *)arguments
                      environment:(NSDictionary<NSString *, NSString *> *)environment
                  mergeDefaultEnv:(BOOL)mergeEnv
                          execute:(BOOL)execute
                            error:(NSError **)error {
        return [[self alloc] initWithAppPath:executablePath arguments:arguments environment:environment mergeDefaultEnv:mergeEnv execute:execute error:error];
    }

    +(instancetype)exeWithAppPath:(NSString *)executablePath arguments:(NSArray<NSString *> *)arguments execute:(BOOL)execute error:(NSError **)error {
        return [[self alloc] initWithAppPath:executablePath arguments:arguments environment:nil mergeDefaultEnv:YES execute:execute error:error];
    }

    +(instancetype)exeWithAppPath:(NSString *)executablePath arguments:(NSArray<NSString *> *)arguments error:(NSError **)error {
        return [[self alloc] initWithAppPath:executablePath arguments:arguments environment:nil mergeDefaultEnv:YES execute:NO error:error];
    }

    +(instancetype)exeWithAppPath:(NSString *)executablePath
                        arguments:(nullable NSArray<NSString *> *)arguments
                      environment:(nullable NSDictionary<NSString *, NSString *> *)environment
                          execute:(BOOL)execute
                            error:(NSError **)error {
        return [[self alloc] initWithAppPath:executablePath arguments:arguments environment:environment mergeDefaultEnv:YES execute:execute error:error];
    }

    +(instancetype)exeWithAppPath:(NSString *)executablePath
                        arguments:(nullable NSArray<NSString *> *)arguments
                      environment:(nullable NSDictionary<NSString *, NSString *> *)environment
                            error:(NSError **)error {
        return [[self alloc] initWithAppPath:executablePath arguments:arguments environment:environment mergeDefaultEnv:YES execute:NO error:error];
    }

    -(void)handleTaskTerminatedEvent:(NSNotification *)notification {
        id o = notification.object;
        if(o && [o isKindOfClass:NSTask.class]) {
            NSTask    *task = o;
            NSInteger ec    = self.exitCode = task.terminationStatus;

            if(ec && (self.lastError == nil)) {
                NSString            *stdErr   = self.stdErr;
                NSArray<NSString *> *strarray = [stdErr split:@"[ \\t]*(\\r\\n?|\\n)[ \\t]*"];
                NSString            *reason   = ((strarray.count > 1) ? strarray[0] : stdErr);
                self.lastError = PGMakeError(ec, reason, @{ PGStderrOutputKey: stdErr });
            }

            [NSNotificationCenter.defaultCenter removeObserver:self name:NSTaskDidTerminateNotification object:o];
        }
    }

    -(instancetype)execute:(NSError **)error {
        if(self.wasLaunched) {
            setpptr(error, (self.lastError = PGMakeError(1001001, PGErrMsgAlreadyExecuted, nil)));
            return nil;
        }

        setpptr(error, (self.lastError = nil));
        [self.lock lock];

        @try {
            self.task                = [[NSTask alloc] init];
            self.task.arguments      = self.arguments;
            self.task.environment    = self.environment;
            self.task.standardOutput = [NSPipe pipe];
            self.task.standardError  = [NSPipe pipe];
#ifdef __APPLE__
            self.task.executableURL = [NSURL fileURLWithPath:self.executablePath];
#endif
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleTaskTerminatedEvent:) name:NSTaskDidTerminateNotification object:self.task];
#ifdef __APPLE__
            NSError *er = nil;

            if(![self.task launchAndReturnError:&er]) {
                setpptr(error, (self.lastError = er));
                self.exitCode = -1;
                return nil;
            }
#else
            self.task.launchPath = self.executablePath;
            [self.task launch];
#endif
            [self setupPipeReaders];
            self.wasLaunched = YES;
        }
        @catch(NSException *exception) {
            setpptr(error, (self.lastError = PGErrorFromException(1001001, exception)));
            self.exitCode = -1;
            return nil;
        }
        @finally {
            [self.lock unlock];
        }

        return self;
    }

    -(void)setupPipeReaders {
        _pipeQueue = dispatch_queue_create("PGExecute_pipeQueue", DISPATCH_QUEUE_CONCURRENT);

        dispatch_async(_pipeQueue, ^{
            NSError *err = nil;
            self.stdOut            = PGStringFromPipe((NSPipe *)self.task.standardOutput, &err);
            if(err) self.lastError = err;
        });

        dispatch_async(_pipeQueue, ^{
            NSError *err = nil;
            self.stdErr            = PGStringFromPipe((NSPipe *)self.task.standardError, &err);
            if(err) self.lastError = err;
        });
    }

    -(NSInteger)waitUntilExit:(NSError **)error {
        @try {
            [self.lock lock];

            @try {
                if(!self.wasLaunched) {
                    setpptr(error, (self.lastError = PGMakeError(1001001, PGErrMsgNotYetExecuted, nil)));
                    return -1;
                }
            }
            @finally { [self.lock unlock]; }

            [self.task waitUntilExit];
        }
        @catch(NSException *exception) {
            setpptr(error, (self.lastError = PGErrorFromException(1001001, exception)));
        }

        return self.exitCode;
    }

    -(NSInteger)executeAndWaitUntilExit:(NSError **)error {
        if(![self execute:error]) return -1;
        return [self waitUntilExit:error];
    }

    -(void)appendArgument:(NSString *)argument {
        [self.lock lock];

        @try {
            if(self.wasLaunched) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgAlreadyExecuted userInfo:nil];
            if(argument == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgArgumentNull userInfo:nil];

            NSMutableArray<NSString *> *args = PGMutableArrayCopy(self.arguments);
            [args addObject:argument];
            _arguments = args;
        }
        @finally {
            [self.lock unlock];
        }
    }

    -(NSArray<NSString *> *)arguments {
        return mandalorian(self.lock, NSArray<NSString *> *, _arguments);
    }

    -(void)setArguments:(NSArray<NSString *> *)arguments {
        [self.lock lock];
        @try {
            if(self.wasLaunched) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgAlreadyExecuted userInfo:nil];
            _arguments = (arguments ? arguments.copy : [NSArray new]);
        }
        @finally { [self.lock unlock]; }
    }

    -(NSDictionary<NSString *, NSString *> *)environment {
        return mandalorian(self.lock, StringMap, _environment);
    }

    -(void)setEnvironment:(NSDictionary<NSString *, NSString *> *)environment {
        [self.lock lock];
        @try {
            if(self.wasLaunched) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgAlreadyExecuted userInfo:nil];
            _environment = (environment ? environment.copy : [NSDictionary new]);
        }
        @finally { [self.lock unlock]; }
    }

    -(void)appendEnvironment:(NSString *)name value:(NSString *)value {
        if(value) [self appendEnvironment:@{ (name ?: @""): value }]; else [self removeEnvironment:name];
    }

    -(void)appendEnvironment:(NSDictionary<NSString *, NSString *> *)environment {
        [self.lock lock];
        @try {
            if(self.wasLaunched) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgAlreadyExecuted userInfo:nil];

            if(environment.count) {
                for(NSString *key in environment.allKeys) {
                    if(key.length == 0) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgEmptyEnvVar userInfo:nil];
                }

                NSMutableDictionary<NSString *, NSString *> *env = PGMutableDictCopy(self.environment);
                [env addEntriesFromDictionary:environment];
                _environment = env;
            }
        }
        @finally { [self.lock unlock]; }
    }

    -(void)removeEnvironment:(NSString *)name {
        [self.lock lock];
        @try {
            if(self.wasLaunched) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgAlreadyExecuted userInfo:nil];
            if(name.length == 0) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgEmptyEnvVar userInfo:nil];
            NSMutableDictionary *env = PGMutableDictCopy(self.environment);
            [env removeObjectForKey:name];
            _environment = env;
        }
        @finally { [self.lock unlock]; }
    }

    -(BOOL)isRunning {
        return mandalorian(self.lock, BOOL, (self.wasLaunched && self.task.isRunning));
    }

    -(NSInteger)exitCode {
        BOOL launched = NO;
        BOOL done     = NO;

        [self.lock lock];
        @try {
            launched = self.wasLaunched;
            done     = !self.task.isRunning;
        }
        @finally { [self.lock unlock]; }

        if(!launched) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgNotYetExecuted userInfo:nil];
        if(!done) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:PGErrMsgStillExecuting userInfo:nil];

        return _exitCode;
    }

    -(void)setExitCode:(NSInteger)exitCode {
        [self.lock lock];
        @try { _exitCode = exitCode; } @finally { [self.lock unlock]; }
    }

@end
