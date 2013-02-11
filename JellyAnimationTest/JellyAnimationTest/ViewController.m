//
//  ViewController.m
//  JellyAnimationTest
//
//  Created by Natasha on 08.02.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property(assign, nonatomic) BOOL showAnimation;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.showAnimation = YES;
    [self makeJellyAnimationFor:self.imageView andDelta:10];
}


- (void)makeJellyAnimationFor:(UIView*)view andDelta:(NSInteger)i
{
    CGRect rect = view.frame;
    __block NSInteger test = i;
    if (self.showAnimation) {
        if (i > 1) {
            if (test % 2) {
                test = - test;
            }
            [UIView animateWithDuration:0.2 animations:^{
                view.frame = CGRectMake(rect.origin.x - test, rect.origin.y, rect.size.width, rect.size.height);
            } completion:^(BOOL finished) {
                [self makeJellyAnimationFor:view andDelta:i - 1];
            }];
        } else {
            self.showAnimation = NO;
        }
    }
}
@end
