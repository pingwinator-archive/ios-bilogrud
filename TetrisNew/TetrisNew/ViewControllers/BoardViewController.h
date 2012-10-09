//
//  BoardViewController.h
//  TetrisNew
//
//  Created by Natasha on 08.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BoardView;
@class TetrisShape;

@interface BoardViewController : UIViewController
@property (retain, nonatomic) NSMutableSet* boardCells;
@property (retain, nonatomic) NSMutableSet* nextShapeCells;
@property (retain, nonatomic) BoardView* boardView;
@property (retain, nonatomic) BoardView* nextShapeView;
@property (assign, nonatomic) BOOL gameOver;
@property (assign, nonatomic) BOOL needUpdate;
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGPoint startPointNextShape;
- (id)initWithFrame:(CGRect)frame amountCellX:(NSInteger)cellX amountCellY:(NSInteger)cellY;
- (void)start;
//manage
- (void)rotateShape:(DirectionRotate) directionRotate;
- (void)moveShape:(DirectionMove) directionMove;
- (NSMutableSet*)getBoard;
@end
