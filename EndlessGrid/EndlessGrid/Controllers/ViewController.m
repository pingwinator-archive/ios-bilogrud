//
//  ViewController.m
//  EndlessGrid
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "GridGraphic.h"
#import "SettingsViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize grid;
@synthesize settingViewController;
@synthesize testButton;
@synthesize bgView;


- (void)dealloc
{
    self.bgView = nil;
    self.settingViewController = nil;
    self.testButton = nil;
    self.grid = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    self.bgView = nil;
    self.settingViewController = nil;
    self.testButton = nil;
    self.grid = nil;
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib {
    
    DBLog(@"awakeFromNib %f", self.grid.frame.size.height);
    [super awakeFromNib];
    
}

- (void)showSetting
{
    [self.settingViewController.view removeFromSuperview];
    self.settingViewController = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    self.settingViewController.delegate = self;
    self.bgView.hidden = NO;
    UIView* settingSmallView = self.settingViewController.view;
  
    settingSmallView.frame = CGRectMake(10, 200, 300, 150);
    settingSmallView.backgroundColor = [UIColor redColor];
   // settingSmallView.alpha = 1.0f;
    
    [self.bgView addSubview:settingSmallView];
 
    self.grid.userInteractionEnabled = NO;
}

- (void)hideSettingsView:(ActionType)senderActionType
{
    [self.settingViewController.view removeFromSuperview];
    self.bgView.hidden = YES;
    self.grid.userInteractionEnabled = YES;
    //[self dismissModalViewControllerAnimated:YES];
    if( senderActionType != kAddNone ) {
        self.grid.actionType = senderActionType;
    }
}
@end