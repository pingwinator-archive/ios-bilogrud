//
//  ViewController.h
//  FacebookSDKApp
//
//  Created by Natasha on 10.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface LoginViewController : UIViewController

@property(nonatomic, retain) IBOutlet UIButton* singInButton;

-(IBAction)authButtonAction;
@end
