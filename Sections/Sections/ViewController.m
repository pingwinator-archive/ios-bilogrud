//
//  ViewController.m
//  Sections
//
//  Created by Natasha on 23.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+MutableDeepCopy.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize keys;
@synthesize names;
@synthesize allNames;
@synthesize search;
@synthesize table;
@synthesize isSearching;

#pragma mark Custom Methods
-(void)resetSearch{
    self.names = [self.allNames mutableDeepCopy];
    NSMutableArray *keyArray = [[NSMutableArray alloc]init];
    //Adding the Special Value to the Keys Array
    [keyArray addObject:UITableViewIndexSearch];
    [keyArray addObjectsFromArray:[[self.allNames allKeys]sortedArrayUsingSelector:@selector(compare:)]];
    self.keys = keyArray;
    [keyArray release];
}
-(void)handleSearchForTerm:(NSString *)searchTerm{
    NSMutableArray *sectionsToRemove = [[NSMutableArray alloc] init];
    [self resetSearch];
    for (NSString *key in self.keys) {
        NSMutableArray *array = [names valueForKey:key];
        NSMutableArray *toRemove = [[[NSMutableArray alloc] init]autorelease];
        for (NSString *name in array) {
            if ([name rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound)
                [toRemove addObject:name];
        }
        if ([array count] == [toRemove count])
            [sectionsToRemove addObject:key];
        [array removeObjectsInArray:toRemove];
    }
    [self.keys removeObjectsInArray:sectionsToRemove];
    [table reloadData];
    [sectionsToRemove release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
     NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
     self.allNames = dict;
    [self resetSearch];
    [table reloadData];
    //hide search bar
    [table setContentOffset: CGPointMake(0.0, 44.0) animated:NO];
    [dict release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.names = nil;
    self.table = nil;
    self.allNames = nil;
    self.keys = nil;
    self.names = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark -TableView DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return [key count];
    return ([keys count] > 0) ? [keys count] : 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([keys count] == 0)
        return 0;
    NSString *localkey = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:localkey];
    return [nameSection count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSString *localkey = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:localkey];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionsTableIdentifier]autorelease];
    }
    cell.textLabel.text = [nameSection objectAtIndex:row];
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([keys count] == 0)
        return nil;
    NSString *localkey = [keys objectAtIndex:section];
    if(localkey == UITableViewIndexSearch)
        return nil;
    return localkey;
}

//add alphabet
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if(isSearching)
        return nil;
    return keys;
}
#pragma mark -Table View Delegate Methods

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//???????
    [search resignFirstResponder];
    isSearching = NO;
    search.text = @"";
    [tableView reloadData];
    return indexPath;
}

#pragma mark -Search Bar Delegate Methods
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
  
    if([searchText length] == 0){
        [self resetSearch];
        [table reloadData];
        return;
    }
    [self handleSearchForTerm:searchText];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isSearching = NO;
    search.text = @"";
    [self resetSearch];
    [table reloadData];
    [searchBar resignFirstResponder];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    isSearching = YES;
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSString *key = [keys objectAtIndex:index];
    if(key == UITableViewIndexSearch){
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    else return index;
}
@end
