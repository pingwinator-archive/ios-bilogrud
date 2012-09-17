//
//  ViewController.m
//  Persistence
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#define kFileName @"data.plist"
@interface ViewController ()

@end

@implementation ViewController
@synthesize field1;
@synthesize field2;
@synthesize field3;
@synthesize field4;

-(NSString *)dataFilePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
}
- (void)applicationWillResignActive:(NSNotification *)notification {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:field1.text];
    [array addObject:field2.text];
    [array addObject:field3.text];
    [array addObject:field4.text];
    [array writeToFile:[self dataFilePath] atomically:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        field1.text = [array objectAtIndex:0];
        field2.text = [array objectAtIndex:1];
        field3.text = [array objectAtIndex:2];
        field4.text = [array objectAtIndex:3];
    }
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.field1 = nil;
    self.field2 = nil;
    self.field3 = nil;
    self.field4 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
