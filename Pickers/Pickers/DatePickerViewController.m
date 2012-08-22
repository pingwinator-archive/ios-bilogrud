//
//  DatePickerViewController.m
//  Pickers
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
{
    NSString* lalala;
}

@end

@implementation DatePickerViewController

@synthesize datePicker;

-(void) dealloc{
    [datePicker release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDate *now = [NSDate date];
    
    [datePicker setDate:now animated:NO];
    lalala = [[NSString alloc] initWithString:@"fdsfds"];
    lalala = [[NSString alloc] initWithString:@"fdsfdsdsfds"];
    lalala = [[NSString alloc] initWithString:@"fdsfdsdfg"];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.datePicker = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)buttonPressed{
    NSDate *selected = [datePicker date];
    NSString *message = [[NSString alloc]initWithFormat:
                         @"The date and time you selected is: %@",selected];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Date and Time Selected"
                message:message delegate:nil cancelButtonTitle:@"Yes, I did." otherButtonTitles:nil];
    [alert show];
    [message release];
    [alert release];
}
@end
