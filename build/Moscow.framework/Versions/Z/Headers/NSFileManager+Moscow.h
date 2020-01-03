/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: NSFileManager+Moscow.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 12/18/19
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

#ifndef __PBXBUILDER_NSFILEMANAGER_MOSCOW_H__
#define __PBXBUILDER_NSFILEMANAGER_MOSCOW_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager(Moscow)

#if GNUSTEP

    -(NSString *)destinationOfSymbolicLinkAtPath:(NSString *)path error:(NSError **)error;

#endif

@end

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_NSFILEMANAGER_MOSCOW_H__
