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

NSMutableString *appendItem(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, id item);

void appendSingleLine(NSMutableString *buffer, NSString *prefix, id item) {
    [buffer appendString:@" "];
    appendItem(buffer, @"", @"", prefix, item);
    [buffer appendString:@" "];
}

NSString *dictKey(NSString *indent, NSString *key) {
    return PGFormat(@"%@%@: ", indent, key);
}

void appendIndent(NSMutableString *buffer, NSString *prefix) {
    [buffer appendFormat:@"\n%@", blankString(prefix.length)];
}

NSMutableString *appendObject(NSMutableString *buffer, NSString *joiner, NSString *prefix, id item) {
    if(item) [buffer appendFormat:@"%@%@\"%@\"", joiner, prefix, item];
    else [buffer appendFormat:@"%@%@<NULL>", joiner, prefix];
    return buffer;
}

NSMutableString *append3(NSMutableString *buffer, NSString *joiner, NSString *prefix, NSString *desc) {
    [buffer appendFormat:@"%@%@%@", joiner, prefix, desc];
    return buffer;
}

NSMutableString *appendPBXItemLines(NSMutableString *buffer, NSString *joiner, NSString *indent, NSString *prefix, NSArray<NSString *> *lines) {
    append3(buffer, joiner, prefix, lines[0]);
    for(NSUInteger i = 1; i < lines.count; ++i) append3(buffer, @"\n", indent, lines[i]);
    return buffer;
}

NSMutableString *appendPBXItem(NSMutableString *buffer, NSString *joiner, NSString *prefix, id item) {
    NSString            *desc  = [item description];
    NSArray<NSString *> *lines = [desc split:@"\\r\\n?|\\n" limit:-1];
    return ((lines.count == 1) ? append3(buffer, joiner, prefix, desc) : appendPBXItemLines(buffer, joiner, blankString(prefix.length), prefix, lines));
}

NSMutableString *appendDictionary(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, NSDictionary *dict) {
    [buffer appendFormat:@"%@%@{", joiner, prefix];

    if(dict.count == 1) {
        for(id key in dict.allKeys) appendSingleLine(buffer, dictKey(@"", key), dict[key]);
    }
    else {
        NSComparator             cmptr = ^NSComparisonResult(id obj1, id obj2) { return [((NSString *)obj1) compare:((NSString *)obj2)]; };
        NSEnumerator<NSString *> *en   = [dict.allKeys sortedArrayUsingComparator:cmptr].objectEnumerator;
        NSString                 *key  = en.nextObject;

        if(key) {
            appendItem(buffer, indent, @"\n", dictKey(indent, key), dict[key]);
            while((key = en.nextObject)) appendItem(buffer, indent, @",\n", dictKey(indent, key), dict[key]);
            appendIndent(buffer, prefix);
        }
    }

    [buffer appendString:@"}"];
    return buffer;
}

NSMutableString *appendArray(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, NSArray *array) {
    [buffer appendFormat:@"%@%@(", joiner, prefix];

    if(array.count == 1) {
        appendSingleLine(buffer, @"", array[0]);
    }
    else if(array.count > 1) {
        NSEnumerator *en  = array.objectEnumerator;
        id           item = en.nextObject;

        if(item) {
            appendItem(buffer, indent, @"\n", indent, item);
            while((item = en.nextObject)) appendItem(buffer, indent, @",\n", indent, item);
            appendIndent(buffer, prefix);
        }
    }

    [buffer appendString:@")"];
    return buffer;
}

NSMutableString *appendItem(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, id item) {
    if([item isKindOfClass:[NSArray class]]) return appendArray(buffer, blankString(indent.length + 4), joiner, prefix, item);
    else if([item isKindOfClass:[NSDictionary class]]) return appendDictionary(buffer, blankString(indent.length + 4), joiner, prefix, item);
    else if([item isKindOfClass:[PBXItem class]]) return appendPBXItem(buffer, joiner, prefix, item);
    else if([item isKindOfClass:[PGBool class]]) return append3(buffer, joiner, prefix, [item description]);
    else return appendObject(buffer, joiner, prefix, item);
}

NSMutableString *PBXAppendItem(NSMutableString *buffer, NSString *indent, NSString *name, id item) {
    return appendItem(buffer, indent, @";\n", PGFormat(@"%@%@=", indent, name), item);
}
