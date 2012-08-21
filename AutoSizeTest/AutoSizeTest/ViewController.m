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
        buttonUL.frame = CGRectMake(20, 20, 125, 125);
        buttonUR.frame = CGRectMake(170, 20, 125, 125);
//        buttonL.frame = CGRectMake(20, 165, 125, 125);
//        buttonR.frame = CGRectMake(170, 165, 125, 125);
        NSLog( @"to portrait! %d", 5 );
        buttonLL.frame = CGRectMake(20, 308, 125, 125);
        buttonLR.frame = CGRectMake(170, 308, 125, 125);
        
    }
    else{
        if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
        NSLog( @"smth! %d", 5 );
        buttonUL.frame = CGRectMake(20, 20, 125, 125);
        buttonUR.frame = CGRectMake(20, 165, 125, 125);
//        buttonL.frame = CGRectMake(20, 165, 125, 125);
//        buttonR.frame = CGRectMake(165, 165, 125, 125);
        buttonLL.frame = CGRectMake(308, 20, 125, 125);
        buttonLR.frame = CGRectMake(308, 165, 125, 125);
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
