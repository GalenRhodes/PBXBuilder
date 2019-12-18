/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: Tools.m
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/5/19
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

#import "Tools.h"
#import "NSString+Moscow.h"
#import "PGExecute.h"

NSString *const PGX_STDOUT = @"/dev/stdout";

NSString *const MoscowErrorDomain = @"com.projectgalen.Moscow";

NSInteger PGExecuteApplication(NSString *appPath, NSArray *appParams, NSString **appOutput, NSError **error) {
    PGExecute *exe = [PGExecute exeWithAppPath:appPath arguments:appParams error:error];

    if(exe) {
        NSInteger ec = [exe executeAndWaitUntilExit:error];
        setpptr(appOutput, exe.stdOut);
        return ec;
    }

    return -1;
}

NSString *PGStringFromPipe(NSPipe *pipe, NSError **error) {
    NSData *data = nil;
    setpptr(error, nil);
#ifdef __APPLE__
    data = [pipe.fileHandleForReading readDataToEndOfFileAndReturnError:error];
#else
    @try { data = [pipe.fileHandleForReading readDataToEndOfFile]; } @catch(NSException *exception) { setpptr(error, PGErrorFromException(1022, exception)); }
#endif
    return (data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil);
}

NSError *PGErrorFromException(NSInteger code, NSException *ex) {
    return PGMakeError(code, PGFormat(@"%@: %@", ex.name, ex.reason), ex.userInfo);
}

NSError *PGMakeError(NSInteger code, NSString *reason, NSDictionary *userInfo) {
    NSMutableDictionary *_userInfo = (userInfo ? userInfo.mutableCopy : [NSMutableDictionary new]);
    _userInfo[NSLocalizedDescriptionKey] = (reason ?: @"Unknown Error");
    return [NSError errorWithDomain:MoscowErrorDomain code:code userInfo:_userInfo];
}

dispatch_queue_t PGWorkQueue(void) {
    static dispatch_queue_t _workQueue     = NULL;
    static dispatch_once_t  _workQueueOnce = 0;

    _dispatch_once(&_workQueueOnce, ^{ _workQueue = dispatch_queue_create("PGWorkQueue", DISPATCH_QUEUE_SERIAL); });
    return _workQueue;
}

void PGPrintStr(NSString *str) {
    [str writeToFile:PGX_STDOUT atomically:NO encoding:NSUTF8StringEncoding error:NULL];
}

void PGPrintf(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    PGPrintStr([[NSString alloc] initWithFormat:format arguments:args]);
    va_end(args);
}

NSString *PGFormat(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    return str;
}

NSString *PGClassName(id obj) {
    if([obj isKindOfClass:[NSString class]]) {
        return @"NSString";
    }
    else if([obj isKindOfClass:[NSArray class]]) {
        return @"NSArray";
    }
    else if([obj isKindOfClass:[NSDictionary class]]) {
        return @"NSDictionary";
    }
    else if([obj isKindOfClass:[NSData class]]) {
        return @"NSData";
    }
    else {
        return NSStringFromClass([obj class]);
    }
}

void PGPrintStruct(NSString *prefix, NSString *blockBegin, NSString *blockEnd, NSUInteger count, PGPrintStructBlock blk) {
    if(count == 0) {
        PGPrintf(@"%@%@%@", prefix, blockBegin, blockEnd);
    }
    else if(count == 1) {
        PGPrintf(@"%@%@ ", prefix, blockBegin);
        blk(@"", NO);
        PGPrintf(@" %@", blockEnd);
    }
    else {
        NSString   *s1  = PGFormat(@"%@%@", prefix, blockBegin);
        NSUInteger len1 = s1.length;

        PGPrintf(@"%@\n", s1);
        blk(PGFormat(PGFormat(@"%%%lus", len1 + 2), ""), YES);
        PGPrintf(@"%@%@", PGFormat(PGFormat(@"%%%lus", len1 - 1), ""), blockEnd);
    }
}

void PGPrintItem(NSString *pfx, id obj) {
    if([obj isKindOfClass:[NSArray class]]) {
        PGPrintStruct(pfx, @"(", @")", [obj count], ^(NSString *_pfx, BOOL addCR) {
            BOOL comma = NO;

            for(id _obj in ((NSArray *)obj)) {
                if(comma) { if(addCR) PGPrintStr(@",\n"); else PGPrintStr(@","); } else comma = YES;
                PGPrintItem(_pfx, _obj);
            }

            if(addCR) PGPrintStr(@"\n");
        });
    }
    else if([obj isKindOfClass:[NSDictionary class]]) {
        PGPrintStruct(pfx, @"{", @"}", [obj count], ^(NSString *_pfx, BOOL addCR) {
            NSDictionary *dict = (NSDictionary *)obj;
            NSUInteger   len   = 0;
            BOOL         comma = NO;

            for(NSString *s1 in dict.keyEnumerator) len = MAX(len, s1.length);
            NSString *s2 = PGFormat(@"%%%lus", (len + 2));

            for(NSString *s1 in dict.keyEnumerator) {
                if(comma) { if(addCR) PGPrintStr(@",\n"); else PGPrintStr(@","); } else comma = YES;
                NSString *s3 = PGFormat(@"\"%@\"", s1);
                NSString *s4 = PGFormat(@"%@%@ = ", _pfx, PGFormat(s2, s3.UTF8String));
                PGPrintItem(s4, dict[s1]);
            }

            if(addCR) PGPrintStr(@"\n");
        });
    }
    else if([obj isKindOfClass:[NSData class]]) {
        PGPrintStruct(pfx, @"[", @"]", 0, ^(NSString *_pfx, BOOL addCR) {
            // TODO: FInish...
        });
    }
    else if(obj) {
        PGPrintf(@"%@\"%@\"", pfx, [obj description]);
    }
    else {
        PGPrintf(@"%@<NULL>", pfx);
    }
}

