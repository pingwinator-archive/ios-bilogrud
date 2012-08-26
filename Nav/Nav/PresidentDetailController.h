//
//  PresidentDetailController.h
//  Nav
//
//  Created by Natasha on 26.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class President;

#define kNumberOfEditableRows 4 
#define kNameRowIndex 0 
#define kFromYearRowIndex 1 
#define kToYearRowIndex 2 
#define kPartyIndex 3

#define kLabelTag 4096
@interface PresidentDetailController : UITableViewController<UITextFieldDelegate>
@property (retain, nonatomic) President *president;
@property (retain, nonatomic) NSArray *fieldLabels;
@property (retain, nonatomic) NSMutableDictionary *tempValues;
@property (retain, nonatomic) UITextField *currentTextField;

-(IBAction)save:(id)sender;
-(IBAction)cansel:(id)sender;
-(IBAction)textFieldDone:(id)sender;
@end
