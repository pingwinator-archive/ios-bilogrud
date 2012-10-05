 //
//  ViewController.m
//  EndlessGrid
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "GridGraphic.h"
#import "UIImage+RoundedCorner.h"
#import "Shape.h"
#import "ShapeDelegate.h"
#import "SettingsViewController.h"
#import "InfoViewController.h"
#import "UIPopoverManager.h"
@interface ViewController ()
@property (nonatomic, assign) CGRect rectTest;
@end

@implementation ViewController
@synthesize grid;
@synthesize settingViewController;
@synthesize showSettingButton;
@synthesize bgView;
@synthesize popover;
@synthesize popoverInfo;
@synthesize infoViewController;
@synthesize showInfoButton;
- (void)dealloc
{
    self.bgView = nil;
    self.settingViewController = nil;
    self.showSettingButton = nil;
    self.grid = nil;
    self.popover = nil;
    self.popoverInfo = nil;
    self.infoViewController = nil;
    self.showInfoButton = nil;
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
    self.showSettingButton = nil;
    self.grid = nil;
    self.popover = nil;
    self.popoverInfo = nil;
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.grid setNeedsDisplay];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - IBActions

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
    self.settingViewController.currentColor = self.grid.shapeColor;
    
    if (isiPhone) {
        self.settingViewController.bgImageView.backgroundColor = [UIColor redColor];
        self.settingViewController.view.frame = CGRectMake(40, 100, 240, 260);
        [self.bgView addSubview:self.settingViewController.view];
        self.grid.userInteractionEnabled = NO;
    } else {
        self.settingViewController.contentSizeForViewInPopover = CGSizeMake(240, 260);
        [UIPopoverManager showControllerInPopover:self.settingViewController inView:bgView forTarget:self.showSettingButton dismissTarget:self dismissSelector:@selector(popoverControllerDidDismissPopover:)];
    }
}

- (void)showInfo
{
    self.infoViewController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    self.infoViewController.view.frame = CGRectMake(600, 950, 240, 260);
    self.infoViewController.contentSizeForViewInPopover = CGSizeMake(200, 200);
    [UIPopoverManager showControllerInPopover:self.infoViewController inView:self.bgView forTarget:self.showInfoButton dismissTarget:self dismissSelector:@selector(popoverControllerDidDismissPopover:)];
    DBLog(@"infoButton");
}

#pragma mark - SettingsViewDelegate Methods

- (void)hideSettingsView:(ActionType)actionType withCustomShape:(Shape*)shape
{
    if(actionType != kAddNone && (shape || ![self isCustomShape:actionType])) {
        self.grid.actionType = actionType;
    }
    if(actionType == kClearBoard) {
        [self.grid clearBoard];
    }
    if(shape) {
        [self.grid addCustomShape: shape];
    }
        
    [UIImageView animateWithDuration:delayForSubView animations:^{
        self.bgView.alpha = 0.0;
        self.settingViewController.settingButtonsView.alpha = 0;
    } completion:^(BOOL finished){
    if (isiPhone) {
        [self.settingViewController.view removeFromSuperview];
    } else {
        [self.popover dismissPopoverAnimated:YES];
    }

    self.bgView.hidden = YES;
    }];

    self.grid.userInteractionEnabled = YES;
}

- (void)changeColor:(UIColor*)color 
{
    if(color) {
        self.grid.shapeColor = color;
    }
}

- (BOOL)isCustomShape:(ActionType)actionType
{
    return ((actionType == kAddCustomPoint) || (actionType == kAddCustomSegment) || (actionType == kAddCustomLine));
}

#pragma mark - UIPopoverControllerDelegate Methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [UIImageView animateWithDuration:delayForSubView animations:^{
        self.bgView.alpha = 0.0;
    }];
}
@end