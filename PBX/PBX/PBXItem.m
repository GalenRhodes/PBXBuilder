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
#import "PBXProjectFile.h"

typedef void (^ListPrinterBlock)(id _item, NSString **_prefix, id *_subItem);

NSString *const Spaces       = @"                                                                           ";
NSString *const LinesPattern = @"\\r\\n?|\\n";

NSMutableString *appendItem(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, id item);

NS_INLINE NSString *blankString(NSUInteger length) {
    static NSMutableString *_padding    = nil;
    static dispatch_once_t _paddingFlag = 0;

    dispatch_once(&_paddingFlag, ^{ _padding = [NSMutableString stringWithString:Spaces]; });
    while(_padding.length < length) [_padding appendString:Spaces];
    return [_padding substringToIndex:length];
}

@implementation PBXItem {
        NSRecursiveLock *_lock;
    }

    @synthesize itemId = _itemId;
    @synthesize projectFile = _projectFile;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
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

    -(NSString *)buildDesc:(NSMutableDictionary<NSString *, NSString *> *)cache {
        NSMutableString *buffer = [NSMutableString new];
        NSString        *prefix = PGFormat(@"<%@: ", NSStringFromClass(self.class));
        NSString        *indent = blankString(prefix.length);
        NSString        *start  = PGFormat(@"%@itemId=\"%@\"", prefix, self.itemId);

        cache[self.itemId] = [start stringByAppendingString:@" ...>"];
        [buffer appendString:start];
        [self appendDescBody:buffer indent:indent];
        [buffer appendString:@">"];
        return buffer;
    }

    -(NSString *)description {
        static dispatch_once_t                             _once   = 0;
        static NSMutableDictionary<NSString *, NSString *> *_cache = nil;

        dispatch_once(&_once, ^{ _cache = [NSMutableDictionary new]; });

        @synchronized(_cache) {
            if(_cache.count) {
                return (_cache[self.itemId] ?: [self buildDesc:_cache]);
            }
            else {
                NSString *_desc = nil;
                @try { _desc = [self buildDesc:_cache]; } @finally { [_cache removeAllObjects]; }
                return _desc;
            }
        }
    }

    -(NSString *)debugDescription {
        return PGFormat(@"<{%@: itemId=\"%@\"}>", NSStringFromClass(self.class), self.itemId);
    }

@end

void collectionDescription(NSMutableString *buffer, NSArray *array, NSString *opener, NSString *closer, NSUInteger indentLength, ListPrinterBlock block) {
    id           subItem = nil;
    NSString     *name   = nil;
    NSEnumerator *en     = array.objectEnumerator;

    if(array.count == 0) {
        [buffer appendFormat:@"%@%@", opener, closer];
    }
    else if(array.count == 1) {
        block(en.nextObject, &name, &subItem);
        [buffer appendFormat:@"%@ ", opener];
        appendItem(buffer, @"", @"", name, subItem);
        [buffer appendFormat:@" %@", closer];
    }
    else {
        NSString *closerIndent = blankString(indentLength);
        NSString *itemIndent   = blankString(indentLength + 2);
        id       item          = en.nextObject;

        block(item, &name, &subItem);
        [buffer appendString:opener];
        appendItem(buffer, itemIndent, @"\n", name, subItem);

        while((item = en.nextObject)) {
            block(item, &name, &subItem);
            appendItem(buffer, itemIndent, @",\n", name, subItem);
        }

        [buffer appendFormat:@"\n%@%@", closerIndent, closer];
    }
}

void arrayDescription(NSMutableString *buffer, NSArray *array, NSUInteger indentLength) {
    collectionDescription(buffer, array, @"[", @"]", indentLength, ^(id _item, NSString **_prefix, id *_subItem) {
        *_subItem = _item;
        *_prefix  = @"";
    });
}

void dictDescription(NSMutableString *buffer, NSDictionary *dict, NSUInteger indentLength) {
    NSMutableArray<NSString *>                  *array = [NSMutableArray new];
    NSMutableDictionary<NSString *, NSString *> *foou  = [NSMutableDictionary new];
    NSUInteger                                  keyLen = 0;

    for(id item in dict.allKeys) {
        NSString *itemStr = [item description];
        keyLen = MAX(keyLen, itemStr.length);
        [array addObject:itemStr];
    }

    for(NSString *itemStr in array) {
        NSString *label = PGFormat(@"%@%@", blankString(keyLen - itemStr.length), itemStr);
        foou[itemStr] = label;
    }

    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) { return [obj1 compare:obj2]; }];
    collectionDescription(buffer, array, @"{", @"}", indentLength, ^(id _item, NSString **_prefix, id *_subItem) {
        *_subItem = dict[_item];
        *_prefix  = PGFormat(@"%@: ", foou[_item]);
    });
}

void pbxItemDescription(NSMutableString *buffer, PBXItem *pbxItem, NSUInteger indentLength) {
    NSString            *desc  = [pbxItem description];
    NSArray<NSString *> *lines = [desc split:LinesPattern limit:-1];

    if(lines.count > 1) {
        NSEnumerator<NSString *> *en     = lines.objectEnumerator;
        NSString                 *indent = blankString(indentLength);
        NSString                 *line   = en.nextObject;

        [buffer appendString:line];
        while((line = en.nextObject)) [buffer appendFormat:@"\n%@%@", indent, line];
    }
    else {
        [buffer appendString:desc];
    }
}

NSMutableString *appendItem(NSMutableString *buffer, NSString *indent, NSString *joiner, NSString *prefix, id item) {
    [buffer appendFormat:@"%@%@%@", joiner, indent, prefix];

    if(item == nil) {
        [buffer appendString:@"<NULL>"];
    }
    else if([item isKindOfClass:[NSArray class]]) {
        arrayDescription(buffer, item, (indent.length + prefix.length));
    }
    else if([item isKindOfClass:[NSDictionary class]]) {
        dictDescription(buffer, item, (indent.length + prefix.length));
    }
    else if([item isKindOfClass:[PBXItem class]]) {
        pbxItemDescription(buffer, item, (indent.length + prefix.length));
    }
    else if([item isKindOfClass:[PGBool class]]) {
        [buffer appendString:[item description]];
    }
    else {
        [buffer appendFormat:@"\"%@\"", [item description]];
    }

    return buffer;
}

NSMutableString *PBXAppendItem(NSMutableString *buffer, NSString *indent, NSString *name, id item) {
    return appendItem(buffer, indent, @";\n", [name stringByAppendingString:@"="], item);
}
