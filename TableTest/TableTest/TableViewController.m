//
//  TableViewController.m
//  TableTest
//
//  Created by Natasha on 30.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "TableViewController.h"
#import "StatusCell.h"

@interface TableViewController ()
@property (strong, nonatomic) NSMutableArray* allCells;
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)init
{
    self = [super init];
    if (self) {
//        [self.view setFrame:CGRectMake(0, 0, 220, 100)];
//       self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width - 20, self.view.frame.size.height - 10);
//        self.view.alpha = 0.5f;
//        CGRect tvframe = [self.view frame];
//        [self.tableView setFrame:CGRectMake(tvframe.origin.x,
//                                       tvframe.origin.y,
//                                       tvframe.size.width,
//                                       100)];
        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.height, 250)];
         [self.tableView setBackgroundColor:[UIColor redColor]];
        self.allCells = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [self.allCells addObject:[NSString stringWithFormat:@"Cell number %d", i]];
        }
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CGAffineTransform rotateTable = CGAffineTransformMakeRotation(M_PI_2);
    self.tableView.transform = rotateTable;
    
  

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.allCells count];
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"StatusCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    StatusCell *cell = (StatusCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    if([self.allCells count]){
        NSUInteger row = [indexPath row];
        cell.nameLabel.text = [self.allCells objectAtIndex:row];
    }
    return cell;
}

#pragma  mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString* text = [[self.allCells objectAtIndex:indexPath.row] message];
    //    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:kFontMesage]  constrainedToSize:CGSizeMake(280, 2000)];
    return 100;//MAX(cellHeight, textSize.height + kCellOffset) ;
}


@end
