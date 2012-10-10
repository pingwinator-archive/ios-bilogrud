//
//  SettingViewController.h
//  TetrisNew
//
//  Created by Natasha on 10.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (assign, nonatomic) BOOL showGrid;
+ (BOOL)loadSettingGrid;
+ (void)saveSettingGrid:(BOOL)grid;
@end
