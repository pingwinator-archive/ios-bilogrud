//
//  SharedCache.m
//  FaceBookUserInfo
//
//  Created by Natasha on 07.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SharedCache.h"

@interface SharedCache()
- (id)initCache;
@end

@implementation SharedCache
-(id)initCache{
    if ((self = [super init]))
    {
    }
    return self;
}

+(id)sharedInstance
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}
@end
