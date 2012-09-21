//
//  draw2D.m
//  draw2D
//
//  Created by Natasha on 21.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "draw2D.h"

@implementation draw2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //line
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2.0);
//    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
//    CGColorRef color = CGColorCreate(CGColorSpaceCreateDeviceRGB(), components);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, 300, 400);
//    CGContextStrokePath(context);
//    CGColorRelease(color);
    
    //image
//    UIImage *myImage = [UIImage imageNamed:@"pumpkin.jpeg"];
//    CGRect imageRect = CGRectMake(10, 10, 300, 400);
//    [myImage drawInRect:imageRect];
//    [myImage release];
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0);
       //rectangle
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rectangle = CGRectMake(20, 20, 280, 420);
    CGContextAddRect(context, rectangle);
    
    //path
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, 25, 230);
    CGContextAddLineToPoint(context, 160, 25);
    CGContextAddLineToPoint(context, 295, 230);
    CGContextAddLineToPoint(context, 160, 435);
    CGContextAddLineToPoint(context, 25, 230);
    
    CGContextStrokePath(context);
    //shadow
//    CGContextSetShadowWithColor(context, CGSizeMake(10.0f, 10.0f),
//                                20.0f, [[UIColor grayColor] CGColor]);
    //circle
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGRect rectCircle = CGRectMake(50, 120, 220, 220);
    [[UIColor orangeColor] setFill];
    CGContextAddEllipseInRect(context, rectCircle);
    CGContextDrawPath(context, kCGPathFill);
    
    UIColor *magentaColor = [UIColor colorWithRed:0.5f  green:0.0f blue:0.5f alpha:1.0f];
    [magentaColor set];
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f];
    //text
    NSString *myString = @"Hello Different Shapes!";
    [myString drawInRect:CGRectMake(90, 150, 130, 200) withFont: helveticaBold lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
 
}



@end
