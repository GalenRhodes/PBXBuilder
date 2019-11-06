/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXFileElementTypes.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 11/6/19
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

#ifndef __PBXBUILDER_PBXFILEELEMENTTYPES_H__
#define __PBXBUILDER_PBXFILEELEMENTTYPES_H__

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, PBXSourceTree) {
    PBX_SOURCETREE_NONE = 0,           //
    PBX_SOURCETREE_ABSOLUTE,           // <absolute>
    PBX_SOURCETREE_GROUP,              // <group>
    PBX_SOURCETREE_SOURCE_ROOT,        // SOURCE_ROOT
    PBX_SOURCETREE_BUILD_PRODUCTS_DIR, // BUILD_PRODUCTS_DIR
    PBX_SOURCETREE_SDKROOT,            // SDKROOT
};

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wconversion"

typedef NS_ENUM(NSUInteger, PBXFileEncoding) {
    PBX_FILEENCODING_DEFAULT             = 0,          // <Default Encoding>
    PBX_FILEENCODING_UTF8                = 4,          // UTF8
    PBX_FILEENCODING_UTF16               = 10,         // UTF16
    PBX_FILEENCODING_UTF16_BE            = 2415919360, // UTF16_BE
    PBX_FILEENCODING_UTF16_LE            = 2483028224, // UTF16_LE
    PBX_FILEENCODING_WESTERN             = 30,         // Western
    PBX_FILEENCODING_JAPANESE            = 2147483649, // Japanese
    PBX_FILEENCODING_TRADITIONAL_CHINESE = 2147483650, // TraditionalChinese
    PBX_FILEENCODING_KOREAN              = 2147483651, // Korean
    PBX_FILEENCODING_ARABIC              = 2147483652, // Arabic
    PBX_FILEENCODING_HEBREW              = 2147483653, // Hebrew
    PBX_FILEENCODING_GREEK               = 2147483654, // Greek
    PBX_FILEENCODING_CYRILLIC            = 2147483655, // Cyrillic
    PBX_FILEENCODING_SIMPLIFIED_CHINESE  = 2147483673, // SimplifiedChinese
    PBX_FILEENCODING_CENTRAL_EUROPEAN    = 2147483677, // CentralEuropean
    PBX_FILEENCODING_TURKISH             = 2147483683, // Turkish
    PBX_FILEENCODING_ICELANDIC           = 2147483685, // Icelandic
};

#pragma clang diagnostic pop

