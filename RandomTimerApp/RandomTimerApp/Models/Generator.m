//
//  Generator.m
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Generator.h"

@implementation Generator

@synthesize timer;
-(NSNumber*)randomNumberFrom:(NSNumber*)from To:(NSNumber*)to{
    return [NSNumber numberWithInt:5];
}
-(void)doGenerate
{
    NSNumber* numb = [self randomNumberFrom:[NSNumber numberWithInt:5] To:[NSNumber numberWithInt:10]];
    NSLog(@"%@", [NSDate date]);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:numb.intValue  target:self selector:@selector(fire) userInfo:nil repeats:YES];
    
    
/*
 AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
 NSManagedObjectContext* context = appDelegate.managedObjectContext;
 Person* newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
 if(newPerson){
 newPerson.firstName = self.textFieldFirstName.text;
 newPerson.lastName = self.textFieldLastName.text;
 newPerson.age = [NSNumber numberWithInteger:[self.textFieldAge.text integerValue]];
 
 NSError* err = nil;
 if([context save:&err]){
 [self.navigationController popViewControllerAnimated:YES];
 } else {
 NSLog(@"error with saving");
 }
 } else {
 NSLog(@"error with object");
 }

 */
}

- (void)fire
{
    NSLog(@"fire %@", [NSDate date]);
}
@end
