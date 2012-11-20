//
//  StatisticManager.m
//  TetrisNew
//
//  Created by Natasha on 13.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "StatisticManager.h"


@implementation StatisticManager

+ (void)initStatistic
{
#ifndef DEBUG
    [Flurry startSession: flurryKey];
#endif
}

+ (void)logMessage:(NSString*)message
{
#ifndef DEBUG
    [Flurry logEvent:message];
#endif
}

+ (void)sendScoreGame:(NSInteger)score
{
#ifndef DEBUG
    NSString *tmpString = [NSString stringWithFormat:@"Total Score: %d", score, nil];
    NSDictionary* scoreParametrs = [NSDictionary dictionaryWithObjectsAndKeys: tmpString, scoreGameKey, nil];
    [Flurry logEvent:scoreGameMessage withParameters:scoreParametrs];
#endif
}
@end
