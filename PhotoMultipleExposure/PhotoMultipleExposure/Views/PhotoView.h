//
//  PhotoView.h
//  PhotoMultipleExposure
//
//  Created by Natasha on 14.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView
@property (retain, nonatomic) UIImageView* firstLayerImageView;
@property (retain, nonatomic) UIImageView* secondLayerImageView;
- (void)reset;
- (void)defPhoto;
@end
