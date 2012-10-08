//
//  BoardView.h
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UIView
@property (assign, nonatomic) NSInteger amountCellX;
//width and height
@property (assign, nonatomic) CGFloat cell;
- (id)initWithFrame:(CGRect)frame amountCellX:(NSInteger)cellX;
@end
