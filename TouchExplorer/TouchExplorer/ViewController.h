//
//  ViewController.h
//  TouchExplorer
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UILabel *tapLabel;
@property (nonatomic, retain) IBOutlet UILabel *touchLabel;
-(void)updateLabelsFromTouches : (NSSet *)touches;
@end
