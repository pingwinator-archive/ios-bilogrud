//
//  PresidentsViewController.m
//  Nav
//
//  Created by Natasha on 26.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "PresidentsViewController.h"
#import "PresidentDetailController.h"
#import "President.h"

@interface PresidentsViewController ()

@end

@implementation PresidentsViewController
@synthesize list;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Presidents" ofType:@"plist"];
    NSData *data;
    NSKeyedUnarchiver *unarchiver;
    data = [[NSData alloc] initWithContentsOfFile:path];
    unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //problem!!!
    NSMutableArray *array = [unarchiver decodeObjectForKey:@"Presidents"];
    self.list = array;
    [unarchiver finishDecoding];
    [data release];
    [unarchiver release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.list = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *presidentIdentifier = @"presidentIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:presidentIdentifier];
    if (cell == nil){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:presidentIdentifier]autorelease];
        
    }
    NSInteger row = [indexPath row];
    President *pres = [self.list objectAtIndex:row];
    cell.textLabel.text = pres.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@" , pres.fromYear, pres.toYear];
    return cell;
}
#pragma mark - Table Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    President *pres = [self.list objectAtIndex:row];
    
    PresidentDetailController *childController = [[PresidentDetailController alloc]initWithStyle:UITableViewStyleGrouped];
    childController.title = pres.name;
    childController.president = pres;
    
    [self.navigationController pushViewController:childController animated:YES];
}
@end
