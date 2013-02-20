//
//  ViewController.m
//  CustomActivityApp
//
//  Created by Natasha on 13.02.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#define activitySide 50
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startImageViewAnimation];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startImageViewAnimation
{
    NSMutableArray *animationImages = [NSMutableArray array];
    for (NSUInteger i = 0; i < 12; i++) {
        [animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"shape_%d.png", i + 1]]];
    }
   
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - activitySide/2, self.view.frame.size.height/2 - activitySide/2, activitySide, activitySide)];
    [self.imageView setBackgroundColor:[UIColor whiteColor]];
    self.imageView.animationImages = animationImages;
    self.imageView.animationRepeatCount = 0;
    self.imageView.animationDuration= 1.2;
   
    [self.view addSubview:self.imageView];
    [self.imageView startAnimating];
} 


@end
