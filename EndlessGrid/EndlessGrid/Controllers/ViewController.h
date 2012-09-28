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

@interface ViewController : UIViewController

@property(retain, nonatomic) IBOutlet GridGraphic* grid;
@property(retain, nonatomic)  SettingsViewController* settingViewController;
@property(retain, nonatomic) IBOutlet UIButton* testButton;

-(IBAction)test;//:(id)sender
@end
