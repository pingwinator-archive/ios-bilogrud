//
//  GaneratedData.h
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

@interface GeneratedData : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * number;
+ (id)generatedDataWithNumber: (NSNumber *)numb inContext:(NSManagedObjectContext*)context;
@end
