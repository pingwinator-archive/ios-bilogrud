//
//  GaneratedData.h
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GaneratedData : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * number;

@end
