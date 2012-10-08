//
//  Cell.h
//  TetrisNew
//
//  Created by Natasha on 08.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject
@property (assign, nonatomic) CGPoint point;
@property (retain, nonatomic) UIColor* colorCell;

- (id)initWithPoint:(CGPoint)_point;
@end
