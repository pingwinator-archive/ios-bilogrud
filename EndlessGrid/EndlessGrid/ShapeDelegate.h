//
//  ShapeDelegate.h
//  EndlessGrid
//
//  Created by Natasha on 01.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomShapeDelegate <NSObject>
- (void)closeCustomShapeView;
- (void)createPoint: (CGPoint)point;
- (void)createSegment: (CGPoint)firstPoint secondPoint:(CGPoint)secondPoint;
// ax+by+c = 0
- (void)createLineWithKoeffA: (CGFloat)a B:(CGFloat)b C:(CGFloat)c;
@end
