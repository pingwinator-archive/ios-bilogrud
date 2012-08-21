//
//  SwitchViewController.h
//  ViewSwitcher
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YellowViewController;
@class BlueViewController;

@interface SwitchViewController : UIViewController
@property (retain, nonatomic) YellowViewController* yellowViewController;
@property (retain, nonatomic) BlueViewController* blueViewController;

-(IBAction)switchViews:(id)sender;
@end
