//
//  TetrisShape.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "TetrisShape.h"
#import "Cell.h"
#import "stdlib.h"
#define PointObj(point) [NSValue valueWithCGPoint:point]

@interface TetrisShape()
@property (assign, nonatomic) CGPoint centerPoint;
@property (retain, nonatomic) NSMutableSet* shapePoints;
@property (retain, nonatomic) NSMutableArray* shapesCollection;
@property (retain, nonatomic) NSArray* colorsCollection;
- (void)randomTypeShape;
@end
@implementation TetrisShape
@synthesize centerPoint;
@synthesize shapePoints;
@synthesize shapesCollection;
@synthesize colorsCollection;
@synthesize shapeColor;
- (void)dealloc
{
    self.shapePoints = nil;
    self.shapesCollection = nil;
    self.colorsCollection = nil;
    self.shapeColor = nil;
    [super dealloc];
}

- (id)initRandomShape
{
    //?
    self.shapesCollection = [NSMutableArray arrayWithObjects:
                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(0, 0)], nil], //None
                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(1, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], [[Cell alloc] initWithPoint:CGPointMake(1, 1)], nil], //SquareShape
                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(1, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(1, 0)], nil], //ZShape
                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(-1, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], [[Cell alloc] initWithPoint:CGPointMake(1, 1)], nil], //SShape
                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(-1, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], nil], //LShape
                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(1, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], nil], //JShape
                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(0, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], [[Cell alloc] initWithPoint:CGPointMake(0, 2)], nil], //IShape
                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(-1, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(1, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], nil], //TShape
                             nil];
    self.colorsCollection = [NSArray arrayWithObjects:
                       [UIColor blackColor],
                       [UIColor yellowColor],
                       [UIColor brownColor],
                       [UIColor blueColor],
                       [UIColor purpleColor],
                       [UIColor greenColor],
                       [UIColor grayColor],
                       [UIColor magentaColor],
                       [UIColor redColor],
                       nil];
    self = [super init];
    if(self) {
        [self randomTypeShape];
        
    }
    return self;
}

- (NSInteger)randomNumberFrom:(NSInteger)from To:(NSInteger)to
{
    return (from + rand() % (to - from));
}

- (void)randomTypeShape
{
    TypeShape randomTypeShape = [self randomNumberFrom:1 To:[self.shapesCollection count]];
    self.shapePoints = [self.shapesCollection objectAtIndex:randomTypeShape];
    self.shapeColor = [self.colorsCollection objectAtIndex:randomTypeShape];
    NSLog(@"shape POints");
    
}
@end
