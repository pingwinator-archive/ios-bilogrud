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

//http://stackoverflow.com/questions/1902021/suppressing-is-deprecated-when-using-respondstoselector
#define DISABLE_DEPRICADETED_WARNINGS_BEGIN _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\" ")
#define DISABLE_DEPRICADETED_WARNINGS_END _Pragma("clang diagnostic pop")

//tetris const
#define boardBorderWidth 2
#define boardGridWidth 2

#define offSetBorderThin 3
#define borderThin 2
#define offsetBorderThick 8
#define borderThick 3

//buttons
#define settingSizeButton 30
#define manageSizeButton 30
#define moveSizeButton 40
#define rotateSizeButton 60

#define settingFont [UIFont fontWithName:@"American Typewriter" size:20]
#define textButtonFont [UIFont fontWithName:@"American Typewriter" size:12]
#define scoreFont [UIFont fontWithName:@"DS-Digital" size:45]

#define scoreLabelWidth 50
#define scoreLabelHeigth 50
#define labelPlayTextWidth 45
#define labelPlayTextHeigth 40
#define labelMoveTextWidth 40
#define labelMoveTextHeigth 20
#define labelScoreWidth 50
#define labelScoreHeigth 50
#define PointToObj(point) [NSValue valueWithCGPoint:point]
#define PointFromObj(value) [value CGPointValue]

#define delayForButtonPressed 0.3

#define kShowGrid @"grid"
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
