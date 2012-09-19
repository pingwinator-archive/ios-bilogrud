//
//  SettingViewController.m
//  RandomTimerApp
//
//  Created by Natasha on 19.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize cleanCD;
@synthesize switchTypeGenerator;

- (void)dealloc
{
    self.cleanCD = nil;
    self.switchTypeGenerator = nil;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)cleanCoreData
{}

- (void)changeTypeGenerator
{
    NSLog(@"change");
    
    if([switchTypeGenerator isOn]) {
    
    } else {
    
    }
}
@end
