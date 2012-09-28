//
//  GridGraphic.h
//  EndlessGrid
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingView;
@protocol SettingsViewDelegate;

@interface GridGraphic : UIView <SettingsViewDelegate>
@property (retain, nonatomic) NSNumber* cellHeight;
@property (retain, nonatomic) NSNumber* cellWidth;
@property (assign, nonatomic) CGFloat gridOffsetX;
@property (assign, nonatomic) CGFloat gridOffsetY;
//@property (assign, nonatomic) CGPoint gridOffset;
@property (assign, nonatomic) CGRect rectDrawing;
@property (retain, nonatomic) IBOutlet UIButton* settingButton;
@property (retain, nonatomic) IBOutlet SettingView* settingView;
//@property(retain, nonatomic) IBOutlet UIView* bgForSetting;
- (IBAction)showSetting;
@end
