//
//  NSDate+DateFormat.m
//  FacebookSDKApp
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "NSDate+DateFormat.h"
#define monthInSeconds (30 * dayInSeconds)
#define weekInSeconds (7 * dayInSeconds)
#define dayInSeconds 24 * hourInSeconds
#define hourInSeconds 60 * minInSeconds
#define minInSeconds 60
@implementation NSDate (DateFormat)

- (NSString*)dateStringWithFormat
{
    NSString* result = @"";
    NSDate *now = [NSDate date];
    NSTimeInterval timeTest = [now timeIntervalSinceDate:self];
    NSLog(@"%d", (int)timeTest);
    NSInteger timeTestInteger = (NSInteger) timeTest;
    
    NSLog(@"hour : %d", hourInSeconds);
    if(timeTestInteger > monthInSeconds) {
        int amountMonth = timeTestInteger / (monthInSeconds) ;
        if(amountMonth > 1) {
            result = [result stringByAppendingFormat:NSLocalizedString(@"more %[one, some, many, none]d monthes ago", @""), amountMonth ];
        } else {
            result = [result stringByAppendingFormat:NSLocalizedString(@"more %d month ago", @""), amountMonth ];
        }
    } else if (timeTestInteger > weekInSeconds) {
        int amountWeek = timeTestInteger / (weekInSeconds);
        if(amountWeek > 1) {
            result = [result stringByAppendingFormat:NSLocalizedString(@"near %d weeks ago",@""), amountWeek];
        } else {
            result = [result stringByAppendingFormat:NSLocalizedString(@"near one week ago", @"")];
        }
    } else if (timeTestInteger > dayInSeconds) {
        int amountDay = timeTestInteger / (dayInSeconds);
        if(amountDay > 1) {
            result = [result stringByAppendingFormat:NSLocalizedString(@"near %d days ago", @""), amountDay];
        } else {
            result = [result stringByAppendingFormat:NSLocalizedString(@"near a day ago", @"")];
        }
    } else if (timeTestInteger > hourInSeconds) {
     //   id check = timeTestInteger / hourInSeconds;
        NSNumber* test = [NSNumber numberWithInt:timeTestInteger/hourInSeconds];
        NSLog(@"%@", test);
        int amountHour = timeTestInteger / (hourInSeconds);
        if(amountHour > 1) {
            result = [result stringByAppendingFormat:NSLocalizedString(@"near %d hours ago", @""), amountHour];
        } else {
            result = [result stringByAppendingFormat:NSLocalizedString(@"near an hour ago", @"")];
        }
    } else if(timeTestInteger > minInSeconds) {
        int amountMin = timeTestInteger / (minInSeconds);
        if(amountMin > 1) {
            result = [result stringByAppendingFormat:NSLocalizedString(@"near %d minutes ago", @""), amountMin];
        } else {
            result = [result stringByAppendingFormat:NSLocalizedString(@"near a minute ago", @"")];
        }
    } else {
        result = [result stringByAppendingFormat:NSLocalizedString(@"several seconds ago", @"")];
    }
       return result;
}
@end
