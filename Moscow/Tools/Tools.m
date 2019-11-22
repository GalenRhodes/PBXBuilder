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

NSString *const PGX_STDOUT = @"/dev/stdout";

NSInteger PGExecuteApplication(NSString *appPath, NSArray *appParams, NSString **appOutput, NSError **error) {
    if(error) *error         = nil;
    if(appOutput) *appOutput = nil;

    NSInteger st    = 0;
    NSTask    *task = [[NSTask alloc] init];
    task.launchPath     = appPath;
    task.arguments      = appParams;
    task.standardOutput = [NSPipe pipe];
    task.standardError  = [NSPipe pipe];
    [task launch];
    [task waitUntilExit];

    if((st = task.terminationStatus)) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: PGStringFromPipe((NSPipe *)task.standardError) };
        if(error) *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1001001 userInfo:userInfo];
    }

    if(appOutput) *appOutput = PGStringFromPipe((NSPipe *)task.standardOutput);
    return st;
}

NSString *PGStringFromPipe(NSPipe *pipe) {
    return [[NSString alloc] initWithData:pipe.fileHandleForReading.readDataToEndOfFile encoding:NSUTF8StringEncoding];
}

dispatch_queue_t PGWorkQueue(void) {
    static dispatch_queue_t _workQueue     = NULL;
    static dispatch_once_t  _workQueueOnce = 0;

    _dispatch_once(&_workQueueOnce, ^{ _workQueue = dispatch_queue_create("PGWorkQueue", DISPATCH_QUEUE_SERIAL); });
    return _workQueue;
}

void PGPrintStr(NSString *str) {
#ifdef DEBUG
    [str writeToFile:PGX_STDOUT atomically:NO encoding:NSUTF8StringEncoding error:NULL];
#endif
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
