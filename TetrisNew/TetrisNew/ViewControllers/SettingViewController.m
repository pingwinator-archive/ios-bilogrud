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
@property (retain, nonatomic) UISwitch* toggleShowGridButton;
@property (retain, nonatomic) UISwitch* toggleAddColorButton;
@property (retain, nonatomic) UISwitch* toggleShowTutorial;
@end

@implementation SettingViewController 
@synthesize closeButton;
@synthesize showGrid;
@synthesize showColor;
@synthesize showTutorial;
@synthesize toggleShowGridButton;
@synthesize toggleAddColorButton;
@synthesize toggleShowTutorial;
- (void)dealloc
{
    self.closeButton = nil;
    self.toggleAddColorButton = nil;
    self.toggleShowGridButton = nil;
    self.toggleShowTutorial = nil;
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
    self.showColor = [SettingViewController loadSettingColor];
    self.showTutorial = [SettingViewController loadSettingTutorial];
    CGRect rect;
    if(isiPhone) {
        rect = CGRectMake(20, 20, 150, 20);
        UILabel* showGridLabel = [[[UILabel alloc] initWithFrame:rect] autorelease];
        showGridLabel.text = NSLocalizedString(@"Show grid", @"");
        [showGridLabel setFont:settingFont];
        [self.view addSubview: showGridLabel];
        
        self.toggleShowGridButton = [[[UISwitch alloc] initWithFrame:CGRectMake(rect.origin.x + 200, rect.origin.y, 50, 50)] autorelease];
        [self.toggleShowGridButton setOn:[SettingViewController loadSettingGrid]];
        [self.toggleShowGridButton addTarget:self action:@selector(changeShowGridToggle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleShowGridButton];
        
        //color setting
        CGRect rectForColor = CGRectMake(rect.origin.x, rect.origin.y + 50, 150, 20);
        UILabel* showColorLabel = [[[UILabel alloc] initWithFrame:rectForColor] autorelease];
        showColorLabel.text = NSLocalizedString(@"Add color", @"");
        [showColorLabel setFont:settingFont];
 
        [self.view addSubview:showColorLabel];
        
        self.toggleAddColorButton = [[[UISwitch alloc] initWithFrame:CGRectMake(rectForColor.origin.x + 200, rectForColor.origin.y, 50, 50)] autorelease];
        [self.toggleAddColorButton setOn:[SettingViewController loadSettingColor]];
        [self.toggleAddColorButton addTarget:self action:@selector(changeColorToggle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleAddColorButton];
        
        //tutorial setting
        CGRect rectForTutorial = CGRectMake(rect.origin.x, rect.origin.y + 100, 150, 20);
        UILabel* showTutorLabel = [[[UILabel alloc] initWithFrame:rectForTutorial] autorelease];
        showTutorLabel.text = NSLocalizedString(@"Show hints", @"");
        [showTutorLabel setFont:settingFont];
        [self.view addSubview:showTutorLabel];
        
        self.toggleShowTutorial = [[[UISwitch alloc] initWithFrame:CGRectMake(rectForTutorial.origin.x + 200, rectForTutorial.origin.y, 50, 50)] autorelease];
        [self.toggleShowTutorial setOn:[SettingViewController loadSettingTutorial]];
        [self.toggleShowTutorial addTarget:self action:@selector(changeTutorialToggle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleShowTutorial];
        
        //close button
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.closeButton.frame = CGRectMake(self.view.frame.size.width/2 - 30, rectForColor.origin.y + 100, 70, 30);
        [self.closeButton setTitle:NSLocalizedString(@"Ok", @"") forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.closeButton];
    } else {
        CGSize viewSize = self.contentSizeForViewInPopover;
        rect = CGRectMake(20, 20, 150, 30);
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        UILabel* showGridLabel = [[[UILabel alloc] initWithFrame:rect] autorelease];
        showGridLabel.text = NSLocalizedString(@"Show grid", @"");
        [showGridLabel setFont:settingFont];
        [self.view addSubview: showGridLabel];
        
        self.toggleShowGridButton = [[[UISwitch alloc] initWithFrame:CGRectMake(viewSize.width - 100, rect.origin.y, 50, 50)] autorelease];
        [self.toggleShowGridButton setOn:[SettingViewController loadSettingGrid]];
        [self.toggleShowGridButton addTarget:self action:@selector(changeShowGridToggle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleShowGridButton];
        
        //color setting
        CGRect rectForColor = CGRectMake(rect.origin.x, rect.origin.y + 50 , 150, 30);
        UILabel* showColorLabel = [[[UILabel alloc] initWithFrame:rectForColor] autorelease];
        showColorLabel.text = NSLocalizedString(@"Add color", @"");
        [showColorLabel setFont:settingFont];
        [self.view addSubview:showColorLabel];
        
        self.toggleAddColorButton = [[[UISwitch alloc] initWithFrame:CGRectMake(viewSize.width - 100, rectForColor.origin.y, 50, 50)] autorelease];
        [self.toggleAddColorButton setOn:[SettingViewController loadSettingColor]];
        [self.toggleAddColorButton addTarget:self action:@selector(changeColorToggle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleAddColorButton];
        
        //tutorial setting
        CGRect rectForTutorial = CGRectMake(rect.origin.x, rect.origin.y + 100, 150, 30);
        UILabel* showTutorLabel = [[[UILabel alloc] initWithFrame:rectForTutorial] autorelease];
        showTutorLabel.text = NSLocalizedString(@"Show hints", @"");
        [showTutorLabel setFont:settingFont];
        [self.view addSubview:showTutorLabel];
        
        self.toggleShowTutorial = [[[UISwitch alloc] initWithFrame:CGRectMake(viewSize.width - 100, rectForTutorial.origin.y, 50, 50)] autorelease];
        [self.toggleShowTutorial setOn:[SettingViewController loadSettingTutorial]];
        [self.toggleShowTutorial addTarget:self action:@selector(changeTutorialToggle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleShowTutorial];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)close
{
    [[self parent] deprecatedDismissModalViewControllerAnimated:YES];
}

- (void)changeShowGridToggle
{
    self.showGrid = !self.showGrid;
    [SettingViewController saveSettingGrid:self.showGrid];
    if(self.competitionBlock) {
        self.competitionBlock();
    }
}

- (void)changeColorToggle
{
    self.showColor = !self.showColor;
    [SettingViewController saveSettingColor:self.showColor];
    if(self.competitionBlock) {
        self.competitionBlock();
    }
}

- (void)changeTutorialToggle
{
    self.showTutorial = !self.showTutorial;
    NSLog(@"show tut %@", (self.showTutorial)?@"yes":@"no");
    [SettingViewController saveSettingTutorial:self.showTutorial];
    if(self.competitionBlock) {
        self.competitionBlock();
    }
}

+ (void)saveSettingGrid:(BOOL)grid
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setBool:grid forKey:kShowGrid];
}

+ (void)saveSettingColor:(BOOL)showColor
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setBool:showColor forKey:kShowColor];
}

+ (void)saveSettingTutorial:(BOOL)showTutorial
{
    NSLog(@"show tut %@", (showTutorial)?@"yes":@"no");
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setBool:showTutorial forKey:kShowTutorial];
}

+ (BOOL)loadSettingGrid
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    return [def boolForKey:kShowGrid];
}

+ (BOOL)loadSettingColor
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    return [def boolForKey:kShowColor];
}

+ (BOOL)loadSettingTutorial
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    return [def boolForKey:kShowTutorial];
}
@end
