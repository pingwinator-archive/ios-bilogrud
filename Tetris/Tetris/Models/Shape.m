//
//  Shape.m
//  Tetris
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Shape.h"
@interface Shape()
@property (retain, nonatomic) NSMutableArray* shapePoints;
@end

@implementation Shape
@synthesize shapePoints;
-(id)initTetrisShape
{
    self = [ super init];
    if(self){
        
    }
    return self;
}
@end
