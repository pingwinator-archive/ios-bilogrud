//
//  ViewController.h
//  EndlessGrid
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
@class GridGraphic;
@interface ViewController : UIViewController<SettingsViewDelegate, UIPopoverControllerDelegate>

@property(retain, nonatomic) IBOutlet GridGraphic* grid;
@property(retain, nonatomic)  SettingsViewController* settingViewController;
@property(retain, nonatomic) IBOutlet UIButton* showSettingButton;
@property(retain, nonatomic) IBOutlet UIView* bgView;
@property (retain, nonatomic) UIPopoverController* popover;
- (IBAction)showSetting;
@end
