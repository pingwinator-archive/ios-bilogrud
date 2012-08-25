//
//  DisclosureDetailController.m
//  Nav
//
//  Created by Natasha on 24.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "DisclosureDetailController.h"

@interface DisclosureDetailController ()

@end

@implementation DisclosureDetailController
@synthesize label;
@synthesize message;

-(void)viewWillAppear:(BOOL)animated{
    self.label.text = self.message;
    [super viewWillAppear:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    self.label = nil;
    self.message = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
