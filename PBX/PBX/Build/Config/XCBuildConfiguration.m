/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: XCBuildConfiguration.m
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

#import <grp.h>
#import "XCBuildConfiguration.h"
#import "XCConfigurationList.h"
#import "PBXProjectFile.h"
#import "PBXProject.h"
#import "PBXTarget.h"
#import "PBXPrivate.h"

NSString *const XCBuildConfigNameDebug   = @"Debug";
NSString *const XCBuildConfigNameRelease = @"Release";
NSString *const XCBuildConfigNameDefault = XCBuildConfigNameRelease;

NSString *const PBX_UI_CURRENT_ACTION = @"PBX_UI_CURRENT_ACTION";
NSString *const PBX_UI_BUILD_DIR      = @"PBX_UI_BUILD_DIR";

/*

    /Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins

    /Clang LLVM 1.0.xcplugin/Contents/Resources/Clang LLVM 1.0.xcspec
    /CoreBuildTasks.xcplugin/Contents/Resources/Ld.xcspec
    /XCLanguageSupport.xcplugin/Contents/Resources/Swift.xcspec

 */

id toNull(id o) {
    return o ?: NSNull.null;
}

@implementation XCBuildConfiguration {
        XCConfigurationList          *_configurationList;
        NSDictionary<NSNumber *, id> *_defaultsMap;
        dispatch_once_t              _defaultsOnce;
    }

    -(instancetype)initWithItemId:(NSString *)itemId projectFile:(PBXProjectFile *)projectFile {
        self = [super initWithItemId:itemId projectFile:projectFile];
        return self;
    }

    -(NSString *)name {
        return [self iv:@"name"];
    }

    -(NSDictionary<NSString *, id> *)buildSettings {
        return ([self iv:@"buildSettings"] ?: [NSDictionary new]);
    }

    -(NSString *)baseConfigurationReference {
        return [self iv:@"baseConfigurationReference"];
    }

    -(NSMutableString *)appendDescBody:(NSMutableString *)str indent:(NSString *)indent {
        [super appendDescBody:str indent:indent];
        PBXAppendItem(str, indent, @"name", self.name);
        PBXAppendItem(str, indent, @"baseConfigurationReference", self.baseConfigurationReference);
        PBXAppendItem(str, indent, @"buildSettings", self.buildSettings);
        return str;
    }

    +(NSArray<NSString *> *)allBuildConfigurationNames {
        static NSArray<NSString *> *_configNames;
        static dispatch_once_t     _configNamesOnce;
        dispatch_once(&_configNamesOnce, ^{ _configNames = @[ XCBuildConfigNameDebug, XCBuildConfigNameRelease ]; });
        return _configNames;
    }

    -(id)expandMacrosIn:(id)obj usingBlock:(PBXExpMacroBlock)block {
        if([obj isKindOfClass:NSArray.class]) {
            NSArray *arr = obj;

            if(arr.count) {
                NSMutableArray *marr = [NSMutableArray new];
                [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { [marr addObjectWithCheck:[self expandMacrosIn:obj usingBlock:block]]; }];
                return marr;
            }
        }
        else if([obj isKindOfClass:NSDictionary.class]) {
            NSDictionary *dict = obj;

            if(dict.count) {
                NSMutableDictionary *mdict = [NSMutableDictionary new];
                [dict enumerateKeysAndObjectsUsingBlock:^(id k, id o, BOOL *stop) { mdict[k] = [self expandMacrosIn:o usingBlock:block]; }];
                return mdict;
            }
        }
        else {
            NSString                        *str = [obj description];
            NSArray<NSTextCheckingResult *> *res = [NSRegularExpression matchesInString:str pattern:@"\\$\\(([^)]+)\\)"];

            if(res.count) {
                NSMutableString *mstr = [NSMutableString new];
                NSUInteger      p     = 0;

                for(NSTextCheckingResult *r in res) {
                    NSRange rng0 = r.range;
                    NSRange rng1 = [r rangeAtIndex:1];

                    [mstr appendString:[str substringFrom:p to:rng0.location]];
                    p = NSMaxRange(rng0);

                    BOOL     stop  = NO;
                    NSString *repl = block([str substringWithRange:rng1], &stop);
                    if(repl.length) [mstr appendString:[self expandMacrosIn:repl usingBlock:block]];
                    if(stop) break;
                }

                if(p < str.length) [mstr appendString:[str substringFromIndex:p]];
                return str;
            }
        }

        return obj;
    }

    -(id)settingForName:(NSString *)name {
        id                   obj = self.buildSettings[name];
        if(!obj) obj             = [self getDefaultSettingForName:name];
        if(obj) return [self expandMacrosIn:obj usingBlock:^NSString *(NSString *macro, BOOL *stop) { return [self settingForName:macro]; }];
        /*
         * If we didn't find a value here, go down to the project level and check there.
         */
        XCBuildConfiguration *xc = [self.projectFile.project.buildConfigurationList buildConfigurationForName:self.name];
        return (xc && (xc != self) ? [xc settingForName:name] : nil);
    }

    typedef id (^PBXGetSettingBlock)(PBXVariable vid);

    -(id)getDefaultSettingForName:(NSString *)name {
        if([name isEqualToString:@"inherited"]) return @"$(inherited)";
        else return [self getDefaultSetting:(PBXVariable)PBXVars.nameVariableMap[name ?: @""].unsignedIntegerValue defaultValue:PGFormat(@"$(%@)", name)];
    }

    -(id)getDefaultSetting:(PBXVariable)varId defaultValue:(id)d2 {
        _dispatch_once(&_defaultsOnce, ^{
            NSFileManager       *fm             = NSFileManager.defaultManager;
            XCConfigurationList *configList     = self.configurationList;
            PBXTarget           *currTarget     = configList.target;
            PBXGetSettingBlock  blk             = ^id(PBXVariable vid) { return [self getDefaultSetting:vid defaultValue:d2]; };
            NSURL               *homeDirURL     = fm.homeDirectoryForCurrentUser;
            NSString            *homeDir        = [homeDirURL.absoluteString substringFromIndex:@"file://".length].stringByStandardizingPath;
            NSString            *derivedDirRoot = PGFormat(@"%@/Library/Developer/Xcode/DerivedData", homeDir);
            NSString            *derivedDir     = PGFormat(@"%@/%@", derivedDirRoot, self.projectFile.projectName);
            NSString            *xcodeDir       = @"/Applications/Xcode.app/Contents/Developer";
            NSString            *osLibPath      = @"/Library";
            NSString            *osAppDir       = @"/Applications";
            NSString            *osSysLibDir    = @"/System/Library";
            NSString            *devLang        = @"English";

            _defaultsMap = @{
                @(PBX_VAR_ACTION)                                                    : toNull(self.projectFile.userInfo[PBX_UI_CURRENT_ACTION]),
                @(PBX_VAR_AD_HOC_CODE_SIGNING_ALLOWED)                               : PGBool.boolNo,
                @(PBX_VAR_ALTERNATE_GROUP)                                           : toNull(blk(PBX_VAR_GROUP)),
                @(PBX_VAR_ALTERNATE_MODE)                                            : @"u+w,go-w,a+rX",
                @(PBX_VAR_ALTERNATE_OWNER)                                           : toNull(blk(PBX_VAR_USER)),
                @(PBX_VAR_ALWAYS_SEARCH_USER_PATHS)                                  : PGBool.boolNo,
                @(PBX_VAR_ALWAYS_USE_SEPARATE_HEADERMAPS)                            : PGBool.boolYes,
                @(PBX_VAR_APPLE_INTERNAL_DEVELOPER_DIR)                              : PGFormat(@"/AppleInternal/Developer"),
                @(PBX_VAR_APPLE_INTERNAL_DIR)                                        : PGFormat(@"/AppleInternal"),
                @(PBX_VAR_APPLE_INTERNAL_DOCUMENTATION_DIR)                          : PGFormat(@"/AppleInternal/Documentation"),
                @(PBX_VAR_APPLE_INTERNAL_LIBRARY_DIR)                                : PGFormat(@"/AppleInternal/Library"),
                @(PBX_VAR_APPLE_INTERNAL_TOOLS)                                      : @[ PGFormat(@"/AppleInternal/Developer/Tools") ],
                @(PBX_VAR_APPLY_RULES_IN_COPY_FILES)                                 : PGBool.boolNo,
                @(PBX_VAR_ARCH)                                                      : toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)),
                @(PBX_VAR_ARCHS)                                                     : @[ toNull(blk(PBX_VAR_NATIVE_ARCH_32_BIT)) ],
                @(PBX_VAR_ARCHS_STANDARD)                                            : @[ toNull(blk(PBX_VAR_NATIVE_ARCH_32_BIT)), toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)) ],
                @(PBX_VAR_ARCHS_STANDARD_32_64_BIT)                                  : @[ toNull(blk(PBX_VAR_NATIVE_ARCH_32_BIT)), toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)) ],
                @(PBX_VAR_ARCHS_STANDARD_32_BIT)                                     : @[ toNull(blk(PBX_VAR_NATIVE_ARCH_32_BIT)) ],
                @(PBX_VAR_ARCHS_STANDARD_64_BIT)                                     : @[ toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)) ],
                @(PBX_VAR_ARCHS_STANDARD_INCLUDING_64_BIT)                           : @[ toNull(blk(PBX_VAR_NATIVE_ARCH_32_BIT)), toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)) ],
                @(PBX_VAR_ARCHS_UNIVERSAL_IPHONE_OS)                                 : @[ toNull(blk(PBX_VAR_NATIVE_ARCH_32_BIT)), toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)) ],
                @(PBX_VAR_ASSETCATALOG_COMPILER_APPICON_NAME)                        : @"AppIcon",
                @(PBX_VAR_ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME)                    : @"LaunchImage",
                @(PBX_VAR_AVAILABLE_PLATFORMS)                                       : @[ toNull(blk(PBX_VAR_SDK_NAME)) ],
                @(PBX_VAR_BUILD_COMPONENTS)                                          : @[ @"headers", @"build" ],
                @(PBX_VAR_BUILD_DIR)                                                 : toNull(blk(PBX_VAR_BUILD_ROOT)),
                @(PBX_VAR_BUILD_ROOT)                                                : PGFormat(@"%@/Build/Products", derivedDir),
                @(PBX_VAR_BUILD_STYLE)                                               : NSNull.null,
                @(PBX_VAR_BUILD_VARIANTS)                                            : @[ toNull(blk(PBX_VAR_VARIANT)) ],
                @(PBX_VAR_BUILT_PRODUCTS_DIR)                                        : PGFormat(@"%@/%@-%@",
                                                                                                toNull(blk(PBX_VAR_BUILD_ROOT)),
                                                                                                self.name,
                                                                                                toNull(blk(PBX_VAR_PLATFORM_NAME))),
                @(PBX_VAR_CACHE_ROOT)                                                : NSNull.null,
                @(PBX_VAR_CCHROOT)                                                   : NSNull.null,
                @(PBX_VAR_CHMOD)                                                     : PGFindTool(@"chmod"),
                @(PBX_VAR_CHOWN)                                                     : PGFindTool(@"chown"),
                @(PBX_VAR_CLANG_ENABLE_OBJC_ARC)                                     : PGBool.boolYes,
                @(PBX_VAR_CLANG_WARN_CONSTANT_CONVERSION)                            : PGBool.boolYes,
                @(PBX_VAR_CLANG_WARN_ENUM_CONVERSION)                                : PGBool.boolYes,
                @(PBX_VAR_CLANG_WARN_INT_CONVERSION)                                 : PGBool.boolYes,
                @(PBX_VAR_CLANG_WARN__DUPLICATE_METHOD_MATCH)                        : PGBool.boolYes,
                @(PBX_VAR_CLASS_FILE_DIR)                                            : PGFormat(@"%@/JavaClasses", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_CLEAN_PRECOMPS)                                            : PGBool.boolYes,
                @(PBX_VAR_CLONE_HEADERS)                                             : PGBool.boolNo,
                @(PBX_VAR_CODESIGNING_FOLDER_PATH)                                   : NSNull.null,
                @(PBX_VAR_CODE_SIGNING_ALLOWED)                                      : PGBool.boolNo,
                @(PBX_VAR_CODE_SIGNING_REQUIRED)                                     : PGBool.boolNo,
                @(PBX_VAR_CODE_SIGN_CONTEXT_CLASS)                                   : @[],
                @(PBX_VAR_CODE_SIGN_IDENTITY)                                        : @"MacOSX Developer",
                @(PBX_VAR_COLOR_DIAGNOSTICS)                                         : PGBool.boolYes,
                @(PBX_VAR_COMBINE_HIDPI_IMAGES)                                      : PGBool.boolNo,
                @(PBX_VAR_COMPOSITE_SDK_DIRS)                                        : @[],
                @(PBX_VAR_COMPRESS_PNG_FILES)                                        : PGBool.boolYes,
                @(PBX_VAR_CONFIGURATION)                                             : @"Release",
                @(PBX_VAR_CONFIGURATION_BUILD_DIR)                                   : PGFormat(@"%@", toNull(blk(PBX_VAR_BUILT_PRODUCTS_DIR))),
                @(PBX_VAR_CONFIGURATION_TEMP_DIR)                                    : PGFormat(@"%@/%@-%@",
                                                                                                toNull(blk(PBX_VAR_PROJECT_TEMP_DIR)),
                                                                                                self.name,
                                                                                                toNull(blk(PBX_VAR_SDK_NAME))),
                @(PBX_VAR_CONTENTS_FOLDER_PATH)                                      : toNull(blk(PBX_VAR_FULL_PRODUCT_NAME)),
                @(PBX_VAR_COPYING_PRESERVES_HFS_DATA)                                : PGBool.boolNo,
                @(PBX_VAR_COPY_PHASE_STRIP)                                          : PGBool.boolNo,
                @(PBX_VAR_COPY_RESOURCES_FROM_STATIC_FRAMEWORKS)                     : PGBool.boolYes,
                @(PBX_VAR_CP)                                                        : PGFindTool(@"cp"),
                @(PBX_VAR_CREATE_INFOPLIST_SECTION_IN_BINARY)                        : PGBool.boolNo,
                @(PBX_VAR_CURRENT_ARCH)                                              : toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)),
                @(PBX_VAR_CURRENT_VARIANT)                                           : toNull(blk(PBX_VAR_VARIANT)),
                @(PBX_VAR_DEAD_CODE_STRIPPING)                                       : PGBool.boolYes,
                @(PBX_VAR_DEBUGGING_SYMBOLS)                                         : PGBool.boolYes,
                @(PBX_VAR_DEBUG_INFORMATION_FORMAT)                                  : @"elf",
                @(PBX_VAR_DEFAULT_COMPILER)                                          : @"clang",
                @(PBX_VAR_DEFAULT_KEXT_INSTALL_PATH)                                 : PGFormat(@"%@/Extensions", osSysLibDir),
                @(PBX_VAR_DEPLOYMENT_LOCATION)                                       : PGBool.boolNo,
                @(PBX_VAR_DEPLOYMENT_POSTPROCESSING)                                 : PGBool.boolNo,
                @(PBX_VAR_DERIVED_FILES_DIR)                                         : PGFormat(@"%@", toNull(blk(PBX_VAR_DERIVED_SOURCES_DIR))),
                @(PBX_VAR_DERIVED_FILE_DIR)                                          : PGFormat(@"%@", toNull(blk(PBX_VAR_DERIVED_SOURCES_DIR))),
                @(PBX_VAR_DERIVED_SOURCES_DIR)                                       : PGFormat(@"%@/DerivedSources", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_DEVELOPER_APPLICATIONS_DIR)                                : PGFormat(@"%@/Applications", xcodeDir),
                @(PBX_VAR_DEVELOPER_BIN_DIR)                                         : PGFormat(@"%@/usr/bin", xcodeDir),
                @(PBX_VAR_DEVELOPER_DIR)                                             : xcodeDir,
                @(PBX_VAR_DEVELOPER_FRAMEWORKS_DIR)                                  : PGFormat(@"%@/Library/Frameworks", xcodeDir),
                @(PBX_VAR_DEVELOPER_FRAMEWORKS_DIR_QUOTED)                           : PGFormat(@"%@/Library/Frameworks", xcodeDir),
                @(PBX_VAR_DEVELOPER_LIBRARY_DIR)                                     : PGFormat(@"%@/Library", xcodeDir),
                @(PBX_VAR_DEVELOPER_SDK_DIR)                                         : PGFormat(@"%@/Platforms/MacOSX.platform/Developer/SDKs", xcodeDir),
                @(PBX_VAR_DEVELOPER_TOOLS_DIR)                                       : PGFormat(@"%@/Tools", xcodeDir),
                @(PBX_VAR_DEVELOPER_USR_DIR)                                         : PGFormat(@"%@/usr", xcodeDir),
                @(PBX_VAR_DEVELOPMENT_LANGUAGE)                                      : devLang,
                @(PBX_VAR_DIAGNOSTIC_MESSAGE_LENGTH)                                 : @(97),
                @(PBX_VAR_DOCUMENTATION_FOLDER_PATH)                                 : PGFormat(@"%@/%@/Documentation",
                                                                                                toNull(blk(PBX_VAR_TARGETNAME)),
                                                                                                toNull(blk(PBX_VAR_LOCALIZED_RESOURCES_FOLDER_PATH))),
                @(PBX_VAR_DO_HEADER_SCANNING_IN_JAM)                                 : PGBool.boolNo,
                @(PBX_VAR_DSTROOT)                                                   : PGFormat(@"/tmp/%@.dst", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_DT_TOOLCHAIN_DIR)                                          : PGFormat(@"%@/Toolchains/XcodeDefault.xctoolchain", xcodeDir),
                @(PBX_VAR_DWARF_DSYM_FILE_NAME)                                      : PGFormat(@"Meijer.app.dSYM"),
                @(PBX_VAR_DWARF_DSYM_FILE_SHOULD_ACCOMPANY_PRODUCT)                  : PGBool.boolNo,
                @(PBX_VAR_DWARF_DSYM_FOLDER_PATH)                                    : PGFormat(@"%@", toNull(blk(PBX_VAR_BUILT_PRODUCTS_DIR))),
                @(PBX_VAR_EFFECTIVE_PLATFORM_NAME)                                   : PGFormat(@"-%@", toNull(blk(PBX_VAR_PLATFORM_NAME))),
                @(PBX_VAR_EMBEDDED_PROFILE_NAME)                                     : @"embedded.mobileprovision",
                @(PBX_VAR_ENABLE_HEADER_DEPENDENCIES)                                : PGBool.boolYes,
                @(PBX_VAR_ENTITLEMENTS_ALLOWED)                                      : PGBool.boolYes,
                @(PBX_VAR_ENTITLEMENTS_REQUIRED)                                     : PGBool.boolYes,
                @(PBX_VAR_EXCLUDED_INSTALLSRC_SUBDIRECTORY_PATTERNS)                 : @[ @".DS_Store", @".svn", @".git", @".hg", @"CVS" ],
                @(PBX_VAR_EXCLUDED_RECURSIVE_SEARCH_PATH_SUBDIRECTORIES)             : @[
                    @"*.nib", @"*.lproj", @"*.framework", @"*.gch", @"(*)", @".DS_Store", @"CVS", @".svn", @".git", @".hg", @"*.xcodeproj", @"*.xcode", @"*.pbproj", @"*.pbxproj"
                ],
                @(PBX_VAR_EXECUTABLES_FOLDER_PATH)                                   : PGFormat(@"%@/Executables", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_EXECUTABLE_FOLDER_PATH)                                    : toNull(blk(PBX_VAR_FULL_PRODUCT_NAME)),
                @(PBX_VAR_EXECUTABLE_NAME)                                           : toNull(blk(PBX_VAR_TARGETNAME)),
                @(PBX_VAR_EXECUTABLE_PATH)                                           : PGFormat(@"%@/%@", toNull(blk(PBX_VAR_TARGETNAME)), toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_FILE_LIST)                                                 : PGFormat(@"%@/Objects/LinkFileList", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_FIXED_FILES_DIR)                                           : PGFormat(@"%@/FixedFiles", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_FRAMEWORKS_FOLDER_PATH)                                    : PGFormat(@"%@/Frameworks", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_FRAMEWORK_FLAG_PREFIX)                                     : @"-framework",
                @(PBX_VAR_FRAMEWORK_SEARCH_PATHS)                                    : @[],
                @(PBX_VAR_FRAMEWORK_VERSION)                                         : @"A",
                @(PBX_VAR_FULL_PRODUCT_NAME)                                         : PGFormat(@"%@.%@", toNull(blk(PBX_VAR_TARGETNAME)), toNull(blk(PBX_VAR_WRAPPER_EXTENSION))),
                @(PBX_VAR_GCC3_VERSION)                                              : @"3.3",
                @(PBX_VAR_GCC_C_LANGUAGE_STANDARD)                                   : @"gnu99",
                @(PBX_VAR_GCC_INLINES_ARE_PRIVATE_EXTERN)                            : PGBool.boolYes,
                @(PBX_VAR_GCC_PFE_FILE_C_DIALECTS)                                   : @[ @"c", @"objective-c", @"c++", @"objective-c++" ],
                @(PBX_VAR_GCC_PRECOMPILE_PREFIX_HEADER)                              : PGBool.boolYes,
                @(PBX_VAR_GCC_PREFIX_HEADER)                                         : PGFormat(@"%@/%@-Prefix.pch",
                                                                                                toNull(blk(PBX_VAR_TARGETNAME)),
                                                                                                toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_GCC_PREPROCESSOR_DEFINITIONS)                              : @[],
                @(PBX_VAR_GCC_SYMBOLS_PRIVATE_EXTERN)                                : PGBool.boolYes,
                @(PBX_VAR_GCC_THUMB_SUPPORT)                                         : PGBool.boolYes,
                @(PBX_VAR_GCC_TREAT_WARNINGS_AS_ERRORS)                              : PGBool.boolNo,
                @(PBX_VAR_GCC_VERSION)                                               : @"com.apple.compilers.llvm.clang.1_0",
                @(PBX_VAR_GCC_VERSION_IDENTIFIER)                                    : @"com_apple_compilers_llvm_clang_1_0",
                @(PBX_VAR_GCC_WARN_ABOUT_RETURN_TYPE)                                : PGBool.boolYes,
                @(PBX_VAR_GCC_WARN_UNINITIALIZED_AUTOS)                              : PGBool.boolYes,
                @(PBX_VAR_GCC_WARN_UNUSED_VARIABLE)                                  : PGBool.boolYes,
                @(PBX_VAR_GENERATE_MASTER_OBJECT_FILE)                               : PGBool.boolNo,
                @(PBX_VAR_GENERATE_PKGINFO_FILE)                                     : PGBool.boolYes,
                @(PBX_VAR_GENERATE_PROFILING_CODE)                                   : PGBool.boolNo,
                @(PBX_VAR_GID)                                                       : @(NSProcessInfo.processInfo.groupID),
                @(PBX_VAR_GROUP)                                                     : toNull(NSProcessInfo.processInfo.groupName),
                @(PBX_VAR_HEADERMAP_INCLUDES_FLAT_ENTRIES_FOR_TARGET_BEING_BUILT)    : PGBool.boolYes,
                @(PBX_VAR_HEADERMAP_INCLUDES_FRAMEWORK_ENTRIES_FOR_ALL_PRODUCT_TYPES): PGBool.boolYes,
                @(PBX_VAR_HEADERMAP_INCLUDES_NONPUBLIC_NONPRIVATE_HEADERS)           : PGBool.boolYes,
                @(PBX_VAR_HEADERMAP_INCLUDES_PROJECT_HEADERS)                        : PGBool.boolYes,
                @(PBX_VAR_HEADER_SEARCH_PATHS)                                       : @[],
                @(PBX_VAR_ICONV)                                                     : PGFindTool(@"iconv"),
                @(PBX_VAR_INFOPLIST_EXPAND_BUILD_SETTINGS)                           : PGBool.boolYes,
                @(PBX_VAR_INFOPLIST_FILE)                                            : PGFormat(@"%@/%@-Info.plist",
                                                                                                toNull(blk(PBX_VAR_TARGETNAME)),
                                                                                                toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_INFOPLIST_OUTPUT_FORMAT)                                   : @"binary",
                @(PBX_VAR_INFOPLIST_PATH)                                            : PGFormat(@"%@/Info.plist", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_INFOPLIST_PREPROCESS)                                      : PGBool.boolNo,
                @(PBX_VAR_INFOSTRINGS_PATH)                                          : PGFormat(@"%@/%@/InfoPlist.strings",
                                                                                                toNull(blk(PBX_VAR_TARGETNAME)),
                                                                                                toNull(blk(PBX_VAR_LOCALIZED_RESOURCES_FOLDER_PATH))),
                @(PBX_VAR_INSTALL_DIR)                                               : PGFormat(@"%@/%@", toNull(blk(PBX_VAR_INSTALL_ROOT)), toNull(blk(PBX_VAR_INSTALL_PATH))),
                @(PBX_VAR_INSTALL_GROUP)                                             : toNull(blk(PBX_VAR_GROUP)),
                @(PBX_VAR_INSTALL_MODE_FLAG)                                         : @"u+w,go-w,a+rX",
                @(PBX_VAR_INSTALL_OWNER)                                             : toNull(blk(PBX_VAR_USER)),
                @(PBX_VAR_INSTALL_PATH)                                              : PGFormat(@"%@", osAppDir),
                @(PBX_VAR_INSTALL_ROOT)                                              : PGFormat(@"/tmp/%@.dst", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_IPHONEOS_DEPLOYMENT_TARGET)                                : @"6.0",
                @(PBX_VAR_JAVAC_DEFAULT_FLAGS)                                       : @[],
                @(PBX_VAR_JAVA_APP_STUB)                                             : NSNull.null,
                @(PBX_VAR_JAVA_ARCHIVE_CLASSES)                                      : PGBool.boolYes,
                @(PBX_VAR_JAVA_ARCHIVE_TYPE)                                         : @"JAR",
                @(PBX_VAR_JAVA_COMPILER)                                             : PGFindTool(@"javac"),
                @(PBX_VAR_JAVA_FOLDER_PATH)                                          : PGFormat(@"%@/Java", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_JAVA_FRAMEWORK_RESOURCES_DIRS)                             : @[ @"Resources" ],
                @(PBX_VAR_JAVA_JAR_FLAGS)                                            : @[ @"cv" ],
                @(PBX_VAR_JAVA_SOURCE_SUBDIR)                                        : @".",
                @(PBX_VAR_JAVA_USE_DEPENDENCIES)                                     : PGBool.boolYes,
                @(PBX_VAR_JAVA_ZIP_FLAGS)                                            : @[ @"-urg" ],
                @(PBX_VAR_JIKES_DEFAULT_FLAGS)                                       : @[ @"+E", @"+OLDCSO" ],
                @(PBX_VAR_KEEP_PRIVATE_EXTERNS)                                      : PGBool.boolNo,
                @(PBX_VAR_LD_DEPENDENCY_INFO_FILE)                                   : PGFormat(@"%@/Objects-normal/armv7s/Meijer_dependency_info.dat",
                                                                                                toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_LD_GENERATE_MAP_FILE)                                      : PGBool.boolYes,
                @(PBX_VAR_LD_MAP_FILE_PATH)                                          : PGFormat(@"%@/Meijer-LinkMap-normal-armv7s.txt", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_LD_NO_PIE)                                                 : PGBool.boolNo,
                @(PBX_VAR_LD_QUOTE_LINKER_ARGUMENTS_FOR_COMPILER_DRIVER)             : PGBool.boolYes,
                @(PBX_VAR_LEGACY_DEVELOPER_DIR)                                      : PGFormat(@"%@/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer",
                                                                                                osAppDir),
                @(PBX_VAR_LEX)                                                       : PGFindTool(@"lex"),
                @(PBX_VAR_LIBRARY_FLAG_NOSPACE)                                      : PGBool.boolYes,
                @(PBX_VAR_LIBRARY_FLAG_PREFIX)                                       : @"-l",
                @(PBX_VAR_LIBRARY_KEXT_INSTALL_PATH)                                 : PGFormat(@"%@/Extensions", osLibPath),
                @(PBX_VAR_LIBRARY_SEARCH_PATHS)                                      : @[],
                @(PBX_VAR_LINKER_DISPLAYS_MANGLED_NAMES)                             : PGBool.boolNo,
                @(PBX_VAR_LINK_FILE_LIST_NORMAL_ARMV7)                               : @"",
                @(PBX_VAR_LINK_FILE_LIST_NORMAL_ARMV7S)                              : @"",
                @(PBX_VAR_LINK_WITH_STANDARD_LIBRARIES)                              : PGBool.boolYes,
                @(PBX_VAR_LOCALIZED_RESOURCES_FOLDER_PATH)                           : PGFormat(@"%@/%@.lproj",
                                                                                                toNull(blk(PBX_VAR_TARGETNAME)),
                                                                                                toNull(blk(PBX_VAR_DEVELOPMENT_LANGUAGE))),
                @(PBX_VAR_LOCAL_ADMIN_APPS_DIR)                                      : PGFormat(@"%@/Utilities", osAppDir),
                @(PBX_VAR_LOCAL_APPS_DIR)                                            : PGFormat(@"%@", osAppDir),
                @(PBX_VAR_LOCAL_DEVELOPER_DIR)                                       : PGFormat(@"%@/Developer", osLibPath),
                @(PBX_VAR_LOCAL_LIBRARY_DIR)                                         : PGFormat(@"%@", osLibPath),
                @(PBX_VAR_MACH_O_TYPE)                                               : @"mh_execute",
                @(PBX_VAR_MAC_OS_X_PRODUCT_BUILD_VERSION)                            : @"13C64",
                @(PBX_VAR_MAC_OS_X_VERSION_ACTUAL)                                   : @"1092",
                @(PBX_VAR_MAC_OS_X_VERSION_MAJOR)                                    : @"1090",
                @(PBX_VAR_MAC_OS_X_VERSION_MINOR)                                    : @"0902",
                @(PBX_VAR_MODULE_CACHE_DIR)                                          : PGFormat(@"%@/ModuleCache", derivedDirRoot),
                @(PBX_VAR_NATIVE_ARCH)                                               : toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)),
                @(PBX_VAR_NATIVE_ARCH_32_BIT)                                        : @"i386",
                @(PBX_VAR_NATIVE_ARCH_64_BIT)                                        : @"x86_64",
                @(PBX_VAR_NATIVE_ARCH_ACTUAL)                                        : toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)),
                @(PBX_VAR_NIL)                                                       : d2,
                @(PBX_VAR_NO_COMMON)                                                 : PGBool.boolYes,
                @(PBX_VAR_OBJECT_FILE_DIR)                                           : PGFormat(@"%@/Objects", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_OBJECT_FILE_DIR_NORMAL)                                    : PGFormat(@"%@/Objects-normal", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_OBJROOT)                                                   : toNull(blk(PBX_VAR_PROJECT_TEMP_ROOT)),
                @(PBX_VAR_ONLY_ACTIVE_ARCH)                                          : PGBool.boolNo,
                @(PBX_VAR_OPTIMIZATION_LEVEL)                                        : @(0),
                @(PBX_VAR_OS)                                                        : @"MACOS",
                @(PBX_VAR_OSAC)                                                      : PGFindTool(@"osacompile"),
                @(PBX_VAR_OTHER_CFLAGS)                                              : @[ @"-DNS_BLOCK_ASSERTIONS=1" ],
                @(PBX_VAR_OTHER_CPLUSPLUSFLAGS)                                      : @[ @"-DNS_BLOCK_ASSERTIONS=1" ],
                @(PBX_VAR_OTHER_LDFLAGS)                                             : @[],
                @(PBX_VAR_PACKAGE_TYPE)                                              : @"com.apple.package-type.wrapper.application",
                @(PBX_VAR_PASCAL_STRINGS)                                            : PGBool.boolYes,
                @(PBX_VAR_PATH)                                                      : PGFormat(@""),
                @(PBX_VAR_PATH_PREFIXES_EXCLUDED_FROM_HEADER_DEPENDENCIES)           : @[
                    @"/usr/include",
                    @"/usr/local/include",
                    PGFormat(@"%@/Frameworks", osSysLibDir),
                    PGFormat(@"%@/PrivateFrameworks", osSysLibDir),
                    PGFormat(@"%@/Headers", xcodeDir),
                    PGFormat(@"%@/SDKs", xcodeDir),
                    PGFormat(@"%@/Platforms", xcodeDir)
                ],
                @(PBX_VAR_PBDEVELOPMENTPLIST_PATH)                                   : NSNull.null,
                @(PBX_VAR_PFE_FILE_C_DIALECTS)                                       : @[ @"objective-c" ],
                @(PBX_VAR_PKGINFO_FILE_PATH)                                         : PGFormat(@"%@/PkgInfo", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_PKGINFO_PATH)                                              : PGFormat(@"%@/PkgInfo", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_PLATFORM_DEVELOPER_APPLICATIONS_DIR)                       : PGFormat(@"%@/Platforms/MacOSX.platform/Developer/Applications", xcodeDir),
                @(PBX_VAR_PLATFORM_DEVELOPER_BIN_DIR)                                : PGFormat(@"%@/Platforms/MacOSX.platform/Developer/usr/bin", xcodeDir),
                @(PBX_VAR_PLATFORM_DEVELOPER_LIBRARY_DIR)                            : PGFormat(@"%@/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library",
                                                                                                osAppDir),
                @(PBX_VAR_PLATFORM_DEVELOPER_SDK_DIR)                                : PGFormat(@"%@/Platforms/MacOSX.platform/Developer/SDKs", xcodeDir),
                @(PBX_VAR_PLATFORM_DEVELOPER_TOOLS_DIR)                              : PGFormat(@"%@/Platforms/MacOSX.platform/Developer/Tools", xcodeDir),
                @(PBX_VAR_PLATFORM_DEVELOPER_USR_DIR)                                : PGFormat(@"%@/Platforms/MacOSX.platform/Developer/usr", xcodeDir),
                @(PBX_VAR_PLATFORM_DIR)                                              : PGFormat(@"%@/Platforms/MacOSX.platform", xcodeDir),
                @(PBX_VAR_PLATFORM_NAME)                                             : @"macos",
                @(PBX_VAR_PLATFORM_PREFERRED_ARCH)                                   : toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)),
                @(PBX_VAR_PLATFORM_PRODUCT_BUILD_VERSION)                            : @"11D167",
                @(PBX_VAR_PLIST_FILE_OUTPUT_FORMAT)                                  : @"binary",
                @(PBX_VAR_PLUGINS_FOLDER_PATH)                                       : PGFormat(@"%@/PlugIns", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_PRECOMPS_INCLUDE_HEADERS_FROM_BUILT_PRODUCTS_DIR)          : PGBool.boolYes,
                @(PBX_VAR_PRECOMP_DESTINATION_DIR)                                   : PGFormat(@"%@/PrefixHeaders", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_PRESERVE_DEAD_CODE_INITS_AND_TERMS)                        : PGBool.boolNo,
                @(PBX_VAR_PRIVATE_HEADERS_FOLDER_PATH)                               : PGFormat(@"%@/PrivateHeaders", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_PRODUCT_NAME)                                              : toNull(blk(PBX_VAR_TARGETNAME)),
                @(PBX_VAR_PRODUCT_SETTINGS_PATH)                                     : PGFormat(@"%@/%@/Info.plist",
                                                                                                toNull(blk(PBX_VAR_SOURCE_ROOT)),
                                                                                                toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_PRODUCT_TYPE)                                              : PBXNativeTarget.productTypesMap[@((self.configurationList.target.productType))],
                @(PBX_VAR_PROFILING_CODE)                                            : PGBool.boolNo,
                @(PBX_VAR_PROJECT)                                                   : toNull(blk(PBX_VAR_PROJECT_NAME)),
                @(PBX_VAR_PROJECT_DERIVED_FILE_DIR)                                  : PGFormat(@"%@/DerivedSources",
                                                                                                toNull(blk(PBX_VAR_PROJECT_TEMP_DIR))), // %@/Build/Intermediates/Meijer.build/DerivedSources
                @(PBX_VAR_PROJECT_DIR)                                               : toNull(blk(PBX_VAR_SOURCE_ROOT)),
                @(PBX_VAR_PROJECT_FILE_PATH)                                         : PGFormat(@"%@/%@.xcodeproj",
                                                                                                toNull(blk(PBX_VAR_PROJECT_DIR)),
                                                                                                toNull(blk(PBX_VAR_PROJECT_NAME))),
                @(PBX_VAR_PROJECT_NAME)                                              : toNull(self.projectFile.projectName),
                @(PBX_VAR_PROJECT_TEMP_DIR)                                          : PGFormat(@"%@/%@.build",
                                                                                                toNull(blk(PBX_VAR_PROJECT_TEMP_ROOT)),
                                                                                                toNull(blk(PBX_VAR_PROJECT_NAME))), // %@/Build/Intermediates/Meijer.build
                @(PBX_VAR_PROJECT_TEMP_ROOT)                                         : PGFormat(@"%@/Build/Intermediates", derivedDir), // %@/Build/Intermediates
                @(PBX_VAR_PROVISIONING_PROFILE_REQUIRED)                             : PGBool.boolYes,
                @(PBX_VAR_PUBLIC_HEADERS_FOLDER_PATH)                                : PGFormat(@"%@/Headers", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_RECURSIVE_SEARCH_PATHS_FOLLOW_SYMLINKS)                    : PGBool.boolYes,
                @(PBX_VAR_REMOVE_CVS_FROM_RESOURCES)                                 : PGBool.boolYes,
                @(PBX_VAR_REMOVE_GIT_FROM_RESOURCES)                                 : PGBool.boolYes,
                @(PBX_VAR_REMOVE_HG_FROM_RESOURCES)                                  : PGBool.boolYes,
                @(PBX_VAR_REMOVE_SVN_FROM_RESOURCES)                                 : PGBool.boolYes,
                @(PBX_VAR_RESOURCE_RULES_REQUIRED)                                   : PGBool.boolYes,
                @(PBX_VAR_REZ_COLLECTOR_DIR)                                         : PGFormat(@"%@/ResourceManagerResources", toNull(blk(PBX_VAR_TARGET_TEMP_DIR))),
                @(PBX_VAR_REZ_OBJECTS_DIR)                                           : PGFormat(@"%@/Objects", toNull(blk(PBX_VAR_REZ_COLLECTOR_DIR))),
                @(PBX_VAR_SCAN_ALL_SOURCE_FILES_FOR_INCLUDES)                        : PGBool.boolNo,
                @(PBX_VAR_SCRIPTS_FOLDER_PATH)                                       : PGFormat(@"%@/Scripts", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_SDKROOT)                                                   : toNull(blk(PBX_VAR_SDK_NAME)),
                @(PBX_VAR_SDK_DIR)                                                   : PGFormat(@"%@/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk", xcodeDir),
                @(PBX_VAR_SDK_NAME)                                                  : @"macosx",
                @(PBX_VAR_SDK_PRODUCT_BUILD_VERSION)                                 : @"11D167",
                @(PBX_VAR_SED)                                                       : PGFindTool(@"sed"),
                @(PBX_VAR_SEPARATE_STRIP)                                            : PGBool.boolNo,
                @(PBX_VAR_SEPARATE_SYMBOL_EDIT)                                      : PGBool.boolNo,
                @(PBX_VAR_SET_DIR_MODE_OWNER_GROUP)                                  : PGBool.boolYes,
                @(PBX_VAR_SET_FILE_MODE_OWNER_GROUP)                                 : PGBool.boolNo,
                @(PBX_VAR_SHALLOW_BUNDLE)                                            : PGBool.boolYes,
                @(PBX_VAR_SHARED_DERIVED_FILE_DIR)                                   : PGFormat(@"%@/DerivedSources", toNull(blk(PBX_VAR_BUILT_PRODUCTS_DIR))),
                @(PBX_VAR_SHARED_FRAMEWORKS_FOLDER_PATH)                             : PGFormat(@"%@/SharedFrameworks", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_SHARED_PRECOMPS_DIR)                                       : PGFormat(@"%@/PrecompiledHeaders", toNull(blk(PBX_VAR_PROJECT_TEMP_ROOT))),
                @(PBX_VAR_SHARED_SUPPORT_FOLDER_PATH)                                : PGFormat(@"%@/SharedSupport", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_SKIP_INSTALL)                                              : PGBool.boolNo,
                @(PBX_VAR_SOURCE_ROOT)                                               : toNull(self.projectFile.projectPath),
                @(PBX_VAR_SRCROOT)                                                   : toNull(blk(PBX_VAR_SOURCE_ROOT)),
                @(PBX_VAR_STRINGS_FILE_OUTPUT_ENCODING)                              : @"binary",
                @(PBX_VAR_STRIP_INSTALLED_PRODUCT)                                   : PGBool.boolYes,
                @(PBX_VAR_STRIP_STYLE)                                               : @"all",
                @(PBX_VAR_SUPPORTED_DEVICE_FAMILIES)                                 : @[ @"1,2" ],
                @(PBX_VAR_SUPPORTED_PLATFORMS)                                       : @[ toNull(blk(PBX_VAR_PLATFORM_NAME)) ],
                @(PBX_VAR_SYMROOT)                                                   : PGFormat(@"%@", toNull(blk(PBX_VAR_BUILD_ROOT))),
                @(PBX_VAR_SYSTEM_ADMIN_APPS_DIR)                                     : PGFormat(@"%@/Utilities", osAppDir),
                @(PBX_VAR_SYSTEM_APPS_DIR)                                           : PGFormat(@"%@", osAppDir),
                @(PBX_VAR_SYSTEM_CORE_SERVICES_DIR)                                  : PGFormat(@"%@/CoreServices", osSysLibDir),
                @(PBX_VAR_SYSTEM_DEMOS_DIR)                                          : PGFormat(@"%@/Extras", osAppDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_APPS_DIR)                                 : PGFormat(@"%@/Applications", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_BIN_DIR)                                  : PGFormat(@"%@/usr/bin", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_DEMOS_DIR)                                : PGFormat(@"%@/Applications/Utilities/Built Examples", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_DIR)                                      : PGFormat(@"%@/Xcode.app/Contents/Developer", osAppDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_DOC_DIR)                                  : PGFormat(@"%@/ADC Reference Library", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_GRAPHICS_TOOLS_DIR)                       : PGFormat(@"%@/Applications/Graphics Tools", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_JAVA_TOOLS_DIR)                           : PGFormat(@"%@/Applications/Java Tools", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_PERFORMANCE_TOOLS_DIR)                    : PGFormat(@"%@/Applications/Performance Tools", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_RELEASENOTES_DIR)                         : PGFormat(@"%@/ADC Reference Library/releasenotes", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_TOOLS)                                    : @[ PGFormat(@"%@/Tools", xcodeDir) ],
                @(PBX_VAR_SYSTEM_DEVELOPER_TOOLS_DOC_DIR)                            : PGFormat(@"%@/ADC Reference Library/documentation/DeveloperTools", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_TOOLS_RELEASENOTES_DIR)                   : PGFormat(@"%@/ADC Reference Library/releasenotes/DeveloperTools", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_USR_DIR)                                  : PGFormat(@"%@/usr", xcodeDir),
                @(PBX_VAR_SYSTEM_DEVELOPER_UTILITIES_DIR)                            : PGFormat(@"%@/Applications/Utilities", xcodeDir),
                @(PBX_VAR_SYSTEM_DOCUMENTATION_DIR)                                  : PGFormat(@"%@/Documentation", osLibPath),
                @(PBX_VAR_SYSTEM_KEXT_INSTALL_PATH)                                  : PGFormat(@"%@/Extensions", osSysLibDir),
                @(PBX_VAR_SYSTEM_LIBRARY_DIR)                                        : PGFormat(@"%@", osSysLibDir),
                @(PBX_VAR_TARGETED_DEVICE_FAMILY)                                    : @(1),
                @(PBX_VAR_TARGETNAME)                                                : toNull(self.configurationList.target.name),
                @(PBX_VAR_TARGET_BUILD_DIR)                                          : PGFormat(@"%@", toNull(blk(PBX_VAR_BUILT_PRODUCTS_DIR))),
                @(PBX_VAR_TARGET_NAME)                                               : toNull(blk(PBX_VAR_TARGETNAME)),
                @(PBX_VAR_TARGET_TEMP_DIR)                                           : PGFormat(@"%@/%@-%@/%@.build",
                                                                                                toNull(blk(PBX_VAR_PROJECT_TEMP_DIR)),
                                                                                                self.name,
                                                                                                toNull(blk(PBX_VAR_PLATFORM_NAME)),
                                                                                                currTarget.name),
                @(PBX_VAR_TEMP_DIR)                                                  : toNull(blk(PBX_VAR_TARGET_TEMP_DIR)),
                @(PBX_VAR_TEMP_FILES_DIR)                                            : toNull(blk(PBX_VAR_TARGET_TEMP_DIR)),
                @(PBX_VAR_TEMP_FILE_DIR)                                             : toNull(blk(PBX_VAR_TARGET_TEMP_DIR)),
                @(PBX_VAR_TEMP_ROOT)                                                 : toNull(blk(PBX_VAR_PROJECT_TEMP_ROOT)),
                @(PBX_VAR_TOOLCHAINS)                                                : @[ @"com.apple.dt.toolchain.macos" ],
                @(PBX_VAR_UID)                                                       : @(NSProcessInfo.processInfo.userID),
                @(PBX_VAR_UNLOCALIZED_RESOURCES_FOLDER_PATH)                         : toNull(blk(PBX_VAR_FULL_PRODUCT_NAME)),
                @(PBX_VAR_UNSTRIPPED_PRODUCT)                                        : PGBool.boolNo,
                @(PBX_VAR_USER)                                                      : toNull(NSProcessInfo.processInfo.userName),
                @(PBX_VAR_USER_APPS_DIR)                                             : PGFormat(@"%@/Applications", homeDir),
                @(PBX_VAR_USER_LIBRARY_DIR)                                          : PGFormat(@"%@/Library", homeDir),
                @(PBX_VAR_USE_DYNAMIC_NO_PIC)                                        : PGBool.boolYes,
                @(PBX_VAR_USE_HEADERMAP)                                             : PGBool.boolYes,
                @(PBX_VAR_USE_HEADER_SYMLINKS)                                       : PGBool.boolNo,
                @(PBX_VAR_VALIDATE_PRODUCT)                                          : PGBool.boolNo,
                @(PBX_VAR_VALID_ARCHS)                                               : @[ toNull(blk(PBX_VAR_NATIVE_ARCH_32_BIT)), toNull(blk(PBX_VAR_NATIVE_ARCH_64_BIT)) ],
                @(PBX_VAR_VARIANT)                                                   : @"normal",
                @(PBX_VAR_VERBOSE_PBXCP)                                             : PGBool.boolNo,
                @(PBX_VAR_VERSIONPLIST_PATH)                                         : PGFormat(@"%@/version.plist", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_VERSION_INFO_BUILDER)                                      : toNull(blk(PBX_VAR_USER)),
                @(PBX_VAR_VERSION_INFO_FILE)                                         : PGFormat(@"%@_vers.c", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_VERSION_INFO_STRING)                                       : PGFormat(@"\"@(#)PROGRAM:%@  PROJECT:%@-\"",
                                                                                                toNull(blk(PBX_VAR_TARGETNAME)),
                                                                                                toNull(blk(PBX_VAR_PROJECT_NAME))),
                @(PBX_VAR_WRAPPER_EXTENSION)                                         : @"app",
                @(PBX_VAR_WRAPPER_NAME)                                              : toNull(blk(PBX_VAR_FULL_PRODUCT_NAME)),
                @(PBX_VAR_WRAPPER_SUFFIX)                                            : PGFormat(@".%@", toNull(blk(PBX_VAR_WRAPPER_EXTENSION))),
                @(PBX_VAR_XCODE_APP_SUPPORT_DIR)                                     : PGFormat(@"%@/Library/Xcode", xcodeDir),
                @(PBX_VAR_XCODE_PRODUCT_BUILD_VERSION)                               : @"5B130a",
                @(PBX_VAR_XCODE_VERSION_ACTUAL)                                      : @"0510",
                @(PBX_VAR_XCODE_VERSION_MAJOR)                                       : @"0500",
                @(PBX_VAR_XCODE_VERSION_MINOR)                                       : @"0510",
                @(PBX_VAR_XPCSERVICES_FOLDER_PATH)                                   : PGFormat(@"%@/XPCServices", toNull(blk(PBX_VAR_TARGETNAME))),
                @(PBX_VAR_YACC)                                                      : PGFindTool(@"yacc"),
            };
        });

        id data = _defaultsMap[@(varId)];
        return (data ? ([NSNull isNull:data] ? nil : ([PGBool isBool:data] ? [data description] : data)) : d2);
    }

    -(XCConfigurationList *)configurationList {
        return _configurationList;
    }

    -(void)setConfigurationList:(XCConfigurationList *)configurationList {
        _configurationList = configurationList;
    }


@end
