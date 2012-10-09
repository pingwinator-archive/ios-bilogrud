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
- (id)initWithPoint:(CGPoint)_point andColor:(UIColor*)_color
{
    self = [super init];
    if(self) {
        self.point = _point;
        self.colorCell = _color;
    }
    return self;
}

#pragma mark - Cell - Point

+ (NSValue*)cellToPointObj:(Cell*)cell
{
    return PointToObj(cell.point);
}

+ (Cell*)pointToCell:(NSValue*)value
{
    return [[Cell alloc] initWithPoint: PointFromObj(value)];
}

+ (Cell*)pointToCell:(NSValue*)value withColor: (UIColor*)color
{ 
    return [[Cell alloc] initWithPoint: PointFromObj(value) andColor:color];
}

+ (NSMutableSet*)pointsToCells:(NSMutableSet*)points withColor:(UIColor*)color
{
    NSMutableSet* cells = [[NSMutableSet alloc] init];
    for (NSValue* v in points) {
        [cells addObject: [Cell pointToCell:v withColor:color ]];
    }
    return cells;
}

+ (NSMutableSet*)cellsToPoints:(NSMutableSet*)cells
{
    NSMutableSet* points = [[NSMutableSet alloc] init];
    for (Cell* c in cells) {
        [points addObject: [Cell cellToPointObj:c]];
    }
    return points;
}

@end
