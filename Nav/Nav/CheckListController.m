//
//  CheckListController.m
//  Nav
//
//  Created by Natasha on 25.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CheckListController.h"

@interface CheckListController ()

@end

@implementation CheckListController
@synthesize lastIndexPath;
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
    NSArray *array = [[NSArray alloc] initWithObjects:@"Who Hash",
                      @"Bubba Gump Shrimp Étouffée", @"Who Pudding", @"Scooby Snacks", @"Everlasting Gobstopper", @"Green Eggs and Ham", @"Soylent Green", @"Hard Tack", @"Lembas Bread", @"Roast Beast", @"Blancmange", nil];
    self.list = array;
    [array release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.list = nil;
    self.lastIndexPath = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Table Data Source Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CheckMarkCellIdentifier = @"CheckMarkCellIdentifier";
//    UITableViewCell *Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CheckMarkCellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckMarkCellIdentifier];
    if(cell == nil){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CheckMarkCellIdentifier]autorelease];
    }
    NSUInteger lastRow = [self.lastIndexPath row];
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.list objectAtIndex: row];
    cell.accessoryType = (row == lastRow && lastIndexPath != nil) ?
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.list count];
}
#pragma mark - Table Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger newRow = [indexPath row];
    NSInteger oldRow = (self.lastIndexPath != nil) ? [self.lastIndexPath row] : -1;
    if(newRow != oldRow){
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:lastIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        lastIndexPath = indexPath;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
