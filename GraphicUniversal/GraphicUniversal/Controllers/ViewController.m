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
@property (retain, nonatomic) UIPopoverController* popover;
@end

@implementation ViewController
@synthesize grid;
@synthesize settingViewController;
@synthesize showSettingButton;
@synthesize bgView;
@synthesize popover;

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

    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      
        self.settingViewController.bgImageView.backgroundColor = [UIColor redColor];
        self.settingViewController.view.frame = CGRectMake(40, 100, 240, 260);
        [self.bgView addSubview:self.settingViewController.view];
        self.grid.userInteractionEnabled = NO;
        
    } else {
      
        self.settingViewController.view.frame = CGRectMake(270, 250, 240, 260);
        self.popover = [[[UIPopoverController alloc] initWithContentViewController:self.settingViewController] autorelease];
        
        popover.popoverContentSize = self.settingViewController.view.frame.size;
        //self.settingViewController
        [popover presentPopoverFromRect:self.settingViewController.view.bounds
                                 inView:self.bgView
               permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
        }];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.settingViewController.view removeFromSuperview];
    } else {
            [self.popover dismissPopoverAnimated:YES];
    }
  
    self.bgView.hidden = YES;
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
@end