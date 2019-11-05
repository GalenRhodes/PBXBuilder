/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXFileReference.m
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

#import "PBXFileReference.h"

@implementation PBXFileReference {
    }

    @synthesize explicitFileType = _explicitFileType;
    @synthesize includeInIndex = _includeInIndex;
    @synthesize lastKnownFileType = _lastKnownFileType;
    @synthesize fileEncoding = _fileEncoding;

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PGProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];

        if(self) {
            _includeInIndex    = [self ivBool:@"includeInIndex"];
            _fileEncoding      = [PBXFileElement cleanFileEncoding:[self ivUInt:@"fileEncoding"]];
            _explicitFileType  = [PBXFileElement fileTypeForId:[self iv:@"explicitFileType"]];
            _lastKnownFileType = [PBXFileElement fileTypeForId:[self iv:@"lastKnownFileType"]];
        }

        return self;
    }

@end
