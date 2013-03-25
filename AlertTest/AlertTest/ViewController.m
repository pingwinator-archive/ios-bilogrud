//
//  ViewController.m
//  AlertTest
//
//  Created by Natasha on 14.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "AlertView.h"

@interface ViewController ()
@property (strong, nonatomic) UIButton* button;
@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
	// Do any additional setup after loading the view, typically from a nib.
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame = CGRectMake(100, 100, 120, 50);
    [self.button setTitle:@"Show alert" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)showAlert
{
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//    [alert show]; 
    AlertView* alert = [[AlertView alloc] initWithTitle:@"Start over?" message:@"Are you sure?\nYou'll lose all your changes.." delegate:self cancelButtonTitle:@"No, do nothing" doneButtonTitles:@" Yup"];
    [self.view addSubview:alert];
    [self.view bringSubviewToFront: alert];
}

- (void)alertView:(UIAlertView *)alertView clickedButton:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"cancel");
    }
    if (buttonIndex == 0) {
        NSLog(@"ok");
    }
}

@end
