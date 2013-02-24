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

@implementation CustomSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setThumbImage:[imagePNG(@"handleFilter")stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateSelected];
        self.thumbTintColor = [UIColor redColor];
        
    
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
        self.backgroundColor=  [UIColor blueColor];
    }
    return self;
}

//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
//{
//    NSLog(@"ee");
//   
////    bounds.size.width += 5;
////    NSLogR([super thumbRectForBounds:bounds trackRect:rect value:value]);
//    return CGRectMake(75, 4, 100, 23);//[super thumbRectForBounds:bounds trackRect:rect value:value];
//}

@end
