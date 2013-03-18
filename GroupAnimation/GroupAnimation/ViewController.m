//
//  ViewController.m
//  GroupAnimation
//
//  Created by Natasha on 15.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"
@interface ViewController ()
@property (strong, nonatomic) AnimationView* animationButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
	// Do any additional setup after loading the view, typically from a nib.
    self.animationButton = [[AnimationView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.animationButton.delegate = self;
    [self.animationButton setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.animationButton];
}

- (void)animationViewSelected
{
    NSLog(@"animationViewSelected");
    self.animationButton.hidden = YES;
}

@end
