//
//  BoardView.m
//  Tetris
//
//  Created by Natasha on 29.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BoardView.h"
#import <QuartzCore/QuartzCore.h>
@interface BoardView()
@property (assign, nonatomic) CGFloat cell;
@end
@implementation BoardView
@synthesize amountCellX;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.amountCellX = 10.0f;
        NSLog(@"%f", self.frame.size.width);
        self.cell = (self.frame.size.width - 2*boardBorderWidth) / self.amountCellX;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, boardGridWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    for (CGFloat i = boardBorderWidth + self.cell ; i < self.frame.size.width - 2 * boardBorderWidth; i += self.cell) {
        CGContextMoveToPoint(context, i, 0);
        CGContextAddLineToPoint(context, i, self.frame.size.height);
    }
    
    for (NSInteger j = self.frame.size.height - boardBorderWidth - self.cell; j > 0; j -= self.cell  ) {
        CGContextMoveToPoint(context, 0, j);
        CGContextAddLineToPoint(context, self.frame.size.width, j);
    }

    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = boardBorderWidth;
    CGContextStrokePath(context);

}


@end
