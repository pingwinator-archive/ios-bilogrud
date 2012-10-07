//
//  BoardView.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BoardView.h"
#import <QuartzCore/QuartzCore.h>
@interface BoardView()
@property (assign, nonatomic) NSInteger amountCellX;
//width and height
@property (assign, nonatomic) CGFloat cell;
@end

@implementation BoardView
@synthesize amountCellX;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.amountCellX = 10;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame amountCellX:(NSInteger)cellX 
{
    self = [self initWithFrame:frame];
    if(self) {
        self.amountCellX = cellX;
         self.cell = (self.frame.size.width - 2 * boardBorderWidth) / self.amountCellX;
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
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    for (CGFloat i = boardBorderWidth + self.cell ; i < self.frame.size.width - 2 * boardBorderWidth; i += self.cell) {
        CGContextMoveToPoint(context, i, 0);
        CGContextAddLineToPoint(context, i, self.frame.size.height);
    }
    
    for (NSInteger j = self.frame.size.height - boardBorderWidth - self.cell; j > 0; j -= self.cell  ) {
        CGContextMoveToPoint(context, 0, j);
        CGContextAddLineToPoint(context, self.frame.size.width, j);
    }
    
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = boardBorderWidth;
    CGContextStrokePath(context);
}


@end
