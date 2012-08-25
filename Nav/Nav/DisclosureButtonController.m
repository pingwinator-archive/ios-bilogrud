//
//  DisclosureButtonController.m
//  Nav
//
//  Created by Natasha on 24.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "DisclosureButtonController.h"
#import "AppDelegate.h"
#import "DisclosureDetailController.h"

@interface DisclosureButtonController ()
@property (retain, nonatomic) DisclosureDetailController *childController;
@end

@implementation DisclosureButtonController

@synthesize list;
@synthesize childController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSArray *array = [[NSArray alloc] initWithObjects:@"Toy Story",
                    @"A Bug's Life", @"Toy Story 2", @"Monsters, Inc.", @"Finding Nemo", @"The Incredibles", @"Cars", @"Ratatouille", @"WALL-E", @"Up", @"Toy Story 3", @"Cars 2", @"Brave", nil];
    self.list = array;
    [array release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.list = nil;
    self.childController = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 
#pragma mark -Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * DisclosureButtonCellIdentifier = @"DisclosureButtonCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: DisclosureButtonCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier: DisclosureButtonCellIdentifier]autorelease];
    }
    NSUInteger row = [indexPath row];
    NSString *rowString = [list objectAtIndex:row];
    cell.textLabel.text = rowString;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}
#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Hey, do you see the disclosure button?"
                                                    message: @"If you're trying to drill down, touch that instead"
                                                   delegate:nil
                                          cancelButtonTitle:@"Won't happen again"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (childController == nil) {
        childController = [[[DisclosureDetailController alloc] initWithNibName:@"DisclosureDetailController" bundle:nil]autorelease];
    }
    childController.title = @"Disclosure Button Pressed";
    NSUInteger row = [indexPath row];
    NSString *selectedMovie = [list objectAtIndex:row];
    NSString *detailMessage = [[NSString alloc] initWithFormat:@"You pressed the disclosure button for %@.", selectedMovie];
    childController.message = detailMessage;
    childController.title = selectedMovie;
    [self.navigationController pushViewController:childController animated:YES];
    [detailMessage release];
    
}
@end
