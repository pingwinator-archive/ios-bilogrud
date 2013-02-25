//
//  CustomSlider.m
//  MultiExpoNew
//
//  Created by Natasha on 03.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomSlider.h"

#define capWidth 10.0
#define capHeight 0.0
#define minValue 0.0
#define maxValue 1.0
#define startValue (maxValue - minValue)/2

#define sliderH 40
@interface CustomSlider ()
@property (strong, nonatomic) UIView* testView;
@property (strong, nonatomic) UIImageView* imageView;
@property (assign, nonatomic) CGFloat startPosition;
@property (assign, nonatomic) CGFloat finishPosition;
- (void)setTarget:(id)target;
@end
@implementation CustomSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setThumbImage:imagePNG(@"handleFilter") forState:UIControlStateNormal];
        UIImage* stretchLeftTrack = imagePNG(@"trackFilter"),*stretchRightTrack = imagePNG(@"trackFilter");
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
            stretchLeftTrack = [stretchLeftTrack stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight];
            stretchRightTrack = [stretchRightTrack stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight];
        }
        
        [self setMinimumTrackImage:stretchLeftTrack forState:UIControlStateNormal];
        [self setMaximumTrackImage:stretchRightTrack forState:UIControlStateNormal];

        self.minimumValue = minValue;
        self.maximumValue = maxValue;
        self.value = startValue;
        self.userInteractionEnabled = YES;
        
        NSLog(@"init x %f", [self xPositionFromSliderValue:self]);
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.origin.x + self.bounds.size.width) / 2 - 25 /2, -5, 33, sliderH)];
        [self.imageView setImage:[imagePNG(@"handleFilter")stretchableImageWithLeftCapWidth:15 topCapHeight:15]];
        [self addSubview:self.imageView];
        [self setTarget:self];
        
        self.startPosition = [self xPositionFromSliderValue:self];
        NSLog(@"startPosition :  %f", self.startPosition);
        self.finishPosition = [self xPositionFromSliderValue:self];
        
        [self moving];
    }
    return self;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    return [super thumbRectForBounds:bounds trackRect:rect value:value];
}

- (float)xPositionFromSliderValue:(UISlider *)aSlider;
{
    float sliderRange = aSlider.frame.size.width - aSlider.currentThumbImage.size.width;
    
    float sliderValueToPixels = (((aSlider.value-aSlider.minimumValue)/(aSlider.maximumValue-aSlider.minimumValue)) * sliderRange);
    
    return roundf( sliderValueToPixels);
}

- (void)moving
{
    self.finishPosition = [self xPositionFromSliderValue:self] ;
    
    CGFloat distance;
    if (self.finishPosition > self.startPosition) {
        distance = abs(self.finishPosition - self.startPosition);
    } else {
        distance = abs(self.startPosition - self.finishPosition);
    }
    
    NSLog(@"distance :  %f", distance);
    NSLog(@"x  %f", self.finishPosition - self.currentThumbImage.size.width / 2);
    if (self.finishPosition > self.startPosition) {
        self.imageView.frame = CGRectMake(self.startPosition - 0*self.currentThumbImage.size.width /2,self.imageView.frame.origin.y, distance + self.currentThumbImage.size.width, sliderH);
    } else {
        self.imageView.frame = CGRectMake(self.finishPosition - 0*self.currentThumbImage.size.width /2 , self.imageView.frame.origin.y, distance + self.currentThumbImage.size.width, sliderH);
    }
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
    self.imageView.frame = CGRectMake( self.finishPosition - 0*self.currentThumbImage.size.width / 2, self.imageView.frame.origin.y, 33, sliderH);
    self.startPosition = self.finishPosition;
}

- (void)setTarget:(id)target
{
    [self addTarget:target action:@selector(startMoving:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:target action:@selector(finishMoving:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:target action:@selector(finishMoving:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:target action:@selector(moving) forControlEvents:UIControlEventValueChanged];
}
@end
