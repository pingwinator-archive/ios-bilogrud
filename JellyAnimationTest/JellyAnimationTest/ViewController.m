//
//  ViewController.m
//  JellyAnimationTest
//
//  Created by Natasha on 08.02.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#define NSLogR(rect) NSLog(@"%@", NSStringFromCGRect(rect))



@interface ViewController ()
@property(assign, nonatomic) BOOL showAnimation;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.imageView.transform = CGAffineTransformMakeRotation(0);
    [self makeJellyAnimationFor:self.imageView andDelta:2];
}


- (void)makeJellyAnimationFor:(UIView*)view andDelta:(NSInteger)i
{
    CGAffineTransform t = view.transform;
    __block NSInteger test = i;
    if (i > 1) {
        [UIView animateWithDuration:0.4 animations:^{
            //            view.transform = CGAffineTransformMakeRotation(- test * M_PI_4/30);
            view.transform = CGAffineTransformMakeRotation(- M_PI_4);
            NSLogR(view.frame);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.8 animations:^{
                view.transform = CGAffineTransformMakeRotation(M_PI_2);
                NSLogR(view.frame);
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 animations:^{
                    view.transform = CGAffineTransformMakeRotation(- M_PI_4);
                    NSLogR(view.frame);
                }completion:^(BOOL finished){
                    NSLog(@"%d  test", test);
                    [self makeJellyAnimationFor:view andDelta:i - 2];
                }];
            }];
        }];
    }



    
    //
//    CGRect rect = view.frame;
//    NSLogR(rect);
//    __block NSInteger test = i;
//    if (i > 1) {
//        if (test % 2) {
//            test = - test;
//        }
//        [UIView animateWithDuration:0.5 animations:^{
//            NSLog(@"angle : %f", -i * M_PI_4/100);
//            view.transform = CGAffineTransformMakeRotation(-test * M_PI_4/10);
//        } completion:^(BOOL finished) {
//            [self makeJellyAnimationFor:view andDelta:i-1];
//        }];
//    }
}
@end
