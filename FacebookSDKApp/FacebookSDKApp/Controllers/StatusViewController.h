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
@property (nonatomic, retain) IBOutlet UIButton* sendPhotoButton;
@property (nonatomic, retain) IBOutlet UITextView* statusInput;
@property (nonatomic, retain) UIImage* postingImage;
-(IBAction)pressPhoto;
-(IBAction)sendPhoto;
@property(nonatomic, assign) BOOL camera;
@end
