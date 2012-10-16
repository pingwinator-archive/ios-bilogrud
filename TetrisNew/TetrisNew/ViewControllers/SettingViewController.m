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
@property (retain, nonatomic) UISwitch* toggleButton;
@property (retain, nonatomic) UILabel* showGridLabel;
@end

@implementation SettingViewController 
@synthesize closeButton;
@synthesize showGrid;
@synthesize toggleButton;
@synthesize showGridLabel;

- (void)dealloc
{
    self.closeButton = nil;
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
    CGRect rect;
    if(isiPhone) {
        rect = CGRectMake(20, 20, 150, 20);
    } else {
        rect = CGRectMake(200, 20, 150, 50);
    }
    
    self.showGridLabel = [[[UILabel alloc] initWithFrame:rect] autorelease];
  
    self.showGridLabel.text = NSLocalizedString(@"Show grid", @"");
    [self.showGridLabel setFont:settingFont];
    
    [self.view addSubview:self.showGridLabel];
     
    self.toggleButton = [[[UISwitch alloc] initWithFrame:CGRectMake(rect.origin.x + 200, rect.origin.y, 50, 50)] autorelease];
    [self.toggleButton setOn:[SettingViewController loadSettingGrid]];
    [self.toggleButton addTarget:self action:@selector(changeToggle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.toggleButton];
    
    //close button
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.closeButton.frame = CGRectMake(self.view.frame.size.width/2 - 30, rect.origin.y + 50, 70, 30);
    [self.closeButton setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)close
{
    [[self parent] deprecatedDismissModalViewControllerAnimated:YES];
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
