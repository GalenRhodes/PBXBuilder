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

@interface PGExecute()

    @property(nullable) NSError *lastError;

@end

@implementation PGExecute {
        BOOL                                 _didLaunch;
        NSArray<NSString *>                  *_arguments;
        NSDictionary<NSString *, NSString *> *_environment;
        dispatch_queue_t                     _pipeQueue;
        dispatch_once_t                      _pipeOnce;
    }

    -(instancetype)initWithAppPath:(NSString *)executablePath
                         arguments:(NSArray<NSString *> *)arguments
                       environment:(NSDictionary<NSString *, NSString *> *)environment
                   mergeDefaultEnv:(BOOL)mergeEnv
                           execute:(BOOL)execute {
        self = [super init];

        if(self) {
            if(executablePath.length) {
                _executablePath = executablePath.copy;
                _arguments      = (arguments ? arguments.copy : [NSArray new]);

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

                if(execute) return [self execute:NULL];
            }
            else {
                @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"No executable" userInfo:nil];
            }
        }

        return self;
    }

    -(instancetype)execute:(NSError **)error {
        @synchronized(_executablePath) {
            if(_didLaunch) {
                setpptr(error, self.lastError = PGMakeError(1001001, @"Already executed", nil));
                return nil;
            }
            else {
                setpptr(error, self.lastError = nil);

                @try {
                    _task = [[NSTask alloc] init];
                    _task.arguments      = self.arguments;
                    _task.environment    = self.environment;
                    _task.standardOutput = [NSPipe pipe];
                    _task.standardError  = [NSPipe pipe];
#ifdef __APPLE__
                    NSError *er = nil;
                    _task.executableURL = [NSURL fileURLWithPath:self.executablePath];

                    if(![_task launchAndReturnError:&er]) {
                        setpptr(error, self.lastError = er);
                        return nil;
                    }
#else
                    _task.launchPath = self.executablePath;
                    [_task launch];
#endif
                }
                @catch(NSException *exception) {
                    setpptr(error, self.lastError = PGErrorFromException(1001001, exception));
                    return nil;
                }

                [self setupPipeReaders];
                return self;
            }
        }
    }

    -(void)setupPipeReaders {
        dispatch_once(&_pipeOnce, ^{ _pipeQueue = dispatch_queue_create("PGExecute_pipeQueue", DISPATCH_QUEUE_CONCURRENT); });
        dispatch_async(_pipeQueue, ^{
            NSError *err = nil;
            _stdOut = PGStringFromPipe((NSPipe *)_task.standardOutput, &err);
            if(err) self.lastError = err;
        });
        dispatch_async(_pipeQueue, ^{
            NSError *err = nil;
            _stdErr = PGStringFromPipe((NSPipe *)_task.standardError, &err);
            if(err) self.lastError = err;
        });
    }

    -(NSInteger)waitUntilExit:(NSError **)error {
        NSInteger status = -1;

        @try {
            @synchronized(_executablePath) {
                if(!_didLaunch) {
                    setpptr(error, self.lastError = PGMakeError(1001001, @"Not yet executed", nil));
                    return -1;
                }
            }

            [_task waitUntilExit];
            status = _task.terminationStatus;
        }
        @catch(NSException *exception) {
            setpptr(error, self.lastError = PGErrorFromException(1001001, exception));
        }

        return status;
    }

    -(NSInteger)executeAndWaitUntilExit:(NSError **)error {
        return [[self execute:NULL] waitUntilExit:error];
    }

    -(void)appendEnvironment:(NSString *)name value:(NSString *)value {
        @synchronized(_executablePath) {
            if(_didLaunch) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Already executed" userInfo:nil];
            if(name.length == 0) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Environment variable name is NULL or empty." userInfo:nil];

            NSMutableDictionary<NSString *, NSString *> *env = self.environment.mutableCopy;
            if(value.length == 0) [env removeObjectForKey:name]; else env[name] = value;
            _environment = env;
        }
    }

    -(NSArray<NSString *> *)arguments {
        @synchronized(_executablePath) {
            return _arguments;
        }
    }

    -(NSDictionary<NSString *, NSString *> *)environment {
        @synchronized(_executablePath) {
            return _environment;
        }
    }

    -(void)setArguments:(NSArray<NSString *> *)arguments {
        @synchronized(_executablePath) {
            if(_didLaunch) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Already executed" userInfo:nil];
            _arguments = (arguments ? arguments.copy : [NSArray new]);
        }
    }

    -(void)setEnvironment:(NSDictionary<NSString *, NSString *> *)environment {
        @synchronized(_executablePath) {
            if(_didLaunch) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Already executed" userInfo:nil];
            _environment = (environment ? environment.copy : [NSDictionary new]);
        }
    }

    -(BOOL)isRunning {
        @synchronized(_executablePath) {
            return (_didLaunch && _task.isRunning);
        }
    }

    -(NSInteger)exitCode {
        @synchronized(_executablePath) {
            return _task.terminationStatus;
        }
    }

@end
