//
//  SLine.m
//  EndlessGrid
//
//  Created by Natasha on 28.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SLine.h"

@implementation SLine
@synthesize firstPoint;
@synthesize secondPoint;
@synthesize color;

- (void)dealloc
{
    self.color = nil;
    [super dealloc];
}

- (id)initWithFirstPoint: (CGPoint) fPoint secondPoint:(CGPoint) sPoint
{
    self = [super init];
    if(self) {
        self.color = [UIColor greenColor];
        self.firstPoint = fPoint;
        self.secondPoint = sPoint;
    }
    return self;
}

@end
