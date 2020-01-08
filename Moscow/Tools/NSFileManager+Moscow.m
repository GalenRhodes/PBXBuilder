/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: NSFileManager+Moscow.m
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

#if GNUSTEP
#import <pwd.h>
#endif

#import "Tools.h"
#import "NSFileManager+Moscow.h"

@implementation NSFileManager(Moscow)

#if GNUSTEP

-(NSString *)destinationOfSymbolicLinkAtPath:(NSString *)path error:(NSError **)error {
    size_t bsize   = PATH_MAX;
    char   *buffer = PGMalloc(bsize);

    @try {
        do {
            ssize_t retval = readlink(path.UTF8String, buffer, bsize);

            if(retval < 0) {
                if(error) {
                    int o_errno = errno;
                    *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:o_errno userInfo:@{ NSLocalizedDescriptionKey: PGStrError(o_errno) }];
                }
                return nil;
            }
            else if(retval == bsize) {
                buffer = PGRealloc(buffer, (bsize *= 2));
            }
            else {
                buffer[retval] = 0;
                return [NSString stringWithUTF8String:buffer];
            }
        }
        while(1);
    }
    @finally {
        free(buffer);
    }
}

-(NSURL *)homeDirectoryForCurrentUser {
    uid_t uid = getuid();
    struct passwd *uinfo = getpwuid(uid);
    return [NSURL fileURLWithPath:((uinfo && uinfo->pw_dir) ? [NSString stringWithUTF8String:uinfo->pw_dir]: @"~".stringByExpandingTildeInPath) isDirectory:YES];
}

#endif

@end
