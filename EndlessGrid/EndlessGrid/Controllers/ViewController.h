//
//  ViewController.h
//  EndlessGrid
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GridGraphic;
@class SettingsViewController;
@protocol SettingsViewDelegate;

@interface ViewController : UIViewController<SettingsViewDelegate>

@property(retain, nonatomic) IBOutlet GridGraphic* grid;
@property(retain, nonatomic)  SettingsViewController* settingViewController;
@property(retain, nonatomic) IBOutlet UIButton* testButton;
@property(retain, nonatomic) IBOutlet UIView* bgView;

- (IBAction)showSetting;
- (void)hideSettingsView;
@end
