//
//  AppDelegate.h
//  Reader
//
//  Created by Natasha on 12.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StartViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) StartViewController *startViewController;
@property (strong, nonatomic) UINavigationController *navController;
@property (nonatomic) NSInteger pageNumber;
@end
