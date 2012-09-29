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
#import "UIImage+RoundedCorner.h"
@interface ViewController ()
@property(retain, nonatomic) UIView* settingSmallView;
@end

@implementation ViewController
@synthesize grid;
@synthesize settingViewController;
@synthesize testButton;
@synthesize bgView;
@synthesize settingSmallView;

- (void)dealloc
{
    self.bgView = nil;
    self.settingViewController = nil;
    self.testButton = nil;
    self.grid = nil;
    self.settingSmallView = nil;
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
    self.settingSmallView = nil;
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
    self.bgView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.5];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.bgView.alpha = 1.0;
    }];
    
    [self.settingViewController.view removeFromSuperview];
    self.settingViewController = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    self.settingViewController.delegate = self;
    self.bgView.hidden = NO;
    
    
    self.settingSmallView = self.settingViewController.view;
    
    UIImage* imageSegm = [[UIImage imageNamed:@"LineIcon.png" ] roundedCornerImage:7 borderSize:0];
    self.settingViewController.addSegm.image = imageSegm;
    self.settingSmallView.frame = CGRectMake(0, 100, 320, 130);
    self.settingSmallView.backgroundColor = [UIColor redColor] ;
  
    [self.bgView addSubview:self.settingSmallView];
 
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
    self.bgView.alpha = 0.0f;
}
@end