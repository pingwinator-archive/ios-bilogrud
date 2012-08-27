//
//  MoveMeController.m
//  Nav
//
//  Created by Natasha on 26.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "MoveMeController.h"

@interface MoveMeController ()

@end

@implementation MoveMeController
@synthesize list;

-(void)dealloc{
    self.list = nil;
    [super dealloc];
}
-(IBAction)toggleMove{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing)
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.rightBarButtonItem setTitle:@"Move"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	if (self.list == nil) {
        NSMutableArray *array = [[[NSMutableArray alloc] initWithObjects: @"Eeny", @"Meeny", @"Miney", @"Moe", @"Catch", @"A", @"Tiger", @"By", @"The", @"Toe", nil]autorelease];
        self.list = array;
    }
    UIBarButtonItem *moveButton = [[UIBarButtonItem alloc] initWithTitle:@"Move"
               style:UIBarButtonItemStyleBordered target:self action:@selector(toggleMove)];
    self.navigationItem.rightBarButtonItem = moveButton;
    [moveButton release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.list = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MoveMeCellIdentifier = @"*MoveMeCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MoveMeCellIdentifier];
    if(cell == nil){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoveMeCellIdentifier]autorelease];
        //?
        cell.showsReorderControl = YES;
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.list objectAtIndex:row];
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id obj = [self.list objectAtIndex:fromRow];
    [list removeObjectAtIndex: fromRow];
    [list insertObject:obj atIndex:toRow];
}
@end
