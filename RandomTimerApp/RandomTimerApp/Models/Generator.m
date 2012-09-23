//
//  Generator.m
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Generator.h"
#import "AppDelegate.h"
#import "GeneratedData+Helper.h"
#import "stdlib.h"
#import "CoreDataManager.h"
#import "Connect.h"
typedef void (^GenBlock)(NSNumber*);


@interface Generator()
@property (retain, nonatomic) NSTimer* timer;
@end
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

- (void)startGenerator
{
    void(^genBlock)(NSNumber*) = ^(NSNumber* num) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:num.intValue  target:self selector:@selector(startGenerator) userInfo:nil repeats:NO];
        [GeneratedData generatedDataWithNumber:num inContext:[[CoreDataManager sharedInstance] managedObjectContext]];
    };
    [self generateNewNumber: genBlock];
}
- (void)stopGenerator
{
    [self.timer invalidate];
}

- (void)generateNewNumber: (GenBlock) genBLock
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"kRandom"]){
        NSNumber* numb = [self randomNumberFrom:[NSNumber numberWithInt:5] To:[NSNumber numberWithInt:10]];
        if (genBLock) {
            genBLock(numb);
        }
    } else {
           DBLog(@"<<<<<<<<<<<<<no!");
        NSString* stringUrl = @"http://www.random.org/integers/?num=1&min=1&max=5&col=1&base=10&format=plain&rnd=new";
        NSURL* url = [NSURL URLWithString:stringUrl];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        
        void(^test)(Connect *, NSError *) = ^(Connect *con, NSError *err){
            if(!err){
                NSString* str = [[[NSString alloc] initWithData:con.data
                                                       encoding:NSUTF8StringEncoding] autorelease];
                str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber * res = [f numberFromString:str];
                [f release];
                if (genBLock) {
                    genBLock(res);
                }
            }
        };
        [Connect urlRequest:request withBlock:test];      
    }
}
@end
