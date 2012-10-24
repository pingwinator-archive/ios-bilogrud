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
- (void)drawGrid:(CGRect)rect withContext:(CGContextRef)context;
- (void)drawBoard:(CGContextRef)context;
- (void)drawNextShape:(CGContextRef)context;
@property (assign, nonatomic) CGFloat cellDistance;
@end

@implementation BoardView
@synthesize boardCellsForDrawing;
@synthesize amountCellX;
@synthesize amountCellY;
@synthesize cellHeight;
@synthesize cellWidth;
@synthesize nextShapeCellsForDrawing;
@synthesize showGrid;
@synthesize showColor;
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
        self.showColor = NO;
        self.amountCellX = cellX;
        self.amountCellY = cellY;
        self.cellWidth = (self.frame.size.width - 2 * boardBorderWidth) / self.amountCellX;
        self.cellHeight = (self.frame.size.height - 2 *  boardBorderWidth) / self.amountCellY;
        self.cellDistance = self.cellWidth / 10;
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
    
    CGContextStrokePath(context);
}
//#define cellDistance 1
//#define cellDistanceiPad 2
//#define cellDistanceForNext 0.8
- (void)drawGrid:(CGRect)rect withContext:(CGContextRef)context
{
    CGContextStrokePath(context);
    UIColor* c = [UIColor colorWithRed: 0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.05];
    
    CGContextSetStrokeColorWithColor(context, c.CGColor);
    
    for (CGFloat i = boardBorderWidth ; i <= rect.size.width; i += self.cellWidth) {
        for (CGFloat j = 0; j <= amountCellY; j ++) {
        
        CGRect rect = CGRectMake(i, boardBorderWidth + (self.cellHeight)*j, self.cellWidth, self.cellHeight);
        
        CGContextSetLineWidth(context, cellGridWidth);
        
        CGContextAddRect(context, rect);
        CGContextStrokePath(context);
        
        [c setFill];
        
        CGRect filledRect = CGRectMake(rect.origin.x + cellGridWidth + self.cellDistance, rect.origin.y + cellGridWidth + self.cellDistance, rect.size.width - (cellGridWidth + self.cellDistance) * 2, rect.size.height - (cellGridWidth + self.cellDistance) * 2);
        CGContextAddRect(context, filledRect);
        CGContextFillRect(context, filledRect);  
        }
    }
     CGContextStrokePath(context);
}

- (void)drawBoard:(CGContextRef)context
{
    CGContextStrokePath(context);
     for (Cell* cell in self.boardCellsForDrawing) {
        UIColor* shapeColor = cell.colorCell;
         CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
  
        CGRect rect = CGRectMake(boardBorderWidth + (self.cellWidth) * cell.point.x, boardBorderWidth + (self.cellHeight) * cell.point.y, self.cellWidth, self.cellHeight);
       
        CGContextSetLineWidth(context, cellGridWidth);

        CGContextAddRect(context, rect);
        CGContextStrokePath(context);
        
        if (self.showColor) {
            [shapeColor setFill];
        } else {
            [[UIColor blackColor] setFill];
        }
        // NSInteger curCellDistance;
//         if(isiPhone) {
//             curCellDistance = self.cellDistance;
//         } else {
//             curCellDistance = self.cellDistance;;//cellDistanceiPad;
//         }
       CGRect filledRect = CGRectMake(rect.origin.x + cellGridWidth + self.cellDistance, rect.origin.y + cellGridWidth + self.cellDistance, rect.size.width - (cellGridWidth + self.cellDistance) * 2, rect.size.height - (cellGridWidth + self.cellDistance) * 2);
       CGContextAddRect(context, filledRect);
       CGContextFillRect(context, filledRect);
    }
}

- (void)drawNextShape:(CGContextRef)context
{
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    for (Cell* cell in self.nextShapeCellsForDrawing) {
        CGRect rect = CGRectMake(boardBorderWidth + (self.cellWidth) * cell.point.x, boardBorderWidth + (self.cellHeight)* cell.point.y, self.cellWidth, self.cellHeight);
        
        CGContextSetLineWidth(context, cellGridWidth);
        
        CGContextAddRect(context, rect);
        CGContextStrokePath(context);
        
        if (self.showColor) {
            [cell.colorCell setFill];
        } else {
            [[UIColor blackColor] setFill];
        }
        
       // CGFloat curCellDistanceForNext;
//        if(isiPhone) {
//            curCellDistanceForNext = cellDistanceForNext;
//        } else {
//            curCellDistanceForNext = cellDistanceiPad;
//        }
        CGRect filledRect = CGRectMake(rect.origin.x + cellGridWidth + self.cellDistance, rect.origin.y + cellGridWidth + self.cellDistance, rect.size.width - (cellGridWidth + self.cellDistance) * 2, rect.size.height - (cellGridWidth + self.cellDistance) * 2);
        CGContextAddRect(context, filledRect);
        CGContextFillRect(context, filledRect);
    }
}
@end
