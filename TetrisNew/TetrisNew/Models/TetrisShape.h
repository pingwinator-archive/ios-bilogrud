//
//  TetrisShape.h
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TetrisShape : NSObject
@property (retain, nonatomic) UIColor* shapeColor;
@property (readonly, assign, nonatomic) CGPoint centerPoint;
- (NSMutableSet*)getShapePoints;
- (id)initRandomShapeWithCenter:(CGPoint)center;
- (NSMutableSet*)getMovedShape:(DirectionMove)directionMove;
- (void)deepMove:(DirectionMove)directionMove;
@end
