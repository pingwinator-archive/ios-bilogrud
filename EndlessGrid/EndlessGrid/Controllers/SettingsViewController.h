//
//  SettingsViewController.h
//  EndlessGrid
//
//  Created by Natasha on 27.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Shape;
@protocol SettingsViewDelegate;
@protocol CustomShapeDelegate;

@interface SettingsViewController : UIViewController <CustomShapeDelegate>
@property (retain, nonatomic) IBOutlet UIButton* closeButton;
@property (retain, nonatomic) IBOutlet UIButton* addPoint;
@property (retain, nonatomic) IBOutlet UIButton* addLine;
@property (retain, nonatomic) IBOutlet UIButton* addSegment;
@property (retain, nonatomic) IBOutlet UIButton* addCustomPoint;
@property (retain, nonatomic) IBOutlet UIButton* addCustomLine;
@property (retain, nonatomic) IBOutlet UIButton* addCustomSegment;
@property (retain, nonatomic) IBOutlet UIButton* clearBoard;
@property (retain, nonatomic) IBOutlet UIButton* changeColor;
@property (retain, nonatomic) IBOutlet UIImageView* bgImageView;
@property (retain, nonatomic) IBOutlet UIView* settingButtonsView;
@property (nonatomic, assign) id <SettingsViewDelegate> delegate;
@property (nonatomic) ActionType senderActionType;


//@property (retain, nonatomic) NSMutableArray* pointsOfCustomShape;
- (IBAction)pressButton:(UIButton*)sender;
@end

@protocol SettingsViewDelegate <NSObject>

- (void)hideSettingsView:(ActionType)actionType withCustomShape:(Shape*)shape;

@end
