//
//  DependentComponentPickerViewController.h
//  Pickers
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStateComponent 0
#define kZipComponent 1
@interface DependentComponentPickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (retain, nonatomic) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) NSDictionary *stateZips;
@property (retain, nonatomic) NSArray *states;
@property (retain, nonatomic) NSArray *zips;

-(IBAction)buttonPressed;
@end
