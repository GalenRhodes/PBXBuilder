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

#ifndef __PBXBUILDER_TOOLS_H__
#define __PBXBUILDER_TOOLS_H__

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, ANSIGraphicsRendition) {
    ANSI_GR_RESET              = 0,
    ANSI_GR_BOLD,
    ANSI_GR_FAINT,
    ANSI_GR_ITALIC,
    ANSI_GR_UNDERLINE,
    ANSI_GR_BLINK,
    ANSI_GR_FAST_BLINK,
    ANSI_GR_INVERSE,
    ANSI_GR_CONCEAL,
    ANSI_GR_STRIKE,
    ANSI_GR_DEFAULT_FONT       = 10,
    ANSI_GR_ALT_FONT_1,
    ANSI_GR_ALT_FONT_2,
    ANSI_GR_ALT_FONT_3,
    ANSI_GR_ALT_FONT_4,
    ANSI_GR_ALT_FONT_5,
    ANSI_GR_ALT_FONT_6,
    ANSI_GR_ALT_FONT_7,
    ANSI_GR_ALT_FONT_8,
    ANSI_GR_ALT_FONT_9,
    ANSI_GR_FRAKTUR            = 20,
    ANSI_GR_BOLD_OFF,
    ANSI_GR_NORMAL_COLOR,
    ANSI_GR_ITALIC_OFF,
    ANSI_GR_UNDERLINE_OFF,
    ANSI_GR_BLINK_OFF,
    ANSI_GR_INVERSE_OFF        = 27, // #26 is not defined
    ANSI_GR_REVEAL,
    ANSI_GR_STRIKE_OFF,
    ANSI_GR_FG_BLACK           = 30,
    ANSI_GR_FG_RED,
    ANSI_GR_FG_GREEN,
    ANSI_GR_FG_YELLOW,
    ANSI_GR_FG_BLUE,
    ANSI_GR_FG_MAGENTA,
    ANSI_GR_FG_CYAN,
    ANSI_GR_FG_WHITE,
    ANSI_GR_FG_DEFAULT         = 39, // #38 is complex
    ANSI_GR_BG_BLACK           = 40,
    ANSI_GR_BG_RED,
    ANSI_GR_BG_GREEN,
    ANSI_GR_BG_YELLOW,
    ANSI_GR_BG_BLUE,
    ANSI_GR_BG_MAGENTA,
    ANSI_GR_BG_CYAN,
    ANSI_GR_BG_WHITE,
    ANSI_GR_BG_DEFAULT         = 49, // #48 is complex
    ANSI_GR_FRAMED             = 51, // #50 is not defined
    ANSI_GR_ENCIRCLED,
    ANSI_GR_OVERLINED,
    ANSI_GR_FRAMED_OVERLINED_OFF,
    ANSI_GR_OVERLINED_OFF,
    ANSI_GR_IDEOGRAM_UNDERLINE = 60, // #56-59 are not defined
    ANSI_GR_IDEOGRAM_DOUBLE_UNDERLINE,
    ANSI_GR_IDEOGRAM_OVERLINE,
    ANSI_GR_IDEOGRAM_DOUBLE_OVERLINE,
    ANSI_GR_IDEOGRAM_STRESS_MARKING,
    ANSI_GR_IDEOGRAMS_OFF,
    ANSI_GR_FG_BRIGHT_BLACK    = 90, // #66-89 are not defined
    ANSI_GR_FG_BRIGHT_RED,
    ANSI_GR_FG_BRIGHT_GREEN,
    ANSI_GR_FG_BRIGHT_YELLOW,
    ANSI_GR_FG_BRIGHT_BLUE,
    ANSI_GR_FG_BRIGHT_MAGENTA,
    ANSI_GR_FG_BRIGHT_CYAN,
    ANSI_GR_FG_BRIGHT_WHITE,
    ANSI_GR_BG_BRIGHT_BLACK    = 100, // #98-99 are not defined
    ANSI_GR_BG_BRIGHT_RED,
    ANSI_GR_BG_BRIGHT_GREEN,
    ANSI_GR_BG_BRIGHT_YELLOW,
    ANSI_GR_BG_BRIGHT_BLUE,
    ANSI_GR_BG_BRIGHT_MAGENTA,
    ANSI_GR_BG_BRIGHT_CYAN,
    ANSI_GR_BG_BRIGHT_WHITE
};

