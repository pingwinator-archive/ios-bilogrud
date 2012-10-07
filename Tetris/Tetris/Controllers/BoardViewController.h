//
//  BoardViewController.h
//  Tetris
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BoardView;
@interface BoardViewController : UIViewController
@property (assign, nonatomic) NSInteger amountCellX;
@property (retain, nonatomic) BoardView* boardView;
- (id) initWithFrame:(CGRect)frame andXCount:(NSInteger)amountX;
@end
