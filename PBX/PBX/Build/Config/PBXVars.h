/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXVars.h
 *         IDE: AppCode
 *      AUTHOR: Galen Rhodes
 *        DATE: 1/5/20
 *
 * Copyright © 2020 Project Galen. All rights reserved.
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

#ifndef __PBXBUILDER_PBXVARS_H__
#define __PBXBUILDER_PBXVARS_H__

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBXVars : NSObject

    @property(class, readonly) NSDictionary<NSNumber *, NSString *> *variableNameMap;
    @property(class, readonly) NSDictionary<NSString *, NSNumber *> *nameVariableMap;

@end

typedef NS_ENUM(NSUInteger, PBXVariable) {
    PBX_VAR_NIL = 0,
    PBX_VAR_ACTION,
    PBX_VAR_AD_HOC_CODE_SIGNING_ALLOWED,
    PBX_VAR_ALTERNATE_GROUP,
    PBX_VAR_ALTERNATE_MODE,
    PBX_VAR_ALTERNATE_OWNER,
    PBX_VAR_ALWAYS_SEARCH_USER_PATHS,
    PBX_VAR_ALWAYS_USE_SEPARATE_HEADERMAPS,
    PBX_VAR_APPLE_INTERNAL_DEVELOPER_DIR,
    PBX_VAR_APPLE_INTERNAL_DIR,
    PBX_VAR_APPLE_INTERNAL_DOCUMENTATION_DIR,
    PBX_VAR_APPLE_INTERNAL_LIBRARY_DIR,
    PBX_VAR_APPLE_INTERNAL_TOOLS,
    PBX_VAR_APPLY_RULES_IN_COPY_FILES,
    PBX_VAR_ARCHS,
    PBX_VAR_ARCHS_STANDARD,
    PBX_VAR_ARCHS_STANDARD_32_64_BIT,
    PBX_VAR_ARCHS_STANDARD_32_BIT,
    PBX_VAR_ARCHS_STANDARD_64_BIT,
    PBX_VAR_ARCHS_STANDARD_INCLUDING_64_BIT,
    PBX_VAR_ARCHS_UNIVERSAL_IPHONE_OS,
    PBX_VAR_ASSETCATALOG_COMPILER_APPICON_NAME,
    PBX_VAR_ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME,
    PBX_VAR_AVAILABLE_PLATFORMS,
    PBX_VAR_BUILD_COMPONENTS,
    PBX_VAR_BUILD_DIR,
    PBX_VAR_BUILD_ROOT,
    PBX_VAR_BUILD_STYLE,
    PBX_VAR_BUILD_VARIANTS,
    PBX_VAR_BUILT_PRODUCTS_DIR,
    PBX_VAR_CACHE_ROOT,
    PBX_VAR_CCHROOT,
    PBX_VAR_CHMOD,
    PBX_VAR_CHOWN,
    PBX_VAR_CLANG_ENABLE_OBJC_ARC,
    PBX_VAR_CLANG_WARN_CONSTANT_CONVERSION,
    PBX_VAR_CLANG_WARN_ENUM_CONVERSION,
    PBX_VAR_CLANG_WARN_INT_CONVERSION,
    PBX_VAR_CLANG_WARN__DUPLICATE_METHOD_MATCH,
    PBX_VAR_CLASS_FILE_DIR,
    PBX_VAR_CLEAN_PRECOMPS,
    PBX_VAR_CLONE_HEADERS,
    PBX_VAR_CODESIGNING_FOLDER_PATH,
    PBX_VAR_CODE_SIGNING_ALLOWED,
    PBX_VAR_CODE_SIGNING_REQUIRED,
    PBX_VAR_CODE_SIGN_CONTEXT_CLASS,
    PBX_VAR_CODE_SIGN_IDENTITY,
    PBX_VAR_COLOR_DIAGNOSTICS,
    PBX_VAR_COMBINE_HIDPI_IMAGES,
    PBX_VAR_COMPOSITE_SDK_DIRS,
    PBX_VAR_COMPRESS_PNG_FILES,
    PBX_VAR_CONFIGURATION,
    PBX_VAR_CONFIGURATION_BUILD_DIR,
    PBX_VAR_CONFIGURATION_TEMP_DIR,
    PBX_VAR_CONTENTS_FOLDER_PATH,
    PBX_VAR_COPYING_PRESERVES_HFS_DATA,
    PBX_VAR_COPY_PHASE_STRIP,
    PBX_VAR_COPY_RESOURCES_FROM_STATIC_FRAMEWORKS,
    PBX_VAR_CP,
    PBX_VAR_CREATE_INFOPLIST_SECTION_IN_BINARY,
    PBX_VAR_CURRENT_ARCH,
    PBX_VAR_CURRENT_VARIANT,
    PBX_VAR_DEAD_CODE_STRIPPING,
    PBX_VAR_DEBUGGING_SYMBOLS,
    PBX_VAR_DEBUG_INFORMATION_FORMAT,
    PBX_VAR_DEFAULT_COMPILER,
    PBX_VAR_DEFAULT_KEXT_INSTALL_PATH,
    PBX_VAR_DEPLOYMENT_LOCATION,
    PBX_VAR_DEPLOYMENT_POSTPROCESSING,
    PBX_VAR_DERIVED_FILES_DIR,
    PBX_VAR_DERIVED_FILE_DIR,
    PBX_VAR_DERIVED_SOURCES_DIR,
    PBX_VAR_DEVELOPER_APPLICATIONS_DIR,
    PBX_VAR_DEVELOPER_BIN_DIR,
    PBX_VAR_DEVELOPER_DIR,
    PBX_VAR_DEVELOPER_FRAMEWORKS_DIR,
    PBX_VAR_DEVELOPER_FRAMEWORKS_DIR_QUOTED,
    PBX_VAR_DEVELOPER_LIBRARY_DIR,
    PBX_VAR_DEVELOPER_SDK_DIR,
    PBX_VAR_DEVELOPER_TOOLS_DIR,
    PBX_VAR_DEVELOPER_USR_DIR,
    PBX_VAR_DEVELOPMENT_LANGUAGE,
    PBX_VAR_DOCUMENTATION_FOLDER_PATH,
    PBX_VAR_DO_HEADER_SCANNING_IN_JAM,
    PBX_VAR_DSTROOT,
    PBX_VAR_DT_TOOLCHAIN_DIR,
    PBX_VAR_DWARF_DSYM_FILE_NAME,
    PBX_VAR_DWARF_DSYM_FILE_SHOULD_ACCOMPANY_PRODUCT,
    PBX_VAR_DWARF_DSYM_FOLDER_PATH,
    PBX_VAR_EFFECTIVE_PLATFORM_NAME,
    PBX_VAR_EMBEDDED_PROFILE_NAME,
    PBX_VAR_ENABLE_HEADER_DEPENDENCIES,
    PBX_VAR_ENTITLEMENTS_ALLOWED,
    PBX_VAR_ENTITLEMENTS_REQUIRED,
    PBX_VAR_EXCLUDED_INSTALLSRC_SUBDIRECTORY_PATTERNS,
    PBX_VAR_EXCLUDED_RECURSIVE_SEARCH_PATH_SUBDIRECTORIES,
    PBX_VAR_EXECUTABLES_FOLDER_PATH,
    PBX_VAR_EXECUTABLE_FOLDER_PATH,
    PBX_VAR_EXECUTABLE_NAME,
    PBX_VAR_EXECUTABLE_PATH,
    PBX_VAR_FILE_LIST,
    PBX_VAR_FIXED_FILES_DIR,
    PBX_VAR_FRAMEWORKS_FOLDER_PATH,
    PBX_VAR_FRAMEWORK_FLAG_PREFIX,
    PBX_VAR_FRAMEWORK_SEARCH_PATHS,
    PBX_VAR_FRAMEWORK_VERSION,
    PBX_VAR_FULL_PRODUCT_NAME,
    PBX_VAR_GCC3_VERSION,
    PBX_VAR_GCC_C_LANGUAGE_STANDARD,
    PBX_VAR_GCC_INLINES_ARE_PRIVATE_EXTERN,
    PBX_VAR_GCC_PFE_FILE_C_DIALECTS,
    PBX_VAR_GCC_PRECOMPILE_PREFIX_HEADER,
    PBX_VAR_GCC_PREFIX_HEADER,
    PBX_VAR_GCC_PREPROCESSOR_DEFINITIONS,
    PBX_VAR_GCC_SYMBOLS_PRIVATE_EXTERN,
    PBX_VAR_GCC_THUMB_SUPPORT,
    PBX_VAR_GCC_TREAT_WARNINGS_AS_ERRORS,
    PBX_VAR_GCC_VERSION,
    PBX_VAR_GCC_VERSION_IDENTIFIER,
    PBX_VAR_GCC_WARN_ABOUT_RETURN_TYPE,
    PBX_VAR_GCC_WARN_UNINITIALIZED_AUTOS,
    PBX_VAR_GCC_WARN_UNUSED_VARIABLE,
    PBX_VAR_GENERATE_MASTER_OBJECT_FILE,
    PBX_VAR_GENERATE_PKGINFO_FILE,
    PBX_VAR_GENERATE_PROFILING_CODE,
    PBX_VAR_GID,
    PBX_VAR_GROUP,
    PBX_VAR_HEADERMAP_INCLUDES_FLAT_ENTRIES_FOR_TARGET_BEING_BUILT,
    PBX_VAR_HEADERMAP_INCLUDES_FRAMEWORK_ENTRIES_FOR_ALL_PRODUCT_TYPES,
    PBX_VAR_HEADERMAP_INCLUDES_NONPUBLIC_NONPRIVATE_HEADERS,
    PBX_VAR_HEADERMAP_INCLUDES_PROJECT_HEADERS,
    PBX_VAR_HEADER_SEARCH_PATHS,
    PBX_VAR_ICONV,
    PBX_VAR_INFOPLIST_EXPAND_BUILD_SETTINGS,
    PBX_VAR_INFOPLIST_FILE,
    PBX_VAR_INFOPLIST_OUTPUT_FORMAT,
    PBX_VAR_INFOPLIST_PATH,
    PBX_VAR_INFOPLIST_PREPROCESS,
    PBX_VAR_INFOSTRINGS_PATH,
    PBX_VAR_INSTALL_DIR,
    PBX_VAR_INSTALL_GROUP,
    PBX_VAR_INSTALL_MODE_FLAG,
    PBX_VAR_INSTALL_OWNER,
    PBX_VAR_INSTALL_PATH,
    PBX_VAR_INSTALL_ROOT,
    PBX_VAR_IPHONEOS_DEPLOYMENT_TARGET,
    PBX_VAR_JAVAC_DEFAULT_FLAGS,
    PBX_VAR_JAVA_APP_STUB,
    PBX_VAR_JAVA_ARCHIVE_CLASSES,
    PBX_VAR_JAVA_ARCHIVE_TYPE,
    PBX_VAR_JAVA_COMPILER,
    PBX_VAR_JAVA_FOLDER_PATH,
    PBX_VAR_JAVA_FRAMEWORK_RESOURCES_DIRS,
    PBX_VAR_JAVA_JAR_FLAGS,
    PBX_VAR_JAVA_SOURCE_SUBDIR,
    PBX_VAR_JAVA_USE_DEPENDENCIES,
    PBX_VAR_JAVA_ZIP_FLAGS,
    PBX_VAR_JIKES_DEFAULT_FLAGS,
    PBX_VAR_KEEP_PRIVATE_EXTERNS,
    PBX_VAR_LD_DEPENDENCY_INFO_FILE,
    PBX_VAR_LD_GENERATE_MAP_FILE,
    PBX_VAR_LD_MAP_FILE_PATH,
    PBX_VAR_LD_NO_PIE,
    PBX_VAR_LD_QUOTE_LINKER_ARGUMENTS_FOR_COMPILER_DRIVER,
    PBX_VAR_LEGACY_DEVELOPER_DIR,
    PBX_VAR_LEX,
    PBX_VAR_LIBRARY_FLAG_NOSPACE,
    PBX_VAR_LIBRARY_FLAG_PREFIX,
    PBX_VAR_LIBRARY_KEXT_INSTALL_PATH,
    PBX_VAR_LIBRARY_SEARCH_PATHS,
    PBX_VAR_LINKER_DISPLAYS_MANGLED_NAMES,
    PBX_VAR_LINK_FILE_LIST_NORMAL_ARMV7,
    PBX_VAR_LINK_FILE_LIST_NORMAL_ARMV7S,
    PBX_VAR_LINK_WITH_STANDARD_LIBRARIES,
    PBX_VAR_LOCALIZED_RESOURCES_FOLDER_PATH,
    PBX_VAR_LOCAL_ADMIN_APPS_DIR,
    PBX_VAR_LOCAL_APPS_DIR,
    PBX_VAR_LOCAL_DEVELOPER_DIR,
    PBX_VAR_LOCAL_LIBRARY_DIR,
    PBX_VAR_MACH_O_TYPE,
    PBX_VAR_MAC_OS_X_PRODUCT_BUILD_VERSION,
    PBX_VAR_MAC_OS_X_VERSION_ACTUAL,
    PBX_VAR_MAC_OS_X_VERSION_MAJOR,
    PBX_VAR_MAC_OS_X_VERSION_MINOR,
    PBX_VAR_MODULE_CACHE_DIR,
    PBX_VAR_NATIVE_ARCH,
    PBX_VAR_NATIVE_ARCH_32_BIT,
    PBX_VAR_NATIVE_ARCH_64_BIT,
    PBX_VAR_NATIVE_ARCH_ACTUAL,
    PBX_VAR_NO_COMMON,
    PBX_VAR_OBJECT_FILE_DIR,
    PBX_VAR_OBJECT_FILE_DIR_NORMAL,
    PBX_VAR_OBJROOT,
    PBX_VAR_ONLY_ACTIVE_ARCH,
    PBX_VAR_OPTIMIZATION_LEVEL,
    PBX_VAR_OS,
    PBX_VAR_OSAC,
    PBX_VAR_OTHER_CFLAGS,
    PBX_VAR_OTHER_CPLUSPLUSFLAGS,
    PBX_VAR_OTHER_LDFLAGS,
    PBX_VAR_PACKAGE_TYPE,
    PBX_VAR_PASCAL_STRINGS,
    PBX_VAR_PATH,
    PBX_VAR_PATH_PREFIXES_EXCLUDED_FROM_HEADER_DEPENDENCIES,
    PBX_VAR_PBDEVELOPMENTPLIST_PATH,
    PBX_VAR_PFE_FILE_C_DIALECTS,
    PBX_VAR_PKGINFO_FILE_PATH,
    PBX_VAR_PKGINFO_PATH,
    PBX_VAR_PLATFORM_DEVELOPER_APPLICATIONS_DIR,
    PBX_VAR_PLATFORM_DEVELOPER_BIN_DIR,
    PBX_VAR_PLATFORM_DEVELOPER_LIBRARY_DIR,
    PBX_VAR_PLATFORM_DEVELOPER_SDK_DIR,
    PBX_VAR_PLATFORM_DEVELOPER_TOOLS_DIR,
    PBX_VAR_PLATFORM_DEVELOPER_USR_DIR,
    PBX_VAR_PLATFORM_DIR,
    PBX_VAR_PLATFORM_NAME,
    PBX_VAR_PLATFORM_PREFERRED_ARCH,
    PBX_VAR_PLATFORM_PRODUCT_BUILD_VERSION,
    PBX_VAR_PLIST_FILE_OUTPUT_FORMAT,
    PBX_VAR_PLUGINS_FOLDER_PATH,
    PBX_VAR_PRECOMPS_INCLUDE_HEADERS_FROM_BUILT_PRODUCTS_DIR,
    PBX_VAR_PRECOMP_DESTINATION_DIR,
    PBX_VAR_PRESERVE_DEAD_CODE_INITS_AND_TERMS,
    PBX_VAR_PRIVATE_HEADERS_FOLDER_PATH,
    PBX_VAR_PRODUCT_NAME,
    PBX_VAR_PRODUCT_SETTINGS_PATH,
    PBX_VAR_PRODUCT_TYPE,
    PBX_VAR_PROFILING_CODE,
    PBX_VAR_PROJECT,
    PBX_VAR_PROJECT_DERIVED_FILE_DIR,
    PBX_VAR_PROJECT_DIR,
    PBX_VAR_PROJECT_FILE_PATH,
    PBX_VAR_PROJECT_NAME,
    PBX_VAR_PROJECT_TEMP_DIR,
    PBX_VAR_PROJECT_TEMP_ROOT,
    PBX_VAR_PROVISIONING_PROFILE_REQUIRED,
    PBX_VAR_PUBLIC_HEADERS_FOLDER_PATH,
    PBX_VAR_RECURSIVE_SEARCH_PATHS_FOLLOW_SYMLINKS,
    PBX_VAR_REMOVE_CVS_FROM_RESOURCES,
    PBX_VAR_REMOVE_GIT_FROM_RESOURCES,
    PBX_VAR_REMOVE_HG_FROM_RESOURCES,
    PBX_VAR_REMOVE_SVN_FROM_RESOURCES,
    PBX_VAR_RESOURCE_RULES_REQUIRED,
    PBX_VAR_REZ_COLLECTOR_DIR,
    PBX_VAR_REZ_OBJECTS_DIR,
    PBX_VAR_SCAN_ALL_SOURCE_FILES_FOR_INCLUDES,
    PBX_VAR_SCRIPTS_FOLDER_PATH,
    PBX_VAR_SDKROOT,
    PBX_VAR_SDK_DIR,
    PBX_VAR_SDK_NAME,
    PBX_VAR_SDK_PRODUCT_BUILD_VERSION,
    PBX_VAR_SED,
    PBX_VAR_SEPARATE_STRIP,
    PBX_VAR_SEPARATE_SYMBOL_EDIT,
    PBX_VAR_SET_DIR_MODE_OWNER_GROUP,
    PBX_VAR_SET_FILE_MODE_OWNER_GROUP,
    PBX_VAR_SHALLOW_BUNDLE,
    PBX_VAR_SHARED_DERIVED_FILE_DIR,
    PBX_VAR_SHARED_FRAMEWORKS_FOLDER_PATH,
    PBX_VAR_SHARED_PRECOMPS_DIR,
    PBX_VAR_SHARED_SUPPORT_FOLDER_PATH,
    PBX_VAR_SKIP_INSTALL,
    PBX_VAR_SOURCE_ROOT,
    PBX_VAR_SRCROOT,
    PBX_VAR_STRINGS_FILE_OUTPUT_ENCODING,
    PBX_VAR_STRIP_INSTALLED_PRODUCT,
    PBX_VAR_STRIP_STYLE,
    PBX_VAR_SUPPORTED_DEVICE_FAMILIES,
    PBX_VAR_SUPPORTED_PLATFORMS,
    PBX_VAR_SYMROOT,
    PBX_VAR_SYSTEM_ADMIN_APPS_DIR,
    PBX_VAR_SYSTEM_APPS_DIR,
    PBX_VAR_SYSTEM_CORE_SERVICES_DIR,
    PBX_VAR_SYSTEM_DEMOS_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_APPS_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_BIN_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_DEMOS_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_DOC_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_GRAPHICS_TOOLS_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_JAVA_TOOLS_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_PERFORMANCE_TOOLS_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_RELEASENOTES_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_TOOLS,
    PBX_VAR_SYSTEM_DEVELOPER_TOOLS_DOC_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_TOOLS_RELEASENOTES_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_USR_DIR,
    PBX_VAR_SYSTEM_DEVELOPER_UTILITIES_DIR,
    PBX_VAR_SYSTEM_DOCUMENTATION_DIR,
    PBX_VAR_SYSTEM_KEXT_INSTALL_PATH,
    PBX_VAR_SYSTEM_LIBRARY_DIR,
    PBX_VAR_TARGETED_DEVICE_FAMILY,
    PBX_VAR_TARGETNAME,
    PBX_VAR_TARGET_BUILD_DIR,
    PBX_VAR_TARGET_NAME,
    PBX_VAR_TARGET_NAME_C99_EXT_IDENTIFIER,
    PBX_VAR_TARGET_TEMP_DIR,
    PBX_VAR_TEMP_DIR,
    PBX_VAR_TEMP_FILES_DIR,
    PBX_VAR_TEMP_FILE_DIR,
    PBX_VAR_TEMP_ROOT,
    PBX_VAR_TOOLCHAINS,
    PBX_VAR_UID,
    PBX_VAR_UNLOCALIZED_RESOURCES_FOLDER_PATH,
    PBX_VAR_UNSTRIPPED_PRODUCT,
    PBX_VAR_USER,
    PBX_VAR_USER_APPS_DIR,
    PBX_VAR_USER_LIBRARY_DIR,
    PBX_VAR_USE_DYNAMIC_NO_PIC,
    PBX_VAR_USE_HEADERMAP,
    PBX_VAR_USE_HEADER_SYMLINKS,
    PBX_VAR_VALIDATE_PRODUCT,
    PBX_VAR_VALID_ARCHS,
    PBX_VAR_VERBOSE_PBXCP,
    PBX_VAR_VERSIONPLIST_PATH,
    PBX_VAR_VERSION_INFO_BUILDER,
    PBX_VAR_VERSION_INFO_FILE,
    PBX_VAR_VERSION_INFO_STRING,
    PBX_VAR_WRAPPER_EXTENSION,
    PBX_VAR_WRAPPER_NAME,
    PBX_VAR_WRAPPER_SUFFIX,
    PBX_VAR_XCODE_APP_SUPPORT_DIR,
    PBX_VAR_XCODE_PRODUCT_BUILD_VERSION,
    PBX_VAR_XCODE_VERSION_ACTUAL,
    PBX_VAR_XCODE_VERSION_MAJOR,
    PBX_VAR_XCODE_VERSION_MINOR,
    PBX_VAR_XPCSERVICES_FOLDER_PATH,
    PBX_VAR_YACC,
    PBX_VAR_ARCH,
    PBX_VAR_DIAGNOSTIC_MESSAGE_LENGTH,
    PBX_VAR_VARIANT,
};

NS_ASSUME_NONNULL_END

#endif // __PBXBUILDER_PBXVARS_H__
