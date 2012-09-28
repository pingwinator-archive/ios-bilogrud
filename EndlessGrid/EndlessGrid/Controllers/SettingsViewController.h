//
//  SettingsViewController.h
//  EndlessGrid
//
//  Created by Natasha on 27.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SettingsViewDelegate;

@interface SettingsViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton* closeButton;
@property(retain, nonatomic) IBOutlet UIButton* addPoint;
@property(retain, nonatomic) IBOutlet UIButton* addLine;
@property(retain, nonatomic) IBOutlet UIButton* addSegment;
@property (nonatomic, assign) id <SettingsViewDelegate> delegate;
@property (nonatomic) ActionType senderActionType;
- (IBAction)closeSetting;
- (IBAction)pressButton:(UIButton*)sender;
@end

@protocol SettingsViewDelegate <NSObject>

- (void)hideSettingsView:(ActionType)actionType;

@end
