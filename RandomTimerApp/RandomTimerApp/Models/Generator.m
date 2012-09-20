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
#import "CoreDataManager.h"
#import "Connect.h"
@interface Generator()

@property (retain, nonatomic) NSString* testData;
@end
@implementation Generator

@synthesize timer;
@synthesize isLocalRandom;
@synthesize testData;
- (void) dealloc
{
    self.timer = nil;
    self.testData = nil;
    [super dealloc];
}

- (NSNumber*)randomNumberFrom:(NSNumber*)from To:(NSNumber*)to
{
    return [NSNumber numberWithInt: [from intValue]+ rand() % ([to intValue]-[from intValue]) ];
}

- (void)doGenerate
{
    self.isLocalRandom = NO;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    self.isLocalRandom = (BOOL)[defaults objectForKey:@"kRandom"];
//    
    NSNumber* numb ;
    if(self.isLocalRandom) {
        numb = [self randomNumberFrom:[NSNumber numberWithInt:5] To:[NSNumber numberWithInt:10]];
        NSLog(@"%@", numb);
    } else {
        numb = [self numberRandomOrg];
        NSLog(@"%@", numb);
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:numb.intValue  target:self selector:@selector(fire) userInfo:nil repeats:NO];
    
    [GeneratedData generatedDataWithNumber:numb inContext:[[CoreDataManager sharedInstance] managedObjectContext]];
}

- (void)fire
{
   NSLog(@"fire %@", [NSDate date]);
    [self doGenerate];
}

- (NSNumber*)numberRandomOrg{
   __block NSNumber* res = [[NSNumber alloc] init] ;
    NSString* stringUrl = @"http://www.random.org/integers/?num=1&min=1&max=5&col=1&base=10&format=plain&rnd=new";
    NSURL* url = [NSURL URLWithString:stringUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    void(^test)(Connect *, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
           NSString* str = [[NSString alloc]  initWithBytes:[con.data bytes]
                                      length:[con.data length] encoding: NSUTF8StringEncoding];
            res = (NSNumber*)[str intValue] ;
            //!!!
        }
    };
    
    [Connect urlRequest:request withBlock:test];
    return res;
}


@end
