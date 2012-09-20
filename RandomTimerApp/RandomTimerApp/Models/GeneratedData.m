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

+ (id) generatedDataWithNumber: (NSNumber *)numb inContext:(NSManagedObjectContext*)context
{
    GeneratedData *data = [NSEntityDescription insertNewObjectForEntityForName:@"GeneratedData" inManagedObjectContext:context];

    data.time = [NSDate date];
    data.number = numb;
    NSError *err = NULL;
    [context save: &err];
    
    if(err)
    {
        DBLog(@"check error: %@", err.description);
    } 
        
    return data;
}
@end
