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
#define isiPad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
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
#define boardGridWidth 1
#define cellGridWidth 2

#define offSetBorderThin 3
#define borderThin 2
#define offsetBorderThick 8
#define borderThick 3

//buttons
#define settingSizeButton 40
#define manageSizeButton 40
#define moveSizeButton 50
#define rotateSizeButton 70
#define manageSizeButtoniPad 50
#define moveSizeButtoniPad 70
#define rotateSizeButtoniPad 110

#define distanceManageButtonAndLabel (manageSizeButton - 5)
#define distanceMoveButtonAndLabel (moveSizeButton - 5)
#define distanceRotateButtonAndLabel (rotateSizeButton - 5)

#define settingFont [UIFont fontWithName:@"American Typewriter" size:20]
#define textButtonFont [UIFont fontWithName:@"American Typewriter" size:10]
#define scoreFont [UIFont fontWithName:@"DS-Digital" size:15]
#define scoreFontLarge [UIFont fontWithName:@"DS-Digital" size:20]
#define scoreFontiPad [UIFont fontWithName:@"DS-Digital" size:30]

#define scoreLabelWidth 50
#define scoreLabelHeigth 50
#define speedLabelWidth 50
#define speedLabelHeigth 50
#define labelPlayTextWidth 35
#define labelPlayTextHeigth 40
#define labelManageTextWidth 70
#define labelMoveTextWidth 60
#define labelRotateTextWidth 60
#define labelTextHeigth 20
#define labelScoreWidth 50
#define labelScoreHeigth 50
#define labelManageOffset 15
#define labelMoveOffset 10
#define labelRotateOffset 10

#define labelOffsetHeight 10
#define imageOffsetHeight 10
#define imageOffsetHeightiPad 30
#define PointToObj(point) [NSValue valueWithCGPoint:point]
#define PointFromObj(value) [value CGPointValue]

#define delayForButtonPressed 0.3

#define kShowGrid @"grid"
#define kShowColor @"showColorShape"
#define kShowTutorial @"showTutorial"
#define delayForSubView 0.3

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
