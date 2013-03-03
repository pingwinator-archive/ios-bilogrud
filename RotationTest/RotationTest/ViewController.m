//
//  ViewController.m
//  RotationTest
//
//  Created by Natasha on 02.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Additions.h"

@interface ViewController ()
@property (strong, nonatomic) UIImage* start;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancel:(id)sender
{
    self.imageView.image = self.start;
    self.start = nil;
}

- (void)step:(id)sender
{
    if (!self.start) {
        self.start = self.imageView.image;
    }
    self.imageView.image = [self.imageView.image rotatePhoto];
}

- (void)done:(id)sender
{
    self.start = nil;
}

@end
