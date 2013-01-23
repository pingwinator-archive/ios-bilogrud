//
//  ViewController.m
//  AnimationView
//
//  Created by Natasha on 23.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"

#define menuItemWidth 40

@interface ViewController ()
@property (strong, nonatomic) UIButton* animationButton;
@property (strong, nonatomic) UIScrollView* horisontalScrollView;
@property (strong, nonatomic) UIView* bgView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.animationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.animationButton.frame = CGRectMake(100, 100, 120, 50);
    [self.animationButton setTitle:@"Animate!" forState:UIControlStateNormal];
    [self.view addSubview:self.animationButton];
    [self.animationButton addTarget:self action:@selector(showAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, 320, 100)];
    self.bgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.bgView];
//    [self.view addSubview:[self addHorisontalScrollView]];
    
//    for (NSInteger i = 0; i < 10; i++) {
//        
//        UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(i*menuItemWidth+i*5, 200, menuItemWidth , menuItemWidth)];
//        testView.backgroundColor = [UIColor redColor];
//        [self.view addSubview:testView];
//        
//        [UIView animateWithDuration:1 animations:^{
//            testView.center = CGPointMake(100, 300);
//        } completion:^ (BOOL finished) {
//             if (finished) {
//                 // Revert image view to original.
//                 NSLog(@"Is completed");
//                 testView.center = CGPointMake(i*menuItemWidth+i*5, 200);
//        }
//         }];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIScrollView*)addHorisontalScrollView
{
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, 320, 100)];
    scrollView.backgroundColor = [UIColor yellowColor];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    scrollView.contentSize = CGSizeMake(1000 , 100);
    return scrollView;
}

- (void)showAnimation
{
    [self.bgView removeFromSuperview];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 320, 100)];
    self.bgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.bgView];
    for (NSInteger i = 0; i < 10; i++) {
      
        UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(i*menuItemWidth+i*15, 20, menuItemWidth , menuItemWidth)];
        testView.backgroundColor = [UIColor redColor];
        
        [UIView animateWithDuration:0.2 animations:^{
            testView.frame = CGRectMake(testView.frame.origin.x-5, testView.frame.origin.y-5, menuItemWidth+10, menuItemWidth+10);
        } completion:^ (BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                testView.frame = CGRectMake(i*menuItemWidth+i*5, 20, menuItemWidth , menuItemWidth);
                             }];
        }];
        
        [self.bgView addSubview:testView];
 }

}


@end
