//
//  ViewController.m
//  GraphicViewControllerApp
//
//  Created by Natasha on 18.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [self drawRect:CGRectMake(50.0f, 50.0f, 200.0f, 200.0f)];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)drawRect:(CGRect)rect
{
    UIFont *Helvetica = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0f];
    NSString *str = @"Don't worry";
    [str drawAtPoint:CGPointMake(60.0f, 60.0f) withFont:Helvetica];

}
@end
