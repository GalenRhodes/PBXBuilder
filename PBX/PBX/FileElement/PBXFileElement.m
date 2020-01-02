/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXFileElement.m
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

#import "PBXFileElement.h"
#import "PBXGroup.h"
#import "PBXProjectFile.h"

@implementation PBXFileElement {
        NSString        *_realPath;
        PBXGroup        *_parent;
        dispatch_once_t _realPathOnce;
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSString *)name {
        return [self iv:@"name"];
    }

    -(NSString *)path {
        return [self iv:@"path"];
    }

    -(PBXSourceTree)sourceTree {
        return [PBXFileElement sourceTreeForId:[self iv:@"sourceTree"]];
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        PBXAppendItem(str, indent, @"name", self.name);
        PBXAppendItem(str, indent, @"path", self.path);
        switch(self.sourceTree) {//@f:0
            case PBX_SOURCETREE_ABSOLUTE:           return PBXAppendItem(str, indent, @"sourceTree", @"<absolute>");
            case PBX_SOURCETREE_GROUP:              return PBXAppendItem(str, indent, @"sourceTree", @"<group>");
            case PBX_SOURCETREE_SOURCE_ROOT:        return PBXAppendItem(str, indent, @"sourceTree", @"SOURCE_ROOT");
            case PBX_SOURCETREE_BUILD_PRODUCTS_DIR: return PBXAppendItem(str, indent, @"sourceTree", @"BUILD_PRODUCTS_DIR");
            case PBX_SOURCETREE_SDKROOT:            return PBXAppendItem(str, indent, @"sourceTree", @"SDKROOT");
            default:                                return PBXAppendItem(str, indent, @"sourceTree", @"<none>");
        }//@f:1
    }

    -(NSString *)realPath {
        if(self.parent)
            dispatch_once(&_realPathOnce, ^{
                NSMutableString *str = [NSMutableString new];
                PBXGroup        *p   = self.parent;

                [str appendString:(self.name ?: self.path)];

                while(p) {
                    NSString *s = (p.name ?: p.path);
                    if(s.length) {
                        [str insertString:@"/" atIndex:0];
                        [str insertString:s atIndex:0];
                    }
                    p = p.parent;
                }

                [str insertString:@"/" atIndex:0];
                [str insertString:self.projectFile.projectPath atIndex:0];
                _realPath = str;
            });

        return _realPath;
    }

    -(PBXGroup *)parent {
        return _parent;
    }

    -(void)setParent:(PBXGroup *)parent {
        _parent = parent;
    }

    +(PBXSourceTree)sourceTreeForId:(NSString *)sourceTreeId {
        return (PBXSourceTree)((sourceTreeId.length ? PBXFileElement.sourceTreeMap[sourceTreeId] : nil) ?: @(PBX_SOURCETREE_NONE)).unsignedIntegerValue;
    }

    +(PBXFileEncoding)cleanFileEncoding:(NSUInteger)encodingId {
        return ((self.fileEncodingMap[@(encodingId)] == nil) ? PBX_FILEENCODING_DEFAULT : (PBXFileEncoding)encodingId);
    }

    +(NSString *)fileEncodingForId:(PBXFileEncoding)encodingId {
        return self.fileEncodingMap[@(encodingId)];
    }

    +(PBXFileType)fileTypeForId:(NSString *)typeId {
        return (PBXFileType)((typeId.length ? PBXFileElement.fileTypeMap[typeId] : nil) ?: @(PBX_FILETYPE_NONE)).unsignedIntegerValue;
    }

    +(NSDictionary<NSString *, NSNumber *> *)sourceTreeMap {
        static NSDictionary<NSString *, NSNumber *> *_sourceTree    = nil;
        static dispatch_once_t                      _sourceTreeOnce = 0;

        dispatch_once(&_sourceTreeOnce, ^{
            _sourceTree = @{
                @"<absolute>"        : @(PBX_SOURCETREE_ABSOLUTE),
                @"<group>"           : @(PBX_SOURCETREE_GROUP),
                @"SOURCE_ROOT"       : @(PBX_SOURCETREE_SOURCE_ROOT),
                @"BUILD_PRODUCTS_DIR": @(PBX_SOURCETREE_BUILD_PRODUCTS_DIR),
                @"SDKROOT"           : @(PBX_SOURCETREE_SDKROOT),
            };
        });

        return _sourceTree;
    }

    +(NSDictionary<NSNumber *, NSString *> *)fileEncodingMap {
        static NSDictionary<NSNumber *, NSString *> *_fileEncodings    = nil;
        static dispatch_once_t                      _fileEncodingsOnce = 0;

        dispatch_once(&_fileEncodingsOnce, ^{
            _fileEncodings = @{
                @(PBX_FILEENCODING_UTF8)               : @"UTF8",               // 4
                @(PBX_FILEENCODING_UTF16)              : @"UTF16",              // 10
                @(PBX_FILEENCODING_UTF16_BE)           : @"UTF16_BE",           // 2415919360
                @(PBX_FILEENCODING_UTF16_LE)           : @"UTF16_LE",           // 2483028224
                @(PBX_FILEENCODING_WESTERN)            : @"Western",            // 30
                @(PBX_FILEENCODING_JAPANESE)           : @"Japanese",           // 2147483649
                @(PBX_FILEENCODING_TRADITIONAL_CHINESE): @"TraditionalChinese", // 2147483650
                @(PBX_FILEENCODING_KOREAN)             : @"Korean",             // 2147483651
                @(PBX_FILEENCODING_ARABIC)             : @"Arabic",             // 2147483652
                @(PBX_FILEENCODING_HEBREW)             : @"Hebrew",             // 2147483653
                @(PBX_FILEENCODING_GREEK)              : @"Greek",              // 2147483654
                @(PBX_FILEENCODING_CYRILLIC)           : @"Cyrillic",           // 2147483655
                @(PBX_FILEENCODING_SIMPLIFIED_CHINESE) : @"SimplifiedChinese",  // 2147483673
                @(PBX_FILEENCODING_CENTRAL_EUROPEAN)   : @"CentralEuropean",    // 2147483677
                @(PBX_FILEENCODING_TURKISH)            : @"Turkish",            // 2147483683
                @(PBX_FILEENCODING_ICELANDIC)          : @"Icelandic",          // 2147483685
            };
        });

        return _fileEncodings;
    }

    +(NSDictionary<NSString *, NSNumber *> *)fileTypeMap {
        static NSDictionary<NSString *, NSNumber *> *_fileTypes    = nil;
        static dispatch_once_t                      _fileTypesOnce = 0;

        dispatch_once(&_fileTypesOnce, ^{
            _fileTypes = @{
                @"archive.ar"                        : @(PBX_FILETYPE_ARCHIVE_AR),
                @"archive.asdictionary"              : @(PBX_FILETYPE_ARCHIVE_ASDICTIONARY),
                @"archive.binhex"                    : @(PBX_FILETYPE_ARCHIVE_BINHEX),
                @"archive.ear"                       : @(PBX_FILETYPE_ARCHIVE_EAR),
                @"archive.gzip"                      : @(PBX_FILETYPE_ARCHIVE_GZIP),
                @"archive.jar"                       : @(PBX_FILETYPE_ARCHIVE_JAR),
                @"archive.macbinary"                 : @(PBX_FILETYPE_ARCHIVE_MACBINARY),
                @"archive.ppob"                      : @(PBX_FILETYPE_ARCHIVE_PPOB),
                @"archive.rsrc"                      : @(PBX_FILETYPE_ARCHIVE_RSRC),
                @"archive.stuffit"                   : @(PBX_FILETYPE_ARCHIVE_STUFFIT),
                @"archive.tar"                       : @(PBX_FILETYPE_ARCHIVE_TAR),
                @"archive.war"                       : @(PBX_FILETYPE_ARCHIVE_WAR),
                @"archive.zip"                       : @(PBX_FILETYPE_ARCHIVE_ZIP),
                @"audio.aiff"                        : @(PBX_FILETYPE_AUDIO_AIFF),
                @"audio.au"                          : @(PBX_FILETYPE_AUDIO_AU),
                @"audio.midi"                        : @(PBX_FILETYPE_AUDIO_MIDI),
                @"audio.mp3"                         : @(PBX_FILETYPE_AUDIO_MP3),
                @"audio.wav"                         : @(PBX_FILETYPE_AUDIO_WAV),
                @"compiled.mach-o"                   : @(PBX_FILETYPE_COMPILED_MACHO),
                @"compiled.mach-o.bundle"            : @(PBX_FILETYPE_COMPILED_MACHO_BUNDLE),
                @"compiled.mach-o.corefile"          : @(PBX_FILETYPE_COMPILED_MACHO_COREFILE),
                @"compiled.mach-o.dylib"             : @(PBX_FILETYPE_COMPILED_MACHO_DYLIB),
                @"compiled.mach-o.fvmlib"            : @(PBX_FILETYPE_COMPILED_MACHO_FVMLIB),
                @"compiled.mach-o.objfile"           : @(PBX_FILETYPE_COMPILED_MACHO_OBJFILE),
                @"compiled.mach-o.preload"           : @(PBX_FILETYPE_COMPILED_MACHO_PRELOAD),
                @"file.bplist"                       : @(PBX_FILETYPE_FILE_BPLIST),
                @"file.xib"                          : @(PBX_FILETYPE_FILE_XIB),
                @"image.bmp"                         : @(PBX_FILETYPE_IMAGE_BMP),
                @"image.gif"                         : @(PBX_FILETYPE_IMAGE_GIF),
                @"image.icns"                        : @(PBX_FILETYPE_IMAGE_ICNS),
                @"image.ico"                         : @(PBX_FILETYPE_IMAGE_ICO),
                @"image.jpeg"                        : @(PBX_FILETYPE_IMAGE_JPEG),
                @"image.pdf"                         : @(PBX_FILETYPE_IMAGE_PDF),
                @"image.pict"                        : @(PBX_FILETYPE_IMAGE_PICT),
                @"image.png"                         : @(PBX_FILETYPE_IMAGE_PNG),
                @"image.tiff"                        : @(PBX_FILETYPE_IMAGE_TIFF),
                @"pattern.proxy"                     : @(PBX_FILETYPE_PATTERN_PROXY),
                @"sourcecode.ada"                    : @(PBX_FILETYPE_SOURCECODE_ADA),
                @"sourcecode.applescript"            : @(PBX_FILETYPE_SOURCECODE_APPLESCRIPT),
                @"sourcecode.asm"                    : @(PBX_FILETYPE_SOURCECODE_ASM),
                @"sourcecode.asm.asm"                : @(PBX_FILETYPE_SOURCECODE_ASM_ASM),
                @"sourcecode.asm.llvm"               : @(PBX_FILETYPE_SOURCECODE_ASM_LLVM),
                @"sourcecode.c"                      : @(PBX_FILETYPE_SOURCECODE_C),
                @"sourcecode.c.c.preprocessed"       : @(PBX_FILETYPE_SOURCECODE_C_C_PREPROCESSED),
                @"sourcecode.c.h"                    : @(PBX_FILETYPE_SOURCECODE_C_H),
                @"sourcecode.c.objc"                 : @(PBX_FILETYPE_SOURCECODE_C_OBJC),
                @"sourcecode.c.objc.preprocessed"    : @(PBX_FILETYPE_SOURCECODE_C_OBJC_PREPROCESSED),
                @"sourcecode.cpp.cpp"                : @(PBX_FILETYPE_SOURCECODE_CPP_CPP),
                @"sourcecode.cpp.cpp.preprocessed"   : @(PBX_FILETYPE_SOURCECODE_CPP_CPP_PREPROCESSED),
                @"sourcecode.cpp.h"                  : @(PBX_FILETYPE_SOURCECODE_CPP_H),
                @"sourcecode.cpp.objcpp"             : @(PBX_FILETYPE_SOURCECODE_CPP_OBJCPP),
                @"sourcecode.cpp.objcpp.preprocessed": @(PBX_FILETYPE_SOURCECODE_CPP_OBJCPP_PREPROCESSED),
                @"sourcecode.dtrace"                 : @(PBX_FILETYPE_SOURCECODE_DTRACE),
                @"sourcecode.exports"                : @(PBX_FILETYPE_SOURCECODE_EXPORTS),
                @"sourcecode.fortran"                : @(PBX_FILETYPE_SOURCECODE_FORTRAN),
                @"sourcecode.fortran.f77"            : @(PBX_FILETYPE_SOURCECODE_FORTRAN_F77),
                @"sourcecode.fortran.f90"            : @(PBX_FILETYPE_SOURCECODE_FORTRAN_F90),
                @"sourcecode.glsl"                   : @(PBX_FILETYPE_SOURCECODE_GLSL),
                @"sourcecode.jam"                    : @(PBX_FILETYPE_SOURCECODE_JAM),
                @"sourcecode.java"                   : @(PBX_FILETYPE_SOURCECODE_JAVA),
                @"sourcecode.javascript"             : @(PBX_FILETYPE_SOURCECODE_JAVASCRIPT),
                @"sourcecode.lex"                    : @(PBX_FILETYPE_SOURCECODE_LEX),
                @"sourcecode.make"                   : @(PBX_FILETYPE_SOURCECODE_MAKE),
                @"sourcecode.mig"                    : @(PBX_FILETYPE_SOURCECODE_MIG),
                @"sourcecode.nasm"                   : @(PBX_FILETYPE_SOURCECODE_NASM),
                @"sourcecode.opencl"                 : @(PBX_FILETYPE_SOURCECODE_OPENCL),
                @"sourcecode.pascal"                 : @(PBX_FILETYPE_SOURCECODE_PASCAL),
                @"sourcecode.rez"                    : @(PBX_FILETYPE_SOURCECODE_REZ),
                @"sourcecode.yacc"                   : @(PBX_FILETYPE_SOURCECODE_YACC),
                @"text"                              : @(PBX_FILETYPE_TEXT),
                @"text.css"                          : @(PBX_FILETYPE_TEXT_CSS),
                @"text.html.documentation"           : @(PBX_FILETYPE_TEXT_HTML_DOCUMENTATION),
                @"text.man"                          : @(PBX_FILETYPE_TEXT_MAN),
                @"text.pbxproject"                   : @(PBX_FILETYPE_TEXT_PBXPROJECT),
                @"text.plist"                        : @(PBX_FILETYPE_TEXT_PLIST),
                @"text.plist.info"                   : @(PBX_FILETYPE_TEXT_PLIST_INFO),
                @"text.plist.scriptSuite"            : @(PBX_FILETYPE_TEXT_PLIST_SCRIPTSUITE),
                @"text.plist.scriptTerminology"      : @(PBX_FILETYPE_TEXT_PLIST_SCRIPTTERMINOLOGY),
                @"text.plist.strings"                : @(PBX_FILETYPE_TEXT_PLIST_STRINGS),
                @"text.plist.xclangspec"             : @(PBX_FILETYPE_TEXT_PLIST_XCLANGSPEC),
                @"text.plist.xcspec"                 : @(PBX_FILETYPE_TEXT_PLIST_XCSPEC),
                @"text.plist.xcsynspec"              : @(PBX_FILETYPE_TEXT_PLIST_XCSYNSPEC),
                @"text.plist.xctxtmacro"             : @(PBX_FILETYPE_TEXT_PLIST_XCTXTMACRO),
                @"text.plist.xml"                    : @(PBX_FILETYPE_TEXT_PLIST_XML),
                @"text.rtf"                          : @(PBX_FILETYPE_TEXT_RTF),
                @"text.script"                       : @(PBX_FILETYPE_TEXT_SCRIPT),
                @"text.script.csh"                   : @(PBX_FILETYPE_TEXT_SCRIPT_CSH),
                @"text.script.perl"                  : @(PBX_FILETYPE_TEXT_SCRIPT_PERL),
                @"text.script.php"                   : @(PBX_FILETYPE_TEXT_SCRIPT_PHP),
                @"text.script.python"                : @(PBX_FILETYPE_TEXT_SCRIPT_PYTHON),
                @"text.script.ruby"                  : @(PBX_FILETYPE_TEXT_SCRIPT_RUBY),
                @"text.script.sh"                    : @(PBX_FILETYPE_TEXT_SCRIPT_SH),
                @"textScript.ruby"                   : @(PBX_FILETYPE_TEXT_SCRIPT_RUBY),
                @"text.scriptSh"                     : @(PBX_FILETYPE_TEXT_SCRIPT_SH),
                @"text.script.worksheet"             : @(PBX_FILETYPE_TEXT_SCRIPT_WORKSHEET),
                @"text.xcconfig"                     : @(PBX_FILETYPE_TEXT_XCCONFIG),
                @"text.xml"                          : @(PBX_FILETYPE_TEXT_XML),
                @"video.avi"                         : @(PBX_FILETYPE_VIDEO_AVI),
                @"video.mpeg"                        : @(PBX_FILETYPE_VIDEO_MPEG),
                @"video.quartz-composer"             : @(PBX_FILETYPE_VIDEO_QUARTZCOMPOSER),
                @"video.quicktime"                   : @(PBX_FILETYPE_VIDEO_QUICKTIME),
                @"wrapper.application"               : @(PBX_FILETYPE_WRAPPER_APPLICATION),
                @"wrapper.cfbundle"                  : @(PBX_FILETYPE_WRAPPER_CFBUNDLE),
                @"wrapper.framework"                 : @(PBX_FILETYPE_WRAPPER_FRAMEWORK),
                @"wrapper.pb-project"                : @(PBX_FILETYPE_WRAPPER_PBPROJECT),
            };
        });

        return _fileTypes;
    }

@end
