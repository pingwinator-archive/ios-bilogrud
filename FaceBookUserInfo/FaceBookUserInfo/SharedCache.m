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

+(SharedCache *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static SharedCache * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] initCache]; // or some other init method
    });
    return _sharedObject;
}
@end
