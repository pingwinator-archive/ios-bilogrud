//
//  GridGraphicViewController.h
//  GraphicUniversal
//
//  Created by Natasha on 05.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
@class SettingView;
@class Shape;
@class Grid;
@protocol SettingsViewDelegate;

@interface GridGraphicViewController : ViewController

@property (retain, nonatomic) Grid* gridView;
//@property (retain, nonatomic) NSNumber* cellHeight;
//@property (retain, nonatomic) NSNumber* cellWidth;
//@property (assign, nonatomic) CGFloat gridOffsetX;
//@property (assign, nonatomic) CGFloat gridOffsetY;

@property (nonatomic) ActionType actionType;
//@property (retain, nonatomic) UIColor* shapeColor;
- (void)addCustomShape:(Shape*)shape;
- (void)clearBoard;
- (Shape*)lastShape;
@end
