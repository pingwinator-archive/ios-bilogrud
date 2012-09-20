//
//  SettingViewController.h
//  RandomTimerApp
//
//  Created by Natasha on 19.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton* cleanCD;
@property (retain, nonatomic) IBOutlet UISwitch* switchTypeGenerator;
@property (retain, nonatomic) IBOutlet UILabel* textSwitchLabel;
- (IBAction)cleanCoreData;
- (IBAction)engineSwitchTapped;

@end
