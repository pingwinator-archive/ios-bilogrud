//
//  BoardViewController.m
//  Tetris
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BoardViewController.h"
#import "BoardView.h"
@interface BoardViewController ()

@end

@implementation BoardViewController
@synthesize amountCellX;
@synthesize boardView;

- (void)dealloc
{
    self.boardView = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame andXCount:(NSInteger)amountX;
{
    self = [self init];//[self initWithFrame:frame];
    
    if (self) {
        self.amountCellX = amountX;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
