//
//  AnimationView.m
//  GroupAnimation
//
//  Created by Natasha on 18.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "AnimationView.h"
#import <QuartzCore/QuartzCore.h>
@implementation AnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(makeAnimationAndHide) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)makeAnimationAndHide
{
    // blowup the selected menu button
    NSLog(@"makeAnimationAndHide");
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.alpha = 0;
//        self.transform = CGAffineTransformMakeScale(3, 3);
//    } completion:^(BOOL finished) {
//        if ([self.delegate respondsToSelector:@selector(animationViewSelected)]) {
//            [self.delegate animationViewSelected];
//        }
//        self.alpha = 1;
//    }];
    
    [self initialDelayEnded];
//    CAAnimationGroup *blowup = [self _blowupAnimationAtPoint:self.center];
//    [self.layer addAnimation:blowup forKey:@"blowup"];

}

- (CAAnimationGroup *)_blowupAnimationAtPoint:(CGPoint)p
{    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(3, 3, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.delegate = self;
    animationgroup.animations = [NSArray arrayWithObjects:scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.3f;
    animationgroup.fillMode = kCAFillModeForwards;
    return animationgroup;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
    if ([self.delegate respondsToSelector:@selector(animationViewSelected)]) {
        [self.delegate animationViewSelected];
    }
}


-(void)initialDelayEnded {
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    self.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
}

- (void)bounce1AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];//kTransitionDuration/2
    self.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}


@end
