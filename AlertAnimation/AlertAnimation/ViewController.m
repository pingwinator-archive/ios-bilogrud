//
//  ViewController.m
//  AlertAnimation
//
//  Created by Natasha on 18.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "ImaginationAlert.h"
#import "UIView+Position.h"

@interface ViewController ()
@property (strong, nonatomic) UIButton* showIAlert;
@property (strong, nonatomic) UIButton* showNativeAlert;
@property (strong, nonatomic) ImaginationAlert* imagineAlert;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.showIAlert = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.showIAlert.frame = CGRectMake(10, 10, 100, 50);
    [self.showIAlert setTitle:@"Show alert" forState:UIControlStateNormal];
    [self.showIAlert addTarget:self action:@selector(showMyAlertAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showIAlert];
    
    
    self.showNativeAlert = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.showNativeAlert.frame = CGRectMake(150, 10, 100, 50);
    [self.showNativeAlert setTitle:@"alert!" forState:UIControlStateNormal];
    [self.showNativeAlert addTarget:self action:@selector(showNativeAlertAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showNativeAlert];

    
    self.imagineAlert = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imagineAlert.hidden = YES;
    self.imagineAlert.frame = CGRectMake(20, 150, 280, 100);
    [self.imagineAlert setBackgroundColor:[UIColor blueColor]];
    [self.imagineAlert setTitle:@"alert!" forState:UIControlStateNormal];
    [self.imagineAlert addTarget:self action:@selector(hideAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addCenteredSubview:self.imagineAlert];
}

- (void)showMyAlertAction
{
//    [UIView beginAnimations:@"suck" context:NULL];
//    [UIView setAnimationTransition:103 forView:self.imagineAlert cache:NO];
//    [UIView setAnimationDuration:1.5f];
//    [UIView setAnimationPosition:CGPointMake(300, 1)];
//    [UIView commitAnimations];
    [self initialDelayEnded];
    self.imagineAlert.hidden = NO;
}

- (void)showNativeAlertAction
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Some message" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)hideAlert
{
    [UIView animateWithDuration:0.2 animations:^{
        self.imagineAlert.alpha = 0;
    } completion:^(BOOL finished) {
        self.imagineAlert.hidden = YES;
    }];
}

- (void)initialDelayEnded {
    self.imagineAlert.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    self.imagineAlert.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.imagineAlert.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
}

- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceLastAnimationStopped)];
    self.imagineAlert.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounceLastAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    self.imagineAlert.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}
@end
