//
//  ViewController.h
//  Button Fun
//
//  Created by Natasha on 20.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIButton *leftButton;
    IBOutlet UIButton *rightButton;
    IBOutlet UILabel *statusText;
}
- (IBAction)buttonPressed:(id)sender;

@property (nonatomic, retain) UIButton* leftButton;
@property (nonatomic, retain) UIButton* rightButton;
@property (nonatomic, retain) UILabel* statusText;

@end




