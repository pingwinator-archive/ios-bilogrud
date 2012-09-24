//
//  StatusViewController.h
//  FacebookSDKApp
//
//  Created by Natasha on 10.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connect.h"

@interface StatusViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) IBOutlet UIButton* photoButton;
@property (nonatomic, retain) IBOutlet UITextView* statusInput;
@property (nonatomic, retain) IBOutlet UIImageView* prePostingImage;
@property (nonatomic, retain) IBOutlet UIImageView* baseView;
@property (nonatomic, retain) IBOutlet UIView* activityView;
@property (nonatomic, retain) UIImage* postingImage;
@property (nonatomic, assign) BOOL hasCamera;

-(IBAction)pressPhoto;
@end
