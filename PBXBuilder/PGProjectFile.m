/************************************************************************//**
 *     PROJECT: PBXBuilder
 *    FILENAME: PGProjectFile.m
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

#import "PGProjectFile.h"
#import "PBXItem.h"
#import "PBXProject.h"
#import "Tools.h"
#import "PBXBuildPhase.h"
#import "PBXTarget.h"

@implementation PGProjectFile {
    }

    @synthesize projectName = _projectName;
    @synthesize projectPath = _projectPath;
    @synthesize projectPBX = _projectPBX;
    @synthesize pbxItemCache = _pbxItemCache;
    @synthesize pbxFormat = _pbxFormat;
    @synthesize project = _project;

    -(instancetype)initWithProjectName:(NSString *)projectName projectPath:(NSString *)projectPath error:(NSError **)error {
        self = [super init];

        if(self) {
            _projectName  = [projectName copy];
            _projectPath  = [projectPath copy];
            _pbxItemCache = [NSMutableDictionary new];

            NSString      *pbxPath   = [NSString stringWithFormat:@"%@/%@.xcodeproj/project.pbxproj", _projectName, _projectPath];
            NSInputStream *pbxStream = [NSInputStream inputStreamWithFileAtPath:pbxPath];

            [pbxStream open];
            while(pbxStream.streamStatus == NSStreamStatusOpening);
            if(pbxStream.streamStatus == NSStreamStatusError) {
                if(error) *error = pbxStream.streamError;
                return nil;
            }

            NSDictionary *pbx = [NSPropertyListSerialization propertyListWithStream:pbxStream options:NSPropertyListImmutable format:&_pbxFormat error:error];

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

@end
