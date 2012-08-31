//
//  ViewController.h
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(retain, nonatomic)IBOutlet UITextField *userIdField;
@property(retain, nonatomic)IBOutlet UIButton *showInfoButton;

-(IBAction)showInfo;

@end
