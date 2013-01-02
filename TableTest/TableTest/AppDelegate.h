//
//  AppDelegate.h
//  TableTest
//
//  Created by Natasha on 30.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class TableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TableViewController *viewController;

@end
