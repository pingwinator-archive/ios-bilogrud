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
#import "ShapeDelegate.h"
@interface ViewController ()
@property (nonatomic, assign) CGRect rectTest;
@end

@implementation ViewController
@synthesize grid;
@synthesize settingViewController;
@synthesize showSettingButton;
@synthesize bgView;
@synthesize popover;
@synthesize rectTest;

- (void)dealloc
{
    self.bgView = nil;
    self.settingViewController = nil;
    self.showSettingButton = nil;
    self.grid = nil;
    self.popover = nil;
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
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
    
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.popover presentPopoverFromRect:self.showSettingButton.frame//self.settingViewController.view.frame
                                  inView:self.bgView
                permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.popover dismissPopoverAnimated:NO];
    
//    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight ) {
//        
//        rectTest = CGRectMake(200, 200, 240, 260);
//    } else {
//        rectTest = CGRectMake(277, 950, 240, 260);
//    }
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
        self.settingViewController.view.frame = CGRectMake(277, 950, 240, 260);
        self.popover = [[[UIPopoverController alloc] initWithContentViewController:self.settingViewController] autorelease];
        self.popover.delegate = self; 
        self.popover.popoverContentSize = self.settingViewController.view.frame.size;
        
        [self.popover presentPopoverFromRect:self.showSettingButton.frame//self.settingViewController.view.frame
                                 inView:self.bgView
               permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
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

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [UIImageView animateWithDuration:delayForSubView animations:^{
        self.bgView.alpha = 0.0;
    }];

}
@end