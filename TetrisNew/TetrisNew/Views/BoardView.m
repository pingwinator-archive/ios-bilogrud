//
//  BoardView.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BoardView.h"
//#import <QuartzCore/QuartzCore.h>
#import "Cell.h"
@interface BoardView()
- (void)drawGrid:(CGRect)rect withContext:(CGContextRef)context;
- (void)drawBoard:(CGContextRef)context;
- (void)drawNextShape:(CGContextRef)context;
@end

@implementation BoardView
@synthesize boardCellsForDrawing;
@synthesize amountCellX;
@synthesize amountCellY;
@synthesize cellHeight;
@synthesize cellWidth;
@synthesize nextShapeCellsForDrawing;
@synthesize showGrid;
- (void)dealloc
{
    self.boardCellsForDrawing = nil;
    self.nextShapeCellsForDrawing = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.amountCellX = 10;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame amountCellX:(NSInteger)cellX amountCellY:(NSInteger)cellY
{
    self = [self initWithFrame:frame];
    if(self) {
        self.showGrid = YES;
        self.amountCellX = cellX;
        self.amountCellY = cellY;
        self.cellWidth = (self.frame.size.width - 2 * boardBorderWidth) / self.amountCellX;
        self.cellHeight = (self.frame.size.height - 2 *  boardBorderWidth) / self.amountCellY;
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

    if(self.showGrid) {
        [self drawGrid:rect withContext:context];
    }
    [self drawBoard:context];
    if(self.nextShapeCellsForDrawing) {
        [self drawNextShape:context];
    }
//    self.layer.borderColor = [UIColor blackColor].CGColor;
//    self.layer.borderWidth = boardBorderWidth;
//    
    CGContextStrokePath(context);
}

- (void)drawGrid:(CGRect)rect withContext:(CGContextRef)context
{
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    for (CGFloat i = boardBorderWidth ; i < rect.size.width; i += self.cellWidth) {
        CGContextMoveToPoint(context, i, 0);
        CGContextAddLineToPoint(context, i, rect.size.height);
    }
    
    for (CGFloat j = boardBorderWidth; j < rect.size.height; j += self.cellHeight) {
        CGContextMoveToPoint(context, 0, j);
        CGContextAddLineToPoint(context, rect.size.width, j);
    }
     CGContextStrokePath(context);
}

- (void)drawBoard:(CGContextRef)context
{
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    for (Cell* cell in self.boardCellsForDrawing) {
        CGRect rect = CGRectMake(boardBorderWidth + (self.cellWidth) * cell.point.x, boardBorderWidth + (self.cellHeight)* cell.point.y, self.cellWidth, self.cellHeight);
       
        [cell.colorCell setFill];
        CGContextSetLineWidth(context, boardGridWidth);

        CGContextAddRect(context, rect);
        CGContextFillRect(context, rect);
    }
}

- (void)drawNextShape:(CGContextRef)context
{
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    for (Cell* cell in self.nextShapeCellsForDrawing) {
        CGRect rect = CGRectMake(boardBorderWidth + (self.cellWidth) * cell.point.x, boardBorderWidth + (self.cellHeight)* cell.point.y, self.cellWidth, self.cellHeight);
        
        [cell.colorCell setFill];
        CGContextSetLineWidth(context, boardGridWidth);
        
        CGContextAddRect(context, rect);
        CGContextFillRect(context, rect);
    }
}
@end
