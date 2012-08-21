//
//  ViewController.m
//  Swap
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#define degreesToRadians(x) (M_PI * (x) / 180.0)

@interface ViewController ()

@end

@implementation ViewController
@synthesize bars;
@synthesize foos;
@synthesize landscape;
@synthesize portrait;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPortrait:nil];
    [self setLandscape:nil];
    [self setFoos:nil];
    [self setBars:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [portrait release];
    [landscape release];
    [foos release];
    [bars release];
    [super dealloc];
}
- (IBAction)buttonTapped:(id)sender {
  /*  NSString *message = nil;
    if([self.foos containsObject:sender])
        message = @"Foo";
    else
        message = @"Bar";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];*/
    if([self.foos containsObject:sender]){
        for (UIButton *oneFoo in foos) {
            oneFoo.hidden = YES;
        }
    }
    else{
        for (UIButton *oneBar in bars) {
            oneBar.hidden = YES;
        }
    }
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

    if(toInterfaceOrientation == UIInterfaceOrientationPortrait){
        self.view = self.portrait;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.view = self.landscape;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
    
    }
}
@end
