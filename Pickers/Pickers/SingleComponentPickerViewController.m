//
//  SingleComponentPickerViewController.m
//  Pickers
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SingleComponentPickerViewController.h"

@interface SingleComponentPickerViewController ()

@end

@implementation SingleComponentPickerViewController
@synthesize singlePicker;
@synthesize pickerData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)buttonPressed{
    NSInteger row = [singlePicker selectedRowInComponent:0];
    NSString *selected = [pickerData objectAtIndex:row];
    NSString *title = [[NSString alloc] initWithFormat:@"You selected %@!", selected];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"Thank you for choosing."
                        delegate:nil cancelButtonTitle:@"You're Welcome"
                        otherButtonTitles:nil];
    [alert show];
    [alert release];
    [title release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array = [[NSArray alloc] initWithObjects:@"Luke", @"Leia",
                      @"Han", @"Chewbacca", @"Artoo", @"Threepio", @"Lando", nil];
    self.pickerData = array;
    
    [array release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.singlePicker = nil;
    self.pickerData = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc{
    [singlePicker release];
    [pickerData release];
    [super dealloc];
}
#pragma mark Picker Data Source Methods
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

#pragma mark Picker Delegate Methods
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerData objectAtIndex:row];
}

@end
