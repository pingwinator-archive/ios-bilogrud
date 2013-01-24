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
@property (strong, nonatomic) UIButton* cleanButton;
@property (strong, nonatomic) UIScrollView* horisontalScrollView;
@property (strong, nonatomic) NSMutableArray* viewsCollection;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.animationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.animationButton.frame = CGRectMake(100, 100, 120, 50);
    [self.animationButton setTitle:@"Animate!" forState:UIControlStateNormal];
    [self.view addSubview:self.animationButton];
    [self.animationButton addTarget:self action:@selector(showAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.cleanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cleanButton.frame = CGRectMake(100, 200, 120, 50);
    [self.cleanButton setTitle:@"Clean!" forState:UIControlStateNormal];
    [self.view addSubview:self.cleanButton];
    [self.cleanButton addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];

    
    self.viewsCollection = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(i*menuItemWidth + i * 15, 20, menuItemWidth , menuItemWidth)];
        testView.backgroundColor = [UIColor redColor];
        [self.viewsCollection addObject:testView];
    }
    
    self.horisontalScrollView = [self addHorisontalScrollView];
    [self.view addSubview:self.horisontalScrollView];
    
//    UIView* temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, menuItemWidth , menuItemWidth)];
//    temp.backgroundColor = [UIColor blackColor];
//    [self.horisontalScrollView addSubview: temp];

}

- (UIScrollView*)addHorisontalScrollView
{
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, 320, 100)];
    scrollView.backgroundColor = [UIColor yellowColor];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    scrollView.contentSize = CGSizeMake(1000 , 100);
    return scrollView;
}

- (void)clean
{
    [self.viewsCollection makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)showAnimation
{
      [self showView:0];
}

- (void)showView:(NSInteger)i
{
    if (i < 10) {
        NSLog(@"i %d", i);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frameTemp = [self nextView:i].frame;
            [self nextView:i].frame = CGRectMake(frameTemp.origin.x - 10, frameTemp.origin.y - 10, menuItemWidth + 20, menuItemWidth + 20);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [self.horisontalScrollView addSubview:[self nextView:i]];
                [self nextView:i].frame = CGRectMake(i*menuItemWidth + i * 5, 20, menuItemWidth , menuItemWidth);
            }
                             completion:^(BOOL finished) {
                                 [self showView:i+1];
                             }];
        }];
    }
}

- (UIView*)nextView:(NSInteger)i
{
    return  (i < [self.viewsCollection count]) ? [self.viewsCollection objectAtIndex:i] : nil;
}

@end
