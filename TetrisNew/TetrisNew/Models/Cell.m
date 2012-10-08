//
//  Cell.m
//  TetrisNew
//
//  Created by Natasha on 08.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Cell.h"

@implementation Cell
@synthesize point;
@synthesize colorCell;
- (void)dealloc
{
    self.colorCell = nil;
    [super dealloc];
}

- (id)initWithPoint:(CGPoint)_point
{
    self = [super init];
    if(self) {
        self.point = _point;
    }
    return self;
}
@end
