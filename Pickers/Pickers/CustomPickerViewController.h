//
//  CustomPickerViewController.h
//  Pickers
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (retain, nonatomic) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) IBOutlet UILabel *winLabel;
@property (retain, nonatomic) NSArray *column1;
@property (retain, nonatomic) NSArray *column2;
@property (retain, nonatomic) NSArray *column3;
@property (retain, nonatomic) NSArray *column4;
@property (retain, nonatomic) NSArray *column5;

-(IBAction)spin;
@end
