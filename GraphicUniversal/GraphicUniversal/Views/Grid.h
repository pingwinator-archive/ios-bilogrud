//
//  Grid.h
//  GraphicUniversal
//
//  Created by Natasha on 05.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Grid : UIView
@property (retain, nonatomic) NSNumber* cellHeight;
@property (retain, nonatomic) NSNumber* cellWidth;
@property (assign, nonatomic) CGFloat gridOffsetX;
@property (assign, nonatomic) CGFloat gridOffsetY;
@property (retain, nonatomic) UIColor* shapeColor;
@end
