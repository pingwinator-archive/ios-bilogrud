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

- (id)initRandomShapeWithCenter:(CGPoint)center
{
    //?
    self.shapesCollection =  [NSMutableArray arrayWithObjects:
                              [NSMutableSet setWithObjects:PointToObj(CGPointMake(0, 0)), nil], //None
                              [NSMutableSet setWithObjects:PointToObj(CGPointMake(0, 0)), PointToObj(CGPointMake(1, 0)), PointToObj(CGPointMake(0, 1)), PointToObj(CGPointMake(1, 1)), nil], //SquareShape
                              [NSMutableSet setWithObjects:PointToObj(CGPointMake(1, -1)), PointToObj(CGPointMake(0, 1)), PointToObj(CGPointMake(0, 0)), PointToObj(CGPointMake(1, 0)), nil], //ZShape
                              [NSMutableSet setWithObjects:PointToObj(CGPointMake(-1, 0)), PointToObj(CGPointMake(0, 0)), PointToObj(CGPointMake(0, 1)), PointToObj(CGPointMake(1, 1)), nil], //SShape
                              [NSMutableSet setWithObjects:PointToObj(CGPointMake(-1, -1)), PointToObj(CGPointMake(0, -1)), PointToObj(CGPointMake(0, 0)), PointToObj(CGPointMake(0, 1)), nil], //LShape
                              [NSMutableSet setWithObjects:PointToObj(CGPointMake(1, -1)), PointToObj(CGPointMake(0, -1)), PointToObj(CGPointMake(0, 0)), PointToObj(CGPointMake(0, 1)), nil], //JShape
                              [NSMutableSet setWithObjects:PointToObj(CGPointMake(0, -1)), PointToObj(CGPointMake(0, 0)), PointToObj(CGPointMake(0, 1)), PointToObj(CGPointMake(0, 2)), nil], //IShape
                              [NSMutableSet setWithObjects:PointToObj(CGPointMake(-1, 0)), PointToObj(CGPointMake(0, 0)), PointToObj(CGPointMake(1, 0)), PointToObj(CGPointMake(0, 1)), nil], //TShape
                              nil];

    
//    [NSMutableArray arrayWithObjects:
//                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(0, 0)], nil], //None
//                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(1, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], [[Cell alloc] initWithPoint:CGPointMake(1, 1)], nil], //SquareShape
//                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(1, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(1, 0)], nil], //ZShape
//                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(-1, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], [[Cell alloc] initWithPoint:CGPointMake(1, 1)], nil], //SShape
//                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(-1, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], nil], //LShape
//                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(1, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], nil], //JShape
//                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(0, -1)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], [[Cell alloc] initWithPoint:CGPointMake(0, 2)], nil], //IShape
//                            [NSMutableSet setWithObjects:[[Cell alloc] initWithPoint:CGPointMake(-1, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 0)], [[Cell alloc] initWithPoint:CGPointMake(1, 0)], [[Cell alloc] initWithPoint:CGPointMake(0, 1)], nil], //TShape
//                             nil];
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
        self.centerPoint = center;
    }
    return self;
}

- (NSInteger)randomNumberFrom:(NSInteger)from To:(NSInteger)to
{
   // NSLog(@"%d",from + rand() % (to - from));
    //arc4random()
    return (from + arc4random() % to);
}

- (void)randomTypeShape
{
    TypeShape randomTypeShape = [self randomNumberFrom:1 To:[self.shapesCollection count] - 1];
    self.shapePoints = [self.shapesCollection objectAtIndex:randomTypeShape];
    self.shapeColor = [self.colorsCollection objectAtIndex:randomTypeShape];
    NSLog(@"shape %u", randomTypeShape);
    
}

- (NSMutableSet*)getShapePoints
{
    return [self transformation:self.shapePoints withLocalCentre:self.centerPoint];
}

//return absolute shape coordinates with current center
- (NSMutableSet*)transformation:(NSSet*)localShapePoints withLocalCentre:(CGPoint)cntr
{
    NSMutableSet* shapeLocalSet = [[NSMutableSet alloc] init];
    for (NSValue* v in localShapePoints) {
        //shapePoints addObject:
        CGPoint p = PointFromObj(v);
        p.x += cntr.x;
        p.y += cntr.y;
        [shapeLocalSet addObject:PointToObj(p)];
    }
    return shapeLocalSet;
}

#pragma mark - Move Shape
//deep move, change center of the shape
- (void)deepMove:(DirectionMove)directionMove
{
    self.centerPoint = [self getNextCenter:self.centerPoint withDirection:directionMove];
}
//get move shape for check
- (NSMutableSet*)getMovedShape:(DirectionMove)directionMove
{
    return [self transformation:self.shapePoints withLocalCentre:[self getNextCenter:self.centerPoint withDirection:directionMove]];
}

- (CGPoint)getNextCenter:(CGPoint)localCenter withDirection:(DirectionMove)direction
{
     CGPoint newCenter;
     switch (direction) {
        case (rightDirectionMove):
        {
            newCenter = CGPointMake(localCenter.x+1, localCenter.y);
        }
            break;
        case(leftDirectionMove):
        {
            newCenter = CGPointMake(localCenter.x-1, localCenter.y);
        }
            break;
        case(downDirectionMove):
        {
            newCenter = CGPointMake(localCenter.x, localCenter.y+1);
        }
             break;
        default:
            break;
    }
    return newCenter;
}
@end
