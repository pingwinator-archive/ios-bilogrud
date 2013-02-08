//
//  ViewController.m
//  JellyAnimationTest
//
//  Created by Natasha on 08.02.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self makeJellyAnimationFor:self.imageView];
}

- (void)makeJellyAnimationFor:(UIView*)view
{
    NSInteger i = 10;
    CGRect rect = view.frame;
    
    while (i > 1) {
        [UIView animateWithDuration:2 animations:^{
            view.frame = CGRectMake(rect.origin.x - i, rect.origin.y, rect.size.width, rect.size.height);
        } completion:^(BOOL finished) {
            view.frame = CGRectMake(rect.origin.x + 2*i, rect.origin.y, rect.size.width, rect.size.height);
        }];
        i--;
    }
   
}

@end
