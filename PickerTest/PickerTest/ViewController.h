//
//  ViewController.h
//  PickerTest
//
//  Created by Natasha on 25.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton* cameraButton;
@property (strong, nonatomic) IBOutlet UIButton* libraryButton;
- (IBAction)imageFromCamera;
- (IBAction)imageFromLibrary;
@end
