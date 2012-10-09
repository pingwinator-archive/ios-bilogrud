//
//  DefineConst.h
//  Tetris
//
//  Created by Natasha on 29.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#ifndef Tetris_DefineConst_h
#define Tetris_DefineConst_h


#define isiPhone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#ifdef DEBUGGING
# define DBLog(fmt,...) NSLog(@"%@",[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);
#else
# define DBLog(...)
#endif


//tetris const
#define boardBorderWidth 3
#define boardGridWidth 2

#define offSetBorderThin 3
#define borderThin 2
#define offsetBorderThick 8
#define borderThick 3

//buttons
#define playSizeButton 30
#define moveSizeButton 40
#define textButtonFont [UIFont fontWithName:@"American Typewriter" size:12]
#define labelMoveTextWidth 50
#define labelMoveTextHeigth 20

#define PointToObj(point) [NSValue valueWithCGPoint:point]
#define PointFromObj(value) [value CGPointValue]

typedef enum {
    downDirectionMove,
    rightDirectionMove,
    leftDirectionMove
} DirectionMove;
typedef enum {
    rightDirectionRotate,
    leftDirectionRotate
} DirectionRotate;

typedef enum {
    NoShape,
    SquareShape,
    ZShape,
    SShape,
    LShape,
    JShape,
    IShape,
    TShape
} TypeShape;

#endif
