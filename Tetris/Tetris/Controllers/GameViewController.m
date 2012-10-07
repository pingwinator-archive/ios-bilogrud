//
//  ViewController.m
//  Tetris
//
//  Created by Natasha on 29.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "GameViewController.h"
//#import "BoardView.h"
#import "BoardViewController.h"
@interface GameViewController ()

@end

@implementation GameViewController
@synthesize boardViewController;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.boardViewController = [[BoardViewController alloc] initWithFrame:CGRectMake(10, 10, 150, 300) andXCount:12];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
