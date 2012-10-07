//
//  DefineConst.h
//  Tetris
//
//  Created by Natasha on 29.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#ifndef Tetris_DefineConst_h
#define Tetris_DefineConst_h

#define boardBorderWidth 5
#define boardGridWidth 3

#define isiPhone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#ifdef DEBUGGING
# define DBLog(fmt,...) NSLog(@"%@",[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);
#else
# define DBLog(...)
#endif


//tetris const
typedef enum {
    downDirectionMove,
    rightDirectionMove,
    leftDirectionMove
} DirectionMove;
typedef enum {
    rightDirectionRotate,
    leftDirectionRotate
} DirectionRotate;
#endif
