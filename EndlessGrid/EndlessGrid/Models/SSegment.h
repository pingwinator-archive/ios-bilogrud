//
//  SSegment.h
//  EndlessGrid
//
//  Created by Natasha on 28.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
@interface SSegment : Shape
@property(assign, nonatomic) CGPoint firstPointDekart;
@property(assign, nonatomic) CGPoint lastPointDekart;
@property(retain, nonatomic) UIColor* color;
- (id)initWithFirstPoint: (CGPoint) fPoint LastPoint:(CGPoint) lPoint;
@end
