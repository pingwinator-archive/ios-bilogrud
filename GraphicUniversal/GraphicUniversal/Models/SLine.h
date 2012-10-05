//
//  SLine.h
//  EndlessGrid
//
//  Created by Natasha on 28.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

@interface SLine : Shape
@property (assign, nonatomic) CGPoint firstPoint;
@property (assign, nonatomic) CGPoint secondPoint;

@property (assign, nonatomic) CGFloat aKoef;
@property (assign, nonatomic) CGFloat bKoef;
@property (assign, nonatomic) CGFloat cKoef;
- (id)initWithFirstPoint: (CGPoint) fPoint secondPoint:(CGPoint) sPoint withColor:(UIColor*)curColor;
- (id)initWithKoefA: (CGFloat)a B:(CGFloat)b C:(CGFloat)c withColor:(UIColor*)curColor;
+ (NSValue*)intersectLine:(SLine*)firstLine withSecondLine:(SLine*)secondLine;
@end
