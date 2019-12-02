/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXItem.m
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

#import "PBXItem.h"
#import "PGProjectFile.h"

#define SPACES @"                                                                           "

NS_INLINE NSString *blankString(NSUInteger length) {
    static NSMutableString *_padding    = nil;
    static dispatch_once_t _paddingFlag = 0;

    dispatch_once(&_paddingFlag, ^{ _padding = [NSMutableString stringWithString:SPACES]; });
    while(_padding.length < length) [_padding appendString:SPACES];
    return [_padding substringToIndex:length];
}

@implementation PBXItem {
        NSRecursiveLock *_lock;
    }

    @synthesize itemId = _itemId;
    @synthesize projectFile = _projectFile;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super init];

        if(self) {
            if(itemId) {
                _lock        = [NSRecursiveLock new];
                _itemId      = [itemId copy];
                _projectFile = projectFile;
            }
            else {
                return nil;
            }
        }

        return self;
    }

    -(NSString *)objType {
        return [self iv:@"isa"];
    }

    -(nullable id)iv:(NSString *)key {
        NSDictionary<NSString *, NSDictionary<NSString *, id> *> *dict = self.projectFile.projectPBX[self.itemId];
        return dict[key];
    }

    -(BOOL)ivBool:(NSString *)key {
        return ([[self iv:key] description] ?: @"0").boolValue;
    }

    -(NSInteger)ivInt:(NSString *)key {
        return ([[self iv:key] description] ?: @"0").integerValue;
    }

    -(NSUInteger)ivUInt:(NSString *)key {
        BOOL f = NO;
        return (NSUInteger)[NSScanner atoull:key success:&f];
    }

    -(id)itemForKey:(NSString *)key {
        return (key ? [self itemForID:[[self iv:key] description]] : nil);
    }

    -(id)itemForID:(NSString *)itemId {
        return (itemId ? [self.projectFile itemForID:itemId] : nil);
    }

    -(void)lock {
        [_lock lock];
    }

    -(void)unlock {
        [_lock unlock];
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        return str;
    }

    -(NSString *)description {
        static dispatch_once_t                             _globalDescriptionLockFlag   = 0;
        static BOOL                                        _globalDescriptionClearAfter = YES;
        static NSRecursiveLock                             *_globalDescriptionLock      = nil;
        static NSMutableDictionary<NSString *, NSString *> *_globalDescriptionDidPrint  = nil;

        dispatch_once(&_globalDescriptionLockFlag, ^{
            _globalDescriptionLock       = [NSRecursiveLock new];
            _globalDescriptionDidPrint   = [NSMutableDictionary new];
            _globalDescriptionClearAfter = YES;
        });

        BOOL            willClear = NO;
        NSMutableString *str      = [NSMutableString new];
        [_globalDescriptionLock lock];

        @try {
            if((willClear = _globalDescriptionClearAfter)) {
                _globalDescriptionClearAfter = NO;
                [_globalDescriptionDidPrint removeAllObjects];
            }

            [str appendFormat:@"<%@: ", NSStringFromClass(self.class)];
            NSUInteger indentSize = str.length;
            [str appendFormat:@"itemId=\"%@\"", self.itemId];

            if(![_globalDescriptionDidPrint[self.itemId] isEqualToString:self.itemId]) {
                _globalDescriptionDidPrint[self.itemId] = self.itemId;
                NSString *indent = blankString(indentSize);
                [self appendDescBody:str indent:indent];
            }

            [str appendString:@">"];
        }
        @finally {
            if(willClear) {
                [_globalDescriptionDidPrint removeAllObjects];
                _globalDescriptionClearAfter = YES;

                NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"(?:(?:\\\\\\\\)+n|\\\\n)" options:0 error:NULL];
                NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"(?:\\\\\\\\)*\\\\(\")" options:0 error:NULL];

                [regex1 replaceMatchesInString:str options:0 range:str.range withTemplate:@"\n"];
                [regex2 replaceMatchesInString:str options:0 range:str.range withTemplate:@"$1"];
            }

            [_globalDescriptionLock unlock];
        }

        return str;
    }

@end

NS_INLINE NSString *dictPrefix(id key, NSString *indent) {
    return PGFormat(@"%@%@: ", indent, [key description]);
}

NSMutableString *appendItem(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, id item);

NSMutableString *appendPBXItem(NSMutableString *buffer, NSString *joiner, NSString *prefix, id item) {
    NSString            *desc  = [item description];
    NSArray<NSString *> *lines = [desc split:@"\\r\\n?|\\n" limit:-1];

    if(lines.count > 1) {
        NSString *q = blankString(prefix.length);

        [buffer appendString:joiner];
        [buffer appendString:prefix];
        [buffer appendString:lines[0]];

        for(NSUInteger i = 1; i < lines.count; ++i) {
            [buffer appendString:@"\n"];
            [buffer appendString:q];
            [buffer appendString:lines[i]];
        }
    }
    else {
        [buffer appendString:joiner];
        [buffer appendString:prefix];
        [buffer appendString:desc];
    }

    return buffer;
}

NSMutableString *appendDictionary(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, NSDictionary *dict) {
    [buffer appendString:joiner];
    [buffer appendString:prefix];
    [buffer appendString:@"{"];

    if(dict.count == 1) {
        for(id key in dict.allKeys) {
            id item = dict[key];
            [buffer appendString:@" "];
            appendItem(buffer, @"", @"", dictPrefix(key, @""), item);
            [buffer appendString:@" "];
        }
    }
    else {
        NSEnumerator *en = [dict keyEnumerator];
        id           key = en.nextObject;

        if(key) {
            appendItem(buffer, indent, @"\n", dictPrefix(key, indent), dict[key]);

            while((key = en.nextObject)) {
                appendItem(buffer, indent, @",\n", dictPrefix(key, indent), dict[key]);
            }

            [buffer appendString:@"\n"];
            [buffer appendString:blankString(prefix.length)];
        }
    }

    [buffer appendString:@"}"];
    return buffer;
}

NSMutableString *appendArray(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, NSArray *array) {
    [buffer appendString:joiner];
    [buffer appendString:prefix];
    [buffer appendString:@"("];

    if(array.count == 1) {
        [buffer appendString:@" "];
        appendItem(buffer, @"", @"", @"", array[0]);
        [buffer appendString:@" "];
    }
    else if(array.count > 1) {
        appendItem(buffer, indent, @"\n", indent, array[0]);

        for(NSUInteger i = 1; i < array.count; ++i) {
            appendItem(buffer, indent, @",\n", indent, array[i]);
        }

        [buffer appendString:@"\n"];
        [buffer appendString:blankString(prefix.length)];
    }

    [buffer appendString:@")"];
    return buffer;
}

NSMutableString *appendItem(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, id item) {
    NSUInteger idxlen = (indent.length + 4);

    if([item isKindOfClass:[NSArray class]]) {
        return appendArray(buffer, blankString(idxlen), joiner, prefix, (NSArray *)item);
    }
    else if([item isKindOfClass:[NSDictionary class]]) {
        return appendDictionary(buffer, blankString(idxlen), joiner, prefix, item);
    }
    else if([item isKindOfClass:[PBXItem class]]) {
        return appendPBXItem(buffer, joiner, prefix, item);
    }

    [buffer appendFormat:@"%@%@\"%@\"", joiner, prefix, [item description]];
    return buffer;
}

NSMutableString *PBXAppendItem(NSMutableString *buffer, NSString *indent, NSString *name, id item) {
    return appendItem(buffer, indent, @";\n", PGFormat(@"%@%@=", indent, name), item);
}
