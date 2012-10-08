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
@property (retain, nonatomic) BoardView* boardView;
- (id)initWithFrame:(CGRect)frame amountCellX:(NSInteger)cellX;
//manage
- (void)rotateShape:(DirectionRotate) directionRotate;
- (void)moveShape:(DirectionMove) directionMove;
- (NSMutableSet*)getBoard;

@end
