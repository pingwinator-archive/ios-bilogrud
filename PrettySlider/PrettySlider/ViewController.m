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
@property (strong, nonatomic) UIImageView* imageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.slider = [[CustomSlider alloc] initWithFrame:CGRectMake(20, 100, 280, 30)];
    [self.view addSubview:self.slider];
    
    [self.slider addTarget:self action:@selector(startMoving) forControlEvents:UIControlEventTouchDown];
    [self.slider addTarget:self action:@selector(finishMoving) forControlEvents:UIControlEventTouchUpInside];
    [self.slider addTarget:self action:@selector(moving:) forControlEvents:UIControlEventValueChanged];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 150, 40, 40)];
    [self.imageView setImage:[imagePNG(@"handleFilter")stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    [self.view addSubview:self.imageView];
}

- (void)startMoving
{
    NSLog(@"start");
}

- (void)finishMoving
{
    NSLog(@"finish");
}

- (void)moving:(id)sender
{
    NSLog(@"moving");
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.slider.value * 200, 40);
}
@end
