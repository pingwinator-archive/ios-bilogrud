//
//  Generator.m
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Generator.h"
#import "AppDelegate.h"
#import "GeneratedData.h"
#import "stdlib.h"
@implementation Generator

@synthesize timer;

- (void) dealloc
{
    self.timer = nil;
    [super dealloc];
}

- (NSNumber*)randomNumberFrom:(NSNumber*)from To:(NSNumber*)to
{
    return [NSNumber numberWithInt: [from intValue]+ rand() % ([to intValue]-[from intValue]) ];
}

- (void)doGenerate
{
    NSNumber* numb = [self randomNumberFrom:[NSNumber numberWithInt:5] To:[NSNumber numberWithInt:10]];
    NSLog(@"%@", numb);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:numb.intValue  target:self selector:@selector(fire) userInfo:nil repeats:NO];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    GeneratedData *newData = [NSEntityDescription insertNewObjectForEntityForName:@"GeneratedData" inManagedObjectContext:context];
    if(newData) {
        newData.time = [NSDate date];
        newData.number = numb;
        
        NSError* err = nil;
        if([context save:&err]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ok" message:err.description delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil ];
            [alert show];
            [alert release];
        } else {
            NSLog(@"error with saving");
        }
    } else {
    NSLog(@"error with object");
    }

}

- (void)fire
{
   NSLog(@"fire %@", [NSDate date]);
}
@end
