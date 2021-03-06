/************************************************************************//**
*     PROJECT: PBXBuilder
*    FILENAME: Tools.h
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

#import <Cocoa/Cocoa.h>

FOUNDATION_EXPORT double              MoscowVersionNumber;
FOUNDATION_EXPORT const unsigned char MoscowVersionString[];

#import <Moscow/Tools.h>
#import <Moscow/NSString+Moscow.h>
#import <Moscow/NSMutableArray+Moscow.h>
#import <Moscow/NSScanner+Moscow.h>
#import <Moscow/NSData+Moscow.h>
#import <Moscow/NSRegularExpression+Moscow.h>
#import <Moscow/PGBool.h>
#import <Moscow/PGExecute.h>
#import <Moscow/PGCmdLine.h>
#import <Moscow/NSFileManager+Moscow.h>
#import <Moscow/NSProcessInfo+Moscow.h>
#import <Moscow/NSNull+Moscow.h>