#ifndef PG_OVERLOADED
    #define PG_OVERLOADED __attribute__((overloadable))
#endif

#if GNUSTEP

    #if !defined(NS_INLINE)
        #if defined(__GNUC__)
            #define NS_INLINE static __inline__ __attribute__((always_inline))
        #elif defined(__MWERKS__) || defined(__cplusplus)
            #define NS_INLINE static inline
        #elif defined(_MSC_VER)
            #define NS_INLINE static __inline
        #endif
    #endif

#endif

#define setpptr(p, e) ({ if(p) (*(p)) = (e); })

#define mandalorian(l, t, e) ({ [l lock]; t v; @try { v = (e); } @finally { [l unlock]; } v = v; })

NS_ASSUME_NONNULL_BEGIN

typedef void (^PGPrintStructBlock)(NSString *prefix, BOOL addCR);

typedef BOOL (^PGFindBlock)(NSString *path, NSString *filename);

FOUNDATION_EXPORT NSString *PGAddANSI(id obj, NSUInteger count, ANSIGraphicsRendition *colors, NSUInteger afterCount);

FOUNDATION_EXPORT NSString *PGpLeft(id obj, NSString *padding, BOOL truncate, NSUInteger length) PG_OVERLOADED;

FOUNDATION_EXPORT NSString *PGpLeft(id obj, NSString *padding, NSUInteger length) PG_OVERLOADED;

FOUNDATION_EXPORT NSString *PGpLeft(id obj, NSUInteger length) PG_OVERLOADED;

FOUNDATION_EXPORT NSString *const MoscowErrorDomain;

FOUNDATION_EXPORT void *PGMalloc(size_t size);

FOUNDATION_EXPORT void *PGRealloc(void *buffer, size_t size);

FOUNDATION_EXPORT NSString *PGStrError(int error_num);

FOUNDATION_EXPORT NSError *PGErrorFromException(NSInteger code, NSException *ex);

FOUNDATION_EXPORT NSError *PGMakeError(NSInteger code, NSString *reason, NSDictionary *_Nullable userInfo);

FOUNDATION_EXPORT NSInteger PGExecuteApplication(NSString *appPath, NSArray *appParams, NSString *_Nullable *_Nullable appOutput, NSError **error);

FOUNDATION_EXPORT NSString *PGStringFromPipe(NSPipe *pipe, NSError **error);

FOUNDATION_EXPORT dispatch_queue_t PGWorkQueue(void);

FOUNDATION_EXPORT void PGPrintStr(NSString *str);

FOUNDATION_EXPORT void PGPrintf(NSString *format, ...) NS_FORMAT_FUNCTION(1, 2);

FOUNDATION_EXPORT NSString *PGFormat(NSString *format, ...) NS_FORMAT_FUNCTION(1, 2);

FOUNDATION_EXPORT NSString *PGClassName(id obj);

FOUNDATION_EXPORT void PGPrintPlist(id obj);

FOUNDATION_EXPORT NSArray<NSString *> *PGFindWithBlock(NSString *dir, PGFindBlock block, NSError **error);

FOUNDATION_EXPORT NSArray<NSString *> *PGFindByRegex(NSString *dir, NSString *regexPattern, BOOL includePath, NSError **error);

FOUNDATION_EXPORT NSArray<NSString *> *PGFindByName(NSString *dir, NSString *filename, NSError **error);

NS_INLINE BOOL NSRangeNotFound(NSRange range) {
    return ((range.location == NSNotFound) && (range.length == 0));
}

NS_INLINE BOOL NSRangeValid(NSRange range) {
    return !((range.location == NSNotFound) && (range.length == 0));
}

NS_INLINE NSMutableArray *PGMutableArrayCopy(NSArray *array) {
    return ([array isKindOfClass:NSMutableArray.class] ? ((NSMutableArray *)array) : array.mutableCopy);
}

NS_INLINE NSMutableDictionary *PGMutableDictCopy(NSDictionary *dict) {
    return ([dict isKindOfClass:NSMutableDictionary.class] ? ((NSMutableDictionary *)dict) : dict.mutableCopy);
}

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_TOOLS_H__