void PGPrintPlist(id obj) {
    PGPrintItem(@"", obj);
    PGPrintStr(@"\n");
}

NSArray<NSString *> *PGFindByName(NSString *dir, NSString *filename, NSError **error) {
    return PGFindWithBlock(dir, ^BOOL(NSString *path, NSString *fn) {
        return ([fn isEqualToString:filename]);
    }, error);
}

NSArray<NSString *> *PGFindByRegex(NSString *dir, NSString *regexPattern, BOOL includePath, NSError **error) {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:0 error:error];

    return (regex ? PGFindWithBlock(dir, ^BOOL(NSString *path, NSString *filename) {
        NSString *fn = (includePath ? PGFormat(@"%@/%@", path, filename) : filename);
        return ([regex numberOfMatchesInString:fn options:0 range:fn.range] != 0);
    }, error) : nil);
}

NSArray<NSString *> *PGFindWithBlock(NSString *dir, PGFindBlock block, NSError **error) {
    NSMutableArray<NSString *> *results = nil;
    NSError                    *e       = nil;
    NSFileManager              *fm      = [NSFileManager defaultManager];

    setpptr(error, e);

#ifdef __APPLE__
    NSError             *e2     = nil;
    NSArray<NSString *> *files  = [fm contentsOfDirectoryAtPath:dir error:&e];
    NSString            *output = @"";
    NSInteger           i       = e.code;

    if(files) {
        results = [NSMutableArray new];

        for(NSString *str in files) {
            BOOL     isDir  = NO;
            NSString *path  = PGFormat(@"%@/%@", dir, str);
            BOOL     exists = [fm fileExistsAtPath:path isDirectory:&isDir];

            if(exists) {
                if(isDir) {
                    NSArray<NSString *> *subResults = PGFindWithBlock(path, block, &e2);
                    if(subResults) [results addObjectsFromArray:subResults];
                    else if(!e) e = e2;
                }
                else if(block(dir, str)) [results addObject:path];
            }
        }
    }
#else
        NSString  *output = nil;
        NSInteger i       = PGExecuteApplication(@"/usr/bin/find", @[ dir ], &output, &e);

        if(output && i == 0) {
            NSArray<NSString *> *files = [output split:@"\\r\\n?|\\n" limit:0];

            results = [NSMutableArray new];

            for(NSString *path in files) {
                BOOL     isDir  = NO;
                BOOL     exists = [fm fileExistsAtPath:path isDirectory:&isDir];
                NSString *file  = path.lastPathComponent;
                NSString *fpath = path.stringByDeletingLastPathComponent;

                if(exists && !isDir && block(fpath, file)) [results addObject:path];
            }
        }
#endif
    else {
        setpptr(error, [NSError errorWithDomain:MoscowErrorDomain code:1024 userInfo:@{
            NSLocalizedDescriptionKey: PGFormat(@"Results: %li\nError: %@\nOutput:\n%@\n", i, e.localizedDescription, output)
        }]);
    }

    return results;
}

void *PGMalloc(size_t size) {
    void *buffer = malloc(size);
    if(buffer) return buffer;
    @throw [NSException exceptionWithName:NSMallocException reason:@"Not enough memory" userInfo:nil];
}

void *PGRealloc(void *buffer, size_t size) {
    void *nbuffer = realloc(buffer, size);
    if(nbuffer) return nbuffer;
    @throw [NSException exceptionWithName:NSMallocException reason:@"Not enough memory" userInfo:nil];
}

NSString *PGStrError(int error_num) {
    int      o_errno = errno;
    size_t   bsize   = 1024;
    char     *buffer = PGMalloc(bsize);
    NSString *errMsg;

    @try {
        do {
#if defined(__APPLE__) || ((_POSIX_C_SOURCE >= 200112L) && !_GNU_SOURCE)
            int res = strerror_r(error_num, buffer, bsize);
            if((res == ERANGE) || (((res < 0) && (errno == ERANGE)))) {
#else
                errno = 0;
                char *res = strerror_r(error_num, buffer, bsize);
                if(errno == ERANGE) {
#endif
                buffer = PGRealloc(buffer, (bsize *= 2));
            }
            else {
                errMsg = [NSString stringWithUTF8String:buffer];
                break;
            }
        }
        while(1);
    }
    @finally {
        free(buffer);
    }

    errno            = o_errno;
    return errMsg;
}
