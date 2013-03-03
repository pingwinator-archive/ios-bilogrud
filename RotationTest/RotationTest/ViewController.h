//
//  ViewController.h
//  RotationTest
//
//  Created by Natasha on 02.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView* imageView;
@property (strong, nonatomic) IBOutlet UIButton* cancelButton;
@property (strong, nonatomic) IBOutlet UIButton* stepButton;
@property (strong, nonatomic) IBOutlet UIButton* doneButton;

- (IBAction)cancel:(id)sender;
- (IBAction)step:(id)sender;
- (IBAction)done:(id)sender;
@end
