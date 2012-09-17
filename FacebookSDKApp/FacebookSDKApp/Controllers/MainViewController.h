//
//  MainViewController.h
//  FacebookSDKApp
//
//  Created by Natasha on 10.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfloadImage.h"
@interface MainViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel* tokenLabel;
@property (nonatomic, retain) IBOutlet UILabel* nameLabel;
@property (nonatomic, retain) IBOutlet SelfloadImage* userImageView;
@property (nonatomic, retain) IBOutlet UIButton* createStatusButton;
@property (nonatomic, retain) IBOutlet UIButton* showFeedButton;
@property (nonatomic, retain) IBOutlet UIButton* logOutButton;

-(IBAction)createStatus;
-(IBAction)showFeed;
-(IBAction)logOut;
@end
