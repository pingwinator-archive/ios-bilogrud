//
//  GaneratedData.m
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "GeneratedData.h"


@implementation GeneratedData

@dynamic time;
@dynamic number;
- (GeneratedData *) initWithNumber: (NSNumber *)numb{
    GeneratedData *data = [[GeneratedData alloc]init];
    data.time = (NSDate *)[NSDate date];
    data.number = numb;
    return data;
}
@end
