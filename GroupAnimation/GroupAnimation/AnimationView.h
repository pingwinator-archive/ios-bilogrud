//
//  AnimationView.h
//  GroupAnimation
//
//  Created by Natasha on 18.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  AnimationViewDelegate <NSObject>

- (void)animationViewSelected;

@end

@interface AnimationView : UIButton

- (void)makeAnimationAndHide;

@property (assign, nonatomic) id<AnimationViewDelegate> delegate;

@end

