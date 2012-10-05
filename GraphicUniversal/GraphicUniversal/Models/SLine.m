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
@synthesize aKoef;
@synthesize bKoef;
@synthesize cKoef;
- (void)dealloc
{
    self.color = nil;
    [super dealloc];
}

- (id)initWithKoefA: (CGFloat)a B:(CGFloat)b C:(CGFloat)c withColor:(UIColor*)curColor
{
    self = [super init];
    if(self) {
        self.color = curColor;
        self.aKoef = a;
        self.bKoef = b;
        self.cKoef = c;
        DBLog(@"%f x + %f y + %f = 0", self.aKoef, self.bKoef, self.cKoef);

    }
    return self;
}
- (id)initWithFirstPoint: (CGPoint) fPoint secondPoint:(CGPoint) sPoint withColor:(UIColor*)curColor
{
    self = [super init];
    if(self) {
        self.color = curColor;
        self.firstPoint = fPoint;
        self.secondPoint = sPoint;
        self.aKoef = sPoint.y - fPoint.y;
        self.bKoef = fPoint.x - sPoint.x;
        self.cKoef = - fPoint.x * sPoint.y + sPoint.x * fPoint.y;
        DBLog(@"%f x + %f y + %f = 0", self.aKoef, self.bKoef, self.cKoef);
    }
    return self;
}

//lines
+ (NSValue*)intersectLine:(SLine*)firstLine withSecondLine:(SLine*)secondLine
{
    NSValue* intersectPoint = nil;
    
    //first line : y = k1 * x + b1
    //k1 = - a /b
    // if(firstLine.bKoef != 0 && secondLine.bKoef != 0) {
    if(firstLine.aKoef * secondLine.bKoef - secondLine.aKoef * firstLine.bKoef) {
        CGFloat xIntersect;
        CGFloat yIntersect;
        if(firstLine.bKoef != 0 && secondLine.bKoef != 0) {
            CGFloat k1 = - firstLine.aKoef / firstLine.bKoef;
            CGFloat b1 = - firstLine.cKoef / firstLine.bKoef;
            
            CGFloat k2 = - secondLine.aKoef / secondLine.bKoef;
            CGFloat b2 = - secondLine.cKoef / secondLine.bKoef;
            
            xIntersect = (b2 - b1)/(k1 - k2);
            yIntersect = k1 * xIntersect + b1;
        } else {
            xIntersect = 0;
            yIntersect = 0;
        }
        intersectPoint = [NSValue valueWithCGPoint:CGPointMake(xIntersect, yIntersect)];
    }
    return intersectPoint;
}

@end
