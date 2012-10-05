//
//  DefConst.h
//  EndlessGrid
//
//  Created by Natasha on 28.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#ifndef EndlessGrid_DefConst_h
#define EndlessGrid_DefConst_h

typedef enum {
    kAddNone, 
    kAddPoint,
    kAddLine,
    kAddSegment,
    kAddCustomPoint,
    kAddCustomLine,
    kAddCustomSegment,
    kClearBoard,
    kChangeColor
} ActionType;
#define kOnlyClose 0
#define kAddPointTag 1
#define kAddLineTag 2
#define kAddSegmentTag 3
#define kAddCustomPointTag 4
#define kAddCustomLineTag 5
#define kAddCustomSegmentTag 6
#define kClearBoardTag 7
#define kChangeColorTag 8

#define radPoint 10.0f
#define kCellHeight_iPhone 40.0
#define kCellWidth_iPhone 40.0
#define kCellHeight_iPad 40.0
#define kCellWidth_iPad 40.0
#define minZoom 20
#define maxZoom 70

#define startFrameForSubview CGRectMake(0, 0, 300, 260)

#ifdef DEBUGGING
# define DBLog(fmt,...) NSLog(@"%@",[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);
#else
# define DBLog(...)
#endif

#define delayForSubView 0.3
#define isiPhone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#endif
