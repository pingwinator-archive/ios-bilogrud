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
- (id)initRandomShape;
@end
