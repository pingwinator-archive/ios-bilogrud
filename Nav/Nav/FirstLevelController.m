//
//  FirstLevelController.m
//  Nav
//
//  Created by Natasha on 23.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "FirstLevelController.h"
#import "SecondLevelViewController.h"
#import "DisclosureButtonController.h"
#import "CheckListController.h"
@interface FirstLevelController ()

@end

@implementation FirstLevelController
@synthesize controllers;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"First";
    NSMutableArray *array = [[NSMutableArray alloc]init];
   
    // Disclosure Button
    DisclosureButtonController *disclosureButtonController =
    [[DisclosureButtonController alloc] initWithStyle:UITableViewStylePlain];
    disclosureButtonController.title = @"Disclosure Buttons";
    disclosureButtonController.rowImage = [UIImage imageNamed:@"disclosureButtonControllerIcon.png"];
    [array addObject:disclosureButtonController];
    
    [disclosureButtonController release];
    
    // Checklist
    CheckListController *checkListController = [[CheckListController alloc]initWithStyle :UITableViewStylePlain];
    checkListController.title = @"Check One";
    checkListController.rowImage = [UIImage imageNamed:@"checkmarkControllerIcon.png"];
    [array addObject:checkListController];
    [checkListController release];
    
     self.controllers = array;
    [array release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.controllers = nil;
  }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FirstLevelCell = @"FirstLevelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier: FirstLevelCell]autorelease];
    }
    // Configure the cell
    NSUInteger row = [indexPath row];
    SecondLevelViewController *controller = [controllers objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.imageView.image = controller.rowImage;
   // cell.imageView.image = [UIImage imageNamed:@"disclosureButtonControllerIcon.png"];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    SecondLevelViewController *nextController = [self.controllers objectAtIndex:row];
    
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
