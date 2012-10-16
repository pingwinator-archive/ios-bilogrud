//
//  ShapeGenerator.m
//  TetrisNew
//
//  Created by Natasha on 16.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ShapeGenerator.h"

@implementation ShapeGenerator
- (void)dealloc
{
    self.colorShape = nil;
    [super dealloc];
}
+ (NSArray*)generateShape
{
    NSArray* arrShape = [NSArray array];
    return arrShape;
}

@end
