//
//  SSegment.m
//  EndlessGrid
//
//  Created by Natasha on 28.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SSegment.h"

@implementation SSegment
@synthesize firstPointDekart;
@synthesize lastPointDekart;
@synthesize color;

- (void)dealloc
{
    self.color = nil;
    [super dealloc];
}

- (id)initWithFirstPoint: (CGPoint) fPoint LastPoint:(CGPoint) lPoint withColor:(UIColor*)curColor
{
    self = [super init];
    if(self) {
        self.color = curColor;
        self.firstPointDekart = fPoint;
        self.lastPointDekart = lPoint;
    }
    return self;
}
@end
