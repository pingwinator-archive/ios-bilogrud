//
//  SingleComponentPickerViewController.h
//  Pickers
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleComponentPickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (retain, nonatomic) IBOutlet UIPickerView* singlePicker;
@property (retain, nonatomic) NSArray* pickerData;
-(IBAction)buttonPressed;
@end
