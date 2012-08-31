//
//  ViewController.m
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize showInfoButton;
@synthesize userIdField;

-(void)dealloc{
    self.showInfoButton = nil;
    self.userIdField = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Start";
    //self.navigationController.navigationBarHidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)showInfo{
    InfoViewController *detail = [[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
    detail.userIdValue = self.userIdField.text;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)viewWillDisappear:(BOOL)animated{
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
