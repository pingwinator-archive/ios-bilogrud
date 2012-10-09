//
//  BoardView.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BoardView.h"
#import <QuartzCore/QuartzCore.h>
#import "Cell.h"
@interface BoardView()

@end

@implementation BoardView
@synthesize boardCellsForDrawing;
@synthesize amountCellX;
@synthesize amountCellY;
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
        NSInteger countCellY = 0;
        NSInteger j = 0;
        for (j = 0, countCellY = 0 ; j < self.frame.size.height - boardBorderWidth ; j += self.cell , countCellY++ );
        self.amountCellY = countCellY;
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
    
    [self drawBoard:context];
    CGContextStrokePath(context);
}

- (void)drawBoard:(CGContextRef)context
{
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    for (Cell* cell in self.boardCellsForDrawing) {
        CGRect rect = CGRectMake(boardBorderWidth + self.cell * cell.point.x, boardBorderWidth + self.cell * cell.point.y, self.cell, self.cell);
        [cell.colorCell setFill];
        CGContextAddRect(context, rect);
        CGContextFillRect(context, rect);
    }
    CGContextDrawPath(context, kCGPathFill);
}

- (NSMutableSet*)transformation:(NSMutableSet*)localShape withCenter:(CGPoint)center
{
    NSMutableSet* setTransformShape = [[NSMutableSet alloc] init];
    for (Cell* cell in localShape) {
        [setTransformShape addObject:[[[Cell alloc] initWithPoint:CGPointMake(cell.point.x + center.x - 1, cell.point.y + center.y - 1)] autorelease]];
    }
    return setTransformShape;
}
@end
