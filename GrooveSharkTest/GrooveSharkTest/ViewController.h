//
//  ViewController.h
//  GrooveSharkTest
//
//  Created by Natasha on 17.07.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField* searchField;
@property (strong, nonatomic) IBOutlet UIButton* searchButton;
@property (strong, nonatomic) IBOutlet UITextView* resultText;

- (IBAction) doSearch:(id)sender;
@end
