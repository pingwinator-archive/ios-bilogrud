//
//  ShapeGenerator.h
//  TetrisNew
//
//  Created by Natasha on 16.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShapeGenerator : NSObject
@property (retain, nonatomic) UIColor* colorShape;

+ (NSArray*)generateShape;
@end
