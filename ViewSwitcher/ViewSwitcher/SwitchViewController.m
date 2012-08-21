//
//  SwitchViewController.m
//  ViewSwitcher
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SwitchViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"
@interface SwitchViewController ()

@end

@implementation SwitchViewController
@synthesize blueViewController;
@synthesize yellowViewController;
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
    self.blueViewController = [[[BlueViewController alloc]initWithNibName: @"BlueView" bundle:nil]autorelease];
    [self.view insertSubview:self.blueViewController.view atIndex:0];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview [super didReceiveMemoryWarning];
    // Release any cached data, images, etc, that aren't in use
    [super didReceiveMemoryWarning];
    if (self.blueViewController.view.superview == nil) {
        self.blueViewController = nil;
        NSLog(@"self.blueViewController = nil;");
    } else {
        self.yellowViewController = nil;
           NSLog(@"self.yellowViewController = nil;");
    }
}
-(IBAction)switchViews:(id)sender{
 /*   if(self.yellowViewController.view.superview == nil){
        if (self.yellowViewController == nil) {
            self.yellowViewController =
            [[YellowViewController alloc] initWithNibName:@"YellowView" bundle:nil];
        }
        [self.blueViewController.view removeFromSuperview];
        [self.view insertSubview:self.yellowViewController.view atIndex:0];
    } else {
        if (self.blueViewController == nil) {
        self.blueViewController =
        [[BlueViewController alloc] initWithNibName:@"BlueView" bundle:nil];
        }
        [yellowViewController.view removeFromSuperview];
        [self.view insertSubview:self.blueViewController.view atIndex:0];
    }
  */
    //animation block
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    if (self.yellowViewController.view.superview == nil) {
        if (self.yellowViewController == nil) {
        self.yellowViewController =
        [[YellowViewController alloc] initWithNibName:@"YellowView"
                                                  bundle:nil];
    }
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.blueViewController.view removeFromSuperview];
        [self.view insertSubview:self.yellowViewController.view atIndex:0];
    }
    else {
            if (self.blueViewController == nil) {
                self.blueViewController =
                [[BlueViewController alloc] initWithNibName:@"BlueView"
                                                        bundle:nil];
            }
            [UIView setAnimationTransition:
            UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
            [self.yellowViewController.view removeFromSuperview];
            [self.view insertSubview:self.blueViewController.view atIndex:0];
    }
    [UIView commitAnimations];
}
@end
