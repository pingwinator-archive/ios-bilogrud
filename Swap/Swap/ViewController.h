//
//  ViewController.h
//  Swap
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *bars;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *foos;
@property (retain, nonatomic) IBOutlet UIView *landscape;
@property (retain, nonatomic) IBOutlet UIView *portrait;
- (IBAction)buttonTapped:(id)sender;
@end
