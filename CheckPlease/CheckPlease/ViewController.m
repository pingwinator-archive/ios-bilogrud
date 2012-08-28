//
//  ViewController.m
//  CheckPlease
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "CheckMarkRecognizer.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize label;

-(void)doCheck{
    self.label.text = @"CheckMark";
    [self performSelector:@selector(eraseLabel) withObject:nil afterDelay:1.6];
}
-(void)eraseLabel{
    self.label.text = @"";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CheckMarkRecognizer *check = [[CheckMarkRecognizer alloc]initWithTarget:self action:@selector(doCheck)];
    [self.view addGestureRecognizer:check];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
     self.label = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
