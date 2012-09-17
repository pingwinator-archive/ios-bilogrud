//
//  PersonListViewController.m
//  PersonDBApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "PersonListViewController.h"
#import "AddPersonViewController.h"
#import "AppDelegate.h"
#import "Person.h"

@interface PersonListViewController ()

@end

@implementation PersonListViewController
@synthesize personFetchRC;
@synthesize tableViewPersons;

-(void)dealloc{
    self.tableViewPersons = nil;
    self.personFetchRC = nil;
    [super dealloc];
}

- (NSManagedObjectContext *) managedObjectContext{
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* managedContext = appDelegate.managedObjectContext;
    
    return managedContext;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        NSFetchRequest* fetchRequest = [[[NSFetchRequest alloc]init] autorelease];
        
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[self managedObjectContext]];
        
        NSSortDescriptor* sortDescr = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
        fetchRequest.sortDescriptors = [NSArray arrayWithObject:sortDescr];
        
        [fetchRequest setEntity:entity];
        
        self.personFetchRC = [[[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
        self.personFetchRC.delegate = self;
        NSError *fetchingError = nil;
        if ([self.personFetchRC performFetch:&fetchingError]){
            NSLog(@"Successfully fetched.");
        } else {
            NSLog(@"Failed to fetch.");
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Persons";
    self.tableViewPersons = [[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    
    self.tableViewPersons.delegate = self;
    self.tableViewPersons.dataSource = self;
    
    [self.view addSubview:self.tableViewPersons];
    
    UIBarButtonItem* add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPerson)];
    [self.navigationItem setLeftBarButtonItem:[self editButtonItem] animated:YES];
    [self.navigationItem setRightBarButtonItem:add animated:YES];
    [add release];
}

- (void)addPerson
{
    AddPersonViewController* addPerson = [[AddPersonViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:addPerson animated:YES];
    [addPerson release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableViewPersons = nil;
    self.personFetchRC = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableViewPersons reloadData];
}

#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionsInfo = [self.personFetchRC.sections objectAtIndex:section];
    return [sectionsInfo numberOfObjects];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = nil;
    static NSString *PersonTableViewCell = @"PersonTableViewCell";
    result = [tableView dequeueReusableCellWithIdentifier:PersonTableViewCell];
    
    if (result == nil){
        result = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PersonTableViewCell] autorelease];
        result.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Person *person = [self.personFetchRC objectAtIndexPath:indexPath];
    result.textLabel.text = [person.firstName stringByAppendingFormat:@" %@", person.lastName];
    result.detailTextLabel.text = [NSString stringWithFormat:@"Age: %lu", (unsigned long)[person.age unsignedIntegerValue]];
    return result;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Person *personToDelete = [self.personFetchRC objectAtIndexPath:indexPath];
    /* Very important: we need to make sure we are not reloading the table view while deleting the managed object */
    self.personFetchRC.delegate = nil;
    [[self managedObjectContext] deleteObject:personToDelete];
    if ([personToDelete isDeleted]){
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]){
            NSError *fetchingError = nil;
            
            if ([self.personFetchRC performFetch:&fetchingError]){
                NSLog(@"Successfully fetched.");
                NSArray *rowsToDelete = [[NSArray alloc] initWithObjects:indexPath, nil] ;
                [tableViewPersons deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
                [rowsToDelete release];
            } else {
                NSLog(@"Failed to fetch with error = %@", fetchingError); }
        } else {
            NSLog(@"Failed to save the context with error = %@", savingError);
        }
        
    }
    self.personFetchRC.delegate = self;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    if(editing){
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPerson)] autorelease] animated:YES];
    }
        [self.tableViewPersons setEditing:editing animated:YES];
}
@end
