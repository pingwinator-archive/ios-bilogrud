//
//  ViewController.m
//  PrettySlider
//
//  Created by Natasha on 22.02.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "CustomSlider.h"

@interface ViewController ()
@property (strong, nonatomic) CustomSlider* slider;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.slider = [[CustomSlider alloc] initWithFrame:CGRectMake(20, 100, 280, 30)];
    [self.view addSubview:self.slider];
}

@end