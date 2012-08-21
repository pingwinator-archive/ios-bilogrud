//
//  ViewController.m
//  AutoSizeTest
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize buttonLR;
@synthesize buttonLL;
@synthesize buttonR;
@synthesize buttonL;
@synthesize buttonUR;
@synthesize buttonUL;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setButtonUL:nil];
    [self setButtonUR:nil];
    [self setButtonL:nil];
    [self setButtonR:nil];
    [self setButtonLL:nil];
    [self setButtonLR:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;// (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
  
    if (UIInterfaceOrientationPortraitUpsideDown == toInterfaceOrientation) {
        NSLog( @"UIInterfaceOrientationPortrait");


    }
    if (UIInterfaceOrientationLandscapeLeft == toInterfaceOrientation) {
        NSLog( @"UIInterfaceOrientationLandscapeLeft");
    }
    if (UIInterfaceOrientationLandscapeRight == toInterfaceOrientation) {
        NSLog( @"UIInterfaceOrientationLandscapeRight");
    }
    
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        buttonUL.frame = CGRectMake(30, 10, 125, 125);
        buttonUR.frame = CGRectMake(310, 10, 125, 125);
        buttonL.frame = CGRectMake(30, 90, 125, 125);
        buttonR.frame = CGRectMake(310, 90, 125, 125);
        NSLog( @"to portrait! %d", 5 );
        buttonLL.frame = CGRectMake(30, 170, 125, 125);
        buttonLR.frame = CGRectMake(310, 170, 125, 125);
        
    }
    else{
        if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
        NSLog( @"smth! %d", 5 );
        buttonUL.frame = CGRectMake(10, 10, 125, 125);
        buttonUR.frame = CGRectMake(10, 310, 125, 125);
        buttonL.frame = CGRectMake(95, 10, 125, 125);
        buttonR.frame = CGRectMake(95, 310, 125, 125);
        buttonLL.frame = CGRectMake(180, 10, 125, 125);
        buttonLR.frame = CGRectMake(180, 310, 125, 125);
    }
    }
}

- (void)dealloc {
    [buttonUL release];
    [buttonUR release];
    [buttonL release];
    [buttonR release];
    [buttonLL release];
    [buttonLR release];
    [super dealloc];
}
@end
