//
//  ViewController.m
//  Button Fun
//
//  Created by Natasha on 20.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize rightButton;
@synthesize leftButton;
@synthesize statusText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [statusText release];
    statusText = nil;
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonPressed:(id)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    statusText.text = [NSString stringWithFormat:@"%@ button pressed.", title];
}

- (void)dealloc {
    [leftButton release];
    [rightButton release];
    [statusText release];

    [super dealloc];
}
@end
