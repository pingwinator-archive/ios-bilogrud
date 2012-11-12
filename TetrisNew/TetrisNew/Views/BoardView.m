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
//with ImageView
- (void)drawImageBoard;
- (void)drawImageNextBoard;
@property (assign, nonatomic) CGFloat cellDistance;
@property (retain, nonatomic) NSIndexPath* cellIndexPath;
@property (retain, nonatomic) NSMutableArray* cellImageViewCollection;
@property (retain, nonatomic) NSMutableSet* prevBoardState;
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
@synthesize cellIndexPath;
@synthesize cellImageViewCollection;
@synthesize prevBoardState;
- (void)dealloc
{
    self.boardCellsForDrawing = nil;
    self.nextShapeCellsForDrawing = nil;
    self.cellIndexPath = nil;
    self.cellImageViewCollection = nil;
    self.prevBoardState = nil;
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
        self.cellImageViewCollection = [NSMutableArray array];
        self.prevBoardState = [NSMutableSet set];
        
        
        for (int i = 0; i < self.amountCellY; i++) {
            for (int j = 0; j < self.amountCellX; j++) {
                UIImageView* cellImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty.png"] highlightedImage:[UIImage imageNamed:@"cell.png"]]autorelease];
                cellImageView.frame = CGRectMake(boardBorderWidth + j * self.cellWidth, boardBorderWidth + i * self.cellHeight, self.cellWidth, self.cellHeight);
                
                [self.cellImageViewCollection addObject:cellImageView];
                NSLog(@"(%d, %d) position %d", j, i, [self.cellImageViewCollection indexOfObject:cellImageView]);
                [self addSubview:cellImageView];
            }
        }
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if(self.nextShapeCellsForDrawing) {
        [self drawImageNextBoard];
    }
    [self drawImageBoard];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, boardGridWidth);
//
//    if(self.showGrid) {
//        [self drawGrid:rect withContext:context];
//    }
//    [self drawBoard:context];
//    if(self.nextShapeCellsForDrawing) {
//        [self drawNextShape:context];
//    }    
//    CGContextStrokePath(context);
}

- (void)drawGrid:(CGRect)rect withContext:(CGContextRef)context
{
    CGContextStrokePath(context);
    UIColor* c = [UIColor colorWithRed: 0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.05];
    
    CGContextSetStrokeColorWithColor(context, c.CGColor);
    
    for (CGFloat i = boardBorderWidth ; i <= rect.size.width; i += self.cellWidth) {
        for (CGFloat j = 0; j <= amountCellY; j++) {
        
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
        
        CGRect filledRect = CGRectMake(rect.origin.x + cellGridWidth + self.cellDistance, rect.origin.y + cellGridWidth + self.cellDistance, rect.size.width - (cellGridWidth + self.cellDistance) * 2, rect.size.height - (cellGridWidth + self.cellDistance) * 2);
        CGContextAddRect(context, filledRect);
        CGContextFillRect(context, filledRect);
    }
}

- (void)drawImageBoard
{
    if([self.prevBoardState count]) {
        NSMutableSet* diffPrev = [NSMutableSet setWithSet:self.prevBoardState];
        [diffPrev minusSet:self.boardCellsForDrawing];
        NSLog(@"diff Prev %d", [diffPrev count]);
//        
        for (Cell* cell in diffPrev) {
            UIImageView* imageViewCurCell = [self cellImageViewForPoint:cell.point];
            if(imageViewCurCell) {
                NSLog(@"(%f, %f) position %d", cell.point.x, cell.point.y, [self.cellImageViewCollection indexOfObject:imageViewCurCell]);
                imageViewCurCell.highlighted = NO;
            }
        }

//        NSMutableSet* diff = [NSMutableSet setWithSet:self.prevBoardState];
//        [diff minusSet:self.boardCellsForDrawing];
        
        NSMutableSet* diff = [NSMutableSet setWithSet:self.boardCellsForDrawing];
        [diff minusSet:self.prevBoardState];

        NSLog(@"diff %@", [diff allObjects]);
        for (Cell* cell in diff) {
            UIImageView* imageViewCurCell = [self cellImageViewForPoint:cell.point];
            if(imageViewCurCell) {
                imageViewCurCell.highlighted = YES;
            }
        }
    }
    for (Cell* cell in self.boardCellsForDrawing) {
        for (UIImageView* cellImageView in self.cellImageViewCollection) {
           
//            if(boardBorderWidth + cell.point.x * self.cellWidth == cellImageView.frame.origin.x &&
//               boardBorderWidth + cell.point.y * self.cellHeight == cellImageView.frame.origin.y) {
//                cellImageView.highlighted = YES;
//            }
        }
    }
    self.prevBoardState = self.boardCellsForDrawing;
}

- (UIImageView*)cellImageViewForPoint:(CGPoint)point
{
    if(point.y >= 0) {
    NSUInteger n = point.y * self.amountCellX + point.x;
    
        return [self.cellImageViewCollection objectAtIndex:n];//[[UIImageView alloc]init];
    } else {
        return nil;
    }
}

- (void)drawImageNextBoard
{
    for (UIImageView* cell in self.subviews) {
        cell.highlighted = NO;
    }

    for (Cell* cell in self.nextShapeCellsForDrawing) {
        for (UIImageView* cellImageView in self.subviews) {
            if(boardBorderWidth + cell.point.x * self.cellWidth == cellImageView.frame.origin.x &&
               boardBorderWidth + cell.point.y * self.cellHeight == cellImageView.frame.origin.y) {
                cellImageView.highlighted = YES;
            }
        }
    }
}
@end
