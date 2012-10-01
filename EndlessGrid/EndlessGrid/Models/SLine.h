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
@property (retain, nonatomic) UIColor* color;
- (id)initWithFirstPoint: (CGPoint) fPoint secondPoint:(CGPoint) sPoint;
@end
