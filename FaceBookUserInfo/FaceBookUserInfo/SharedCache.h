//
//  SharedCache.h
//  FaceBookUserInfo
//
//  Created by Natasha on 07.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedCache : NSCache// NSObject
+(SharedCache *)sharedInstance;
@end
