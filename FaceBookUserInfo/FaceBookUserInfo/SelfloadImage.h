//
//  SelfloadImage.h
//  FaceBookUserInfo
//
//  Created by Natasha on 06.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connect.h"
#import "SharedCache.h"
#import "UIImage+RoundedCorner.h"
@interface SelfloadImage : UIImageView
-(void)loadImage: (NSURL *)url cashImages: (NSCache*)cache;
-(void)loadImage: (NSURL *)url;
@property (retain, nonatomic ) SharedCache* cache;
@end

