//
//  ViewController.h
//  CustomFolderApp
//
//  Created by Natasha on 13.02.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton* showPhotoButton;
@property (strong, nonatomic) IBOutlet UIButton* savePhotoButton;
- (IBAction)showPhoto;
- (IBAction)savePhoto;
@end
