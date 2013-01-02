//
//  ViewController.m
//  TableTest
//
//  Created by Natasha on 30.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    TableViewController* table = [[TableViewController alloc] init];
    
    table.view.frame = CGRectMake(0, 0, 320, 300);
    table.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:table.view];
//    self.tableTestView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
//    self.tableTestView.delegate = self;
//    self.tableTestView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.tableTestView];
       [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
