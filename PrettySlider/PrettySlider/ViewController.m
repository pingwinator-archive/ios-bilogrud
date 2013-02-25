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

@property (assign, nonatomic) CGFloat startPosition;
@property (assign, nonatomic) CGFloat finishPosition;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.slider = [[CustomSlider alloc] initWithFrame:CGRectMake(20, 100, 280, 30)];
    [self.view addSubview:self.slider];
    
    [self.slider addTarget:self action:@selector(startMoving:) forControlEvents:UIControlEventTouchDown];
    [self.slider addTarget:self action:@selector(finishMoving:) forControlEvents:UIControlEventTouchUpInside];
    [self.slider addTarget:self action:@selector(moving:) forControlEvents:UIControlEventValueChanged];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 150, 40, 40)];
    [self.imageView setImage:[imagePNG(@"handleFilter")stretchableImageWithLeftCapWidth:15 topCapHeight:0]];
    [self.view addSubview:self.imageView];
}

- (float)xPositionFromSliderValue:(UISlider *)aSlider;
{
    float sliderRange = aSlider.frame.size.width - aSlider.currentThumbImage.size.width;
    float sliderOrigin = aSlider.frame.origin.x + (aSlider.currentThumbImage.size.width / 2.0);
    
    float sliderValueToPixels = (((aSlider.value-aSlider.minimumValue)/(aSlider.maximumValue-aSlider.minimumValue)) * sliderRange) + sliderOrigin;

    return sliderValueToPixels;
}

- (void)startMoving:(id)sender
{
    self.startPosition = [self xPositionFromSliderValue:sender];
    NSLog(@"startPosition :  %f", self.startPosition);
}

- (void)finishMoving:(id)sender
{
    self.finishPosition = [self xPositionFromSliderValue:sender];
    NSLog(@"finishPosition :  %f", self.finishPosition);
    self.imageView.frame = CGRectMake( self.finishPosition - ((UISlider*)sender).currentThumbImage.size.width / 2, self.imageView.frame.origin.y, 40, 40);
}

- (void)moving:(id)sender
{
    float x = [self xPositionFromSliderValue:sender];
    NSLog(@"moving : %f", x);
    self.imageView.frame = CGRectMake(x - ((UISlider*)sender).currentThumbImage.size.width / 2, self.imageView.frame.origin.y, 60, 40);
}
@end