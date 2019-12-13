/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PBXProjectFile.m
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

#import <Moscow/Moscow.h>
#import <PBX/PBX.h>

@implementation PBXProjectFile {
    }

    @synthesize projectName = _projectName;
    @synthesize projectPath = _projectPath;
    @synthesize projectPBX = _projectPBX;
    @synthesize pbxItemCache = _pbxItemCache;
    @synthesize pbxFormat = _pbxFormat;
    @synthesize project = _project;

    -(instancetype)initWithName:(NSString *)projectName path:(NSString *)projectPath error:(NSError **)error {
        self = [super init];

        if(self) {
            _projectName  = [projectName copy];
            _projectPath  = [projectPath copy];
            _pbxItemCache = [NSMutableDictionary new];

            NSString *pbxPath = [NSString stringWithFormat:@"%@/%@.xcodeproj/project.pbxproj", _projectPath, _projectName];
#ifdef DEBUG
            PGPrintf(@"Loading Project: \"%@\"\n", pbxPath);
#endif
            NSData *pbxData = [NSData dataWithContentsOfFile:pbxPath options:NSDataReadingMappedIfSafe error:error];
            if(pbxData == nil) return nil;

            NSDictionary *pbx = [NSPropertyListSerialization propertyListWithData:pbxData options:NSPropertyListImmutable format:&_pbxFormat error:error];
            if(pbx == nil) return nil;

            _projectPBX = pbx[@"objects"];
            _project    = [self itemForID:pbx[@"rootObject"]];
        }

        return self;
    }

    -(id)itemForID:(NSString *)itemId {
        if(itemId) {
            @synchronized(self.pbxItemCache) {
                PBXItem *item = self.pbxItemCache[itemId];

                if(!item) {
                    NSString *className = ((NSDictionary *)self.projectPBX[itemId])[@"isa"];
                    Class    pbxClass   = NSClassFromString(className);

                    if(pbxClass == nil) {
                        /*
                         * Look to see if this is simply an unknown version of an existing subclass...
                         */
                        if([className matches:@"PBX\\w+?BuildPhase"]) pbxClass = [PBXBuildPhase class];
                        else if([className matches:@"PBX\\w+?Target"]) pbxClass = [PBXTarget class];
                        else pbxClass = [PBXItem class];
                    }

                    item = [((PBXItem *)[pbxClass alloc]) initWithItemId:itemId projectFile:self];
                    if(item) ((NSMutableDictionary *)self.pbxItemCache)[itemId] = item;
                }

                return item;
            }
        }

        return nil;
    }

    +(instancetype)projectFileWithName:(NSString *)projectName path:(NSString *)projectPath error:(NSError **)error {
        return [[self alloc] initWithName:projectName path:projectPath error:error];
    }

@end
