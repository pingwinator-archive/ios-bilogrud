//
//  DatePickerViewController.h
//  Pickers
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIDatePicker* datePicker;
-(IBAction)buttonPressed;
@end