typedef NS_ENUM(NSUInteger, PBXFileType) {
    PBX_FILETYPE_NONE = 0,                           // <no file type>
    PBX_FILETYPE_ARCHIVE_AR,                         // archive.ar
    PBX_FILETYPE_ARCHIVE_ASDICTIONARY,               // archive.asdictionary
    PBX_FILETYPE_ARCHIVE_BINHEX,                     // archive.binhex
    PBX_FILETYPE_ARCHIVE_EAR,                        // archive.ear
    PBX_FILETYPE_ARCHIVE_GZIP,                       // archive.gzip
    PBX_FILETYPE_ARCHIVE_JAR,                        // archive.jar
    PBX_FILETYPE_ARCHIVE_MACBINARY,                  // archive.macbinary
    PBX_FILETYPE_ARCHIVE_PPOB,                       // archive.ppob
    PBX_FILETYPE_ARCHIVE_RSRC,                       // archive.rsrc
    PBX_FILETYPE_ARCHIVE_STUFFIT,                    // archive.stuffit
    PBX_FILETYPE_ARCHIVE_TAR,                        // archive.tar
    PBX_FILETYPE_ARCHIVE_WAR,                        // archive.war
    PBX_FILETYPE_ARCHIVE_ZIP,                        // archive.zip
    PBX_FILETYPE_AUDIO_AIFF,                         // audio.aiff
    PBX_FILETYPE_AUDIO_AU,                           // audio.au
    PBX_FILETYPE_AUDIO_MIDI,                         // audio.midi
    PBX_FILETYPE_AUDIO_MP3,                          // audio.mp3
    PBX_FILETYPE_AUDIO_WAV,                          // audio.wav
    PBX_FILETYPE_COMPILED_MACHO,                     // compiled.mach-o
    PBX_FILETYPE_COMPILED_MACHO_BUNDLE,              // compiled.mach-o.bundle
    PBX_FILETYPE_COMPILED_MACHO_COREFILE,            // compiled.mach-o.corefile
    PBX_FILETYPE_COMPILED_MACHO_DYLIB,               // compiled.mach-o.dylib
    PBX_FILETYPE_COMPILED_MACHO_FVMLIB,              // compiled.mach-o.fvmlib
    PBX_FILETYPE_COMPILED_MACHO_OBJFILE,             // compiled.mach-o.objfile
    PBX_FILETYPE_COMPILED_MACHO_PRELOAD,             // compiled.mach-o.preload
    PBX_FILETYPE_FILE_BPLIST,                        // file.bplist
    PBX_FILETYPE_FILE_XIB,                           // file.xib
    PBX_FILETYPE_IMAGE_BMP,                          // image.bmp
    PBX_FILETYPE_IMAGE_GIF,                          // image.gif
    PBX_FILETYPE_IMAGE_ICNS,                         // image.icns
    PBX_FILETYPE_IMAGE_ICO,                          // image.ico
    PBX_FILETYPE_IMAGE_JPEG,                         // image.jpeg
    PBX_FILETYPE_IMAGE_PDF,                          // image.pdf
    PBX_FILETYPE_IMAGE_PICT,                         // image.pict
    PBX_FILETYPE_IMAGE_PNG,                          // image.png
    PBX_FILETYPE_IMAGE_TIFF,                         // image.tiff
    PBX_FILETYPE_PATTERN_PROXY,                      // pattern.proxy
    PBX_FILETYPE_SOURCECODE_ADA,                     // sourcecode.ada
    PBX_FILETYPE_SOURCECODE_APPLESCRIPT,             // sourcecode.applescript
    PBX_FILETYPE_SOURCECODE_ASM,                     // sourcecode.asm
    PBX_FILETYPE_SOURCECODE_ASM_ASM,                 // sourcecode.asm.asm
    PBX_FILETYPE_SOURCECODE_ASM_LLVM,                // sourcecode.asm.llvm
    PBX_FILETYPE_SOURCECODE_C,                       // sourcecode.c
    PBX_FILETYPE_SOURCECODE_C_C_PREPROCESSED,        // sourcecode.c.c.preprocessed
    PBX_FILETYPE_SOURCECODE_C_H,                     // sourcecode.c.h
    PBX_FILETYPE_SOURCECODE_C_OBJC,                  // sourcecode.c.objc
    PBX_FILETYPE_SOURCECODE_C_OBJC_PREPROCESSED,     // sourcecode.c.objc.preprocessed
    PBX_FILETYPE_SOURCECODE_CPP_CPP,                 // sourcecode.cpp.cpp
    PBX_FILETYPE_SOURCECODE_CPP_CPP_PREPROCESSED,    // sourcecode.cpp.cpp.preprocessed
    PBX_FILETYPE_SOURCECODE_CPP_H,                   // sourcecode.cpp.h
    PBX_FILETYPE_SOURCECODE_CPP_OBJCPP,              // sourcecode.cpp.objcpp
    PBX_FILETYPE_SOURCECODE_CPP_OBJCPP_PREPROCESSED, // sourcecode.cpp.objcpp.preprocessed
    PBX_FILETYPE_SOURCECODE_DTRACE,                  // sourcecode.dtrace
    PBX_FILETYPE_SOURCECODE_EXPORTS,                 // sourcecode.exports
    PBX_FILETYPE_SOURCECODE_FORTRAN,                 // sourcecode.fortran
    PBX_FILETYPE_SOURCECODE_FORTRAN_F77,             // sourcecode.fortran.f77
    PBX_FILETYPE_SOURCECODE_FORTRAN_F90,             // sourcecode.fortran.f90
    PBX_FILETYPE_SOURCECODE_GLSL,                    // sourcecode.glsl
    PBX_FILETYPE_SOURCECODE_JAM,                     // sourcecode.jam
    PBX_FILETYPE_SOURCECODE_JAVA,                    // sourcecode.java
    PBX_FILETYPE_SOURCECODE_JAVASCRIPT,              // sourcecode.javascript
    PBX_FILETYPE_SOURCECODE_LEX,                     // sourcecode.lex
    PBX_FILETYPE_SOURCECODE_MAKE,                    // sourcecode.make
    PBX_FILETYPE_SOURCECODE_MIG,                     // sourcecode.mig
    PBX_FILETYPE_SOURCECODE_NASM,                    // sourcecode.nasm
    PBX_FILETYPE_SOURCECODE_OPENCL,                  // sourcecode.opencl
    PBX_FILETYPE_SOURCECODE_PASCAL,                  // sourcecode.pascal
    PBX_FILETYPE_SOURCECODE_REZ,                     // sourcecode.rez
    PBX_FILETYPE_SOURCECODE_YACC,                    // sourcecode.yacc
    PBX_FILETYPE_TEXT,                               // text
    PBX_FILETYPE_TEXT_CSS,                           // text.css
    PBX_FILETYPE_TEXT_HTML_DOCUMENTATION,            // text.html.documentation
    PBX_FILETYPE_TEXT_MAN,                           // text.man
    PBX_FILETYPE_TEXT_PBXPROJECT,                    // text.pbxproject
    PBX_FILETYPE_TEXT_PLIST,                         // text.plist
    PBX_FILETYPE_TEXT_PLIST_INFO,                    // text.plist.info
    PBX_FILETYPE_TEXT_PLIST_SCRIPTSUITE,             // text.plist.scriptSuite
    PBX_FILETYPE_TEXT_PLIST_SCRIPTTERMINOLOGY,       // text.plist.scriptTerminology
    PBX_FILETYPE_TEXT_PLIST_STRINGS,                 // text.plist.strings
    PBX_FILETYPE_TEXT_PLIST_XCLANGSPEC,              // text.plist.xclangspec
    PBX_FILETYPE_TEXT_PLIST_XCSPEC,                  // text.plist.xcspec
    PBX_FILETYPE_TEXT_PLIST_XCSYNSPEC,               // text.plist.xcsynspec
    PBX_FILETYPE_TEXT_PLIST_XCTXTMACRO,              // text.plist.xctxtmacro
    PBX_FILETYPE_TEXT_PLIST_XML,                     // text.plist.xml
    PBX_FILETYPE_TEXT_RTF,                           // text.rtf
    PBX_FILETYPE_TEXT_SCRIPT,                        // text.script
    PBX_FILETYPE_TEXT_SCRIPT_CSH,                    // text.script.csh
    PBX_FILETYPE_TEXT_SCRIPT_PERL,                   // text.script.perl
    PBX_FILETYPE_TEXT_SCRIPT_PHP,                    // text.script.php
    PBX_FILETYPE_TEXT_SCRIPT_PYTHON,                 // text.script.python
    PBX_FILETYPE_TEXT_SCRIPT_RUBY,                   // text.script.ruby
    PBX_FILETYPE_TEXT_SCRIPT_SH,                     // text.script.sh
    PBX_FILETYPE_TEXT_SCRIPT_WORKSHEET,              // text.script.worksheet
    PBX_FILETYPE_TEXT_XCCONFIG,                      // text.xcconfig
    PBX_FILETYPE_TEXT_XML,                           // text.xml
    PBX_FILETYPE_VIDEO_AVI,                          // video.avi
    PBX_FILETYPE_VIDEO_MPEG,                         // video.mpeg
    PBX_FILETYPE_VIDEO_QUARTZCOMPOSER,               // video.quartz-composer
    PBX_FILETYPE_VIDEO_QUICKTIME,                    // video.quicktime
    PBX_FILETYPE_WRAPPER_APPLICATION,                // wrapper.application
    PBX_FILETYPE_WRAPPER_CFBUNDLE,                   // wrapper.cfbundle
    PBX_FILETYPE_WRAPPER_FRAMEWORK,                  // wrapper.framework
    PBX_FILETYPE_WRAPPER_PBPROJECT,                  // wrapper.pb-project
};

#endif // __PBXBUILDER_PBXFILEELEMENTTYPES_H__
