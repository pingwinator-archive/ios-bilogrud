//
//  ViewController.h
//  Control Fun
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIActionSheetDelegate>
@property (retain, nonatomic) IBOutlet UIButton *doSomethingButton;
@property (retain, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (retain, nonatomic) IBOutlet UILabel *sliderLabel;
@property (retain, nonatomic) IBOutlet UITextField *numberField;
@property (retain, nonatomic) IBOutlet UITextField *nameField;
@property (retain, nonatomic) IBOutlet UISwitch *leftSwitch;

-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)backgroundTap:(id)sender;
-(IBAction)sliderChanged:(id)sender;
-(IBAction)switchChanged:(id)sender;
-(IBAction)toggleControls:(id)sender;
-(IBAction)buttonPressed:(id)sender;
@end
