//
//  DoubleComponentPickerViewController.h
//  Pickers
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kFillingComponent 0
#define kBreadComponent 1

@interface DoubleComponentPickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (retain, nonatomic) IBOutlet UIPickerView *doublePicker;
@property (retain, nonatomic) NSArray *fillingTypes;
@property (retain, nonatomic) NSArray *breadTypes;

-(IBAction)buttonPressed;
@end
