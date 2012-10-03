//
//  SPoint.m
//  EndlessGrid
//
//  Created by Natasha on 28.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SPoint.h"

@implementation SPoint
@synthesize dekartPoint;
@synthesize color;

- (id) init
{
    self = [super init];
    if(self) {
        self.color = [UIColor redColor];
    }
    return self;
}

- (id) initWithPoint: (CGPoint)point WithColor:(UIColor*)curColor 
{
    self = [super init];
    if(self) {
        self.color = curColor;
        self.dekartPoint = point;
    }
    return self;
}

- (void)dealloc
{
    self.color = nil;
    [super dealloc];
}
@end
