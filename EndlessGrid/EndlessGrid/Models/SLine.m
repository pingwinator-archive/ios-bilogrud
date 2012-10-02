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
@synthesize aKoef;
@synthesize bKoef;
@synthesize cKoef;
- (void)dealloc
{
    self.color = nil;
    [super dealloc];
}

- (id)initWithKoefA: (CGFloat)a B:(CGFloat)b C:(CGFloat)c
{
    self = [super init];
    if(self) {
        self.color = [UIColor greenColor];
        self.aKoef = a;
        self.bKoef = b;
        self.cKoef = c;
        NSLog(@"%f x + %f y + %f = 0", self.aKoef, self.bKoef, self.cKoef);

    }
    return self;
}
- (id)initWithFirstPoint: (CGPoint) fPoint secondPoint:(CGPoint) sPoint
{
    self = [super init];
    if(self) {
        self.color = [UIColor greenColor];
        self.firstPoint = fPoint;
        self.secondPoint = sPoint;
        self.aKoef = sPoint.y - fPoint.y;
        self.bKoef = fPoint.x - sPoint.x;
        self.cKoef = - fPoint.x * sPoint.y + sPoint.x * fPoint.y;
        NSLog(@"%f x + %f y + %f = 0", self.aKoef, self.bKoef, self.cKoef);
    }
    return self;
}
@end
