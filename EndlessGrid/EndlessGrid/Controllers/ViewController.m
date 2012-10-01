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
#import "Shape.h"
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
    //ui
    self.bgView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.5];
    self.bgView.hidden = NO;
    [UIImageView animateWithDuration:delayForSubView animations:^{
        self.bgView.alpha = 1.0;
    }];
   //reinit
    [self.settingViewController.view removeFromSuperview];
    self.settingViewController = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    self.settingViewController.delegate = self;
    
//    self.settingSmallView = (UIImageView*)self.settingViewController.view;
//    UIImage* white = [[UIImage imageNamed:@"White.jpeg"] roundedCornerImage:7 borderSize:0];

  //  self.settingSmallView.image = [white roundedCornerImage:10 borderSize:1];
    self.settingViewController.bgImageView.backgroundColor = [UIColor redColor];
    self.settingViewController.view.frame = CGRectMake(40, 100, 240, 260);
  
    [self.bgView addSubview:self.settingViewController.view];
    self.grid.userInteractionEnabled = NO;
}


#pragma mark - SettingsViewDelegate Methods

- (void)hideSettingsView:(ActionType)actionType withCustomShape:(Shape*)shape
{
    if(actionType != kAddNone) {
        self.grid.actionType = actionType;
    }
    
    if( actionType == kClearBoard) {
        [self.grid clearBoard];
    }
    if(shape) {
        [self.grid addCustomShape: shape];
    }
   
    [UIImageView animateWithDuration:delayForSubView animations:^{
        self.bgView.alpha = 0.0;
//??
        self.settingViewController.settingButtonsView.alpha = 0;
    }];
    [self.settingViewController.view removeFromSuperview];
    self.bgView.hidden = YES;
    self.grid.userInteractionEnabled = YES;
}

- (BOOL)isCustomShape
{
    return (self.grid.actionType == kAddCustomPoint) &&
    (self.grid.actionType == kAddCustomLine) &&
    (self.grid.actionType == kAddCustomSegment);
}
@end