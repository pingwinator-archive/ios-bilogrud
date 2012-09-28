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
    kAddSegment
} ActionType;

#define kAddPointTag 1
#define kAddLineTag 2
#define kAddSegmentTag 3
#define kOnlyClose 0

#define radPoint 4.0f



#ifdef DEBUGGING
# define DBLog(fmt,...) NSLog(@"%@",[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);
#else
# define DBLog(...)
#endif


#endif
