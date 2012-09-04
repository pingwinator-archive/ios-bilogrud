//
//  AppDelegate.m
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}
-(void)test:(NSString*)stringFirst second:(NSString*)stringSecond block:(void(^)(NSString*, NSString*))blockVar
{
    if (blockVar) {
        blockVar(stringFirst, stringSecond);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    
//    void (^x)(NSString*, NSString*) = ^(NSString* string1, NSString* string2){
//        //NSL92'o2'g(@"%@\n%@", string1, string2);
//        NSLog(@"%@", [NSString stringWithFormat:@"%@-------%@", string1, string2]);
//    };
////   NSLog(@"%@", x(@"first", @"second"));
////    
////
//    [self test:@"111" second:@"222" block:^(NSString *str1, NSString *str2){
//        NSLog(@"%@",[NSString stringWithFormat:@"%@%@", str1, str2]);
//    }];
//    
//    [self test:@"111" second:@"222" block:x];
//    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
