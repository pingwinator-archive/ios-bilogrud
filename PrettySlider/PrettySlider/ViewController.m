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
    [self.slider addTarget:self action:@selector(finishMoving:) forControlEvents:UIControlEventTouchUpOutside];
    [self.slider addTarget:self action:@selector(moving:) forControlEvents:UIControlEventValueChanged];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(145, 95, 33, 40)];
    [self.imageView setImage:[imagePNG(@"handleFilter")stretchableImageWithLeftCapWidth:15 topCapHeight:15]];
    [self.view addSubview:self.imageView];
    
    self.startPosition = [self xPositionFromSliderValue:self.slider];    
    NSLog(@"startPosition :  %f", self.startPosition);
    self.finishPosition = [self xPositionFromSliderValue:self.slider] + self.slider.currentThumbImage.size.width;
    NSLog(@"finishPosition :  %f", self.finishPosition);

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
    self.imageView.frame = CGRectMake( self.finishPosition - ((UISlider*)sender).currentThumbImage.size.width / 2, self.imageView.frame.origin.y, 33, 40);
    self.startPosition = self.finishPosition;
}

- (void)moving:(id)sender
{
    self.finishPosition = [self xPositionFromSliderValue:sender] ;//+ ((UISlider*)sender).currentThumbImage.size.width;
   
    CGFloat distance;
    if (self.finishPosition > self.startPosition) {
        distance = abs(self.finishPosition - self.startPosition);
    } else {
        distance = abs(self.startPosition - self.finishPosition);
    }

//    if (abs(distance) < 33) {
//        distance = 33;
//    }
    
    NSLog(@"distance :  %f", distance);
    NSLog(@"x  %f", self.finishPosition - ((UISlider*)sender).currentThumbImage.size.width / 2);
    if (self.finishPosition > self.startPosition) {
        self.imageView.frame = CGRectMake(self.startPosition - ((UISlider*)sender).currentThumbImage.size.width / 2 , self.imageView.frame.origin.y, distance +((UISlider*)sender).currentThumbImage.size.width, 40);
    } else {
        self.imageView.frame = CGRectMake(self.finishPosition - ((UISlider*)sender).currentThumbImage.size.width /2 , self.imageView.frame.origin.y, distance +((UISlider*)sender).currentThumbImage.size.width, 40);
    }
}
@end