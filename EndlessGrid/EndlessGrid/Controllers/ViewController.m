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
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib {
    
    NSLog(@"awakeFromNib %f", self.grid.frame.size.height);
    [super awakeFromNib];
    
}
- (void)test
{
    self.settingViewController = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    [self presentModalViewController:self.settingViewController animated:YES];
}
@end
