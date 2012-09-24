//
//  GridGraphic.m
//  EndlessGrid
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "GridGraphic.h"
#define kCellHeight 40.0
#define kCellWidth 40.0
@implementation GridGraphic
@synthesize cellHeight;
@synthesize cellWidth;

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
    self.cellHeight = [NSNumber numberWithDouble:kCellHeight];
    self.cellWidth = [NSNumber numberWithDouble:kCellWidth];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    for (int i = 0; i < self.frame.size.width;  i+=kCellWidth) {
        CGContextMoveToPoint(context, i, 0);
        CGContextAddLineToPoint(context, i, self.frame.size.height);
    }
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, 300, 400);
    CGContextStrokePath(context);

   // self.window.frame.size.height
}

@end
