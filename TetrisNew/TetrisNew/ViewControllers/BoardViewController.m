//
//  BoardViewController.m
//  TetrisNew
//
//  Created by Natasha on 08.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BoardViewController.h"
#import "BoardView.h"
@interface BoardViewController ()
@property (retain, nonatomic) NSMutableSet* nextShape;
@end

@implementation BoardViewController
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

- (id)initWithFrame:(CGRect)frame amountCellX:(NSInteger)cellX
{
    self = [super init];
    if(self) {
        self.boardView = [[BoardView alloc] initWithFrame:frame amountCellX:cellX];
        self.boardView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
