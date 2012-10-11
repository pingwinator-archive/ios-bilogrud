//
//  SettingViewController.m
//  TetrisNew
//
//  Created by Natasha on 10.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingViewController.h"
#import "UIViewController+Deprecated.h"
@interface SettingViewController ()
@property (retain, nonatomic) UIButton* closeButton;
@property (retain, nonatomic) UIButton* showGridCheckBox;
@property (retain, nonatomic) UISwitch* toggleButton;
@property (retain, nonatomic) UILabel* showGridLabel;
@end

@implementation SettingViewController 
@synthesize closeButton;
@synthesize showGrid;
@synthesize showGridCheckBox;
@synthesize toggleButton;
@synthesize showGridLabel;

- (void)dealloc
{
    self.closeButton = nil;
    self.showGridCheckBox = nil;
    self.showGridLabel = nil;
    self.toggleButton = nil;
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
      self.showGrid = [SettingViewController loadSettingGrid];
    
    self.showGridLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 20, 100, 50)];
    self.showGridLabel.text = @"Show grid";
    [self.showGridLabel setFont:settingFont];
    
    [self.view addSubview:self.showGridLabel];
    [self.showGridLabel release];
    
    self.toggleButton = [[UISwitch alloc] initWithFrame:CGRectMake(400, 30, 50, 50)];
    [self.toggleButton setOn:[SettingViewController loadSettingGrid]];//.isSelected = self.showGrid;
    [self.toggleButton addTarget:self action:@selector(changeToggle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.toggleButton];
    [self.toggleButton release];
   
    //close button
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGRect manageButton = CGRectMake(300, 100, 100, 40);
    self.closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.closeButton.frame = manageButton;
    [self.closeButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    [self.closeButton release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)close
{
//    if([self.delegate respondsToSelector:@selector(closeSetting)]) {
//        [self.delegate closeSetting];
//    }
 //   [self.parentViewController deprecatedDismissModalViewControllerAnimated:YES];
    if (self.parentViewController)
    {
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    }
    else if( [self respondsToSelector: @selector( presentingViewController )] && [self presentingViewController])
    {
        [self.presentingViewController dismissModalViewControllerAnimated:YES];
    }
}

-(void)changeToggle
{
    self.showGrid = !self.showGrid;
    
    [SettingViewController saveSettingGrid:self.showGrid];
}

+ (void)saveSettingGrid:(BOOL)grid
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setBool:grid forKey:kShowGrid];
}

+ (BOOL)loadSettingGrid
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    return [def boolForKey:kShowGrid];
}

@end
