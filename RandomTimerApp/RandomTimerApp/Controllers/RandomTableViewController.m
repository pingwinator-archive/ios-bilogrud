//
//  RandomTableViewController.m
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "RandomTableViewController.h"
#import "AppDelegate.h"
#import "Generator.h"
#import "GeneratedData.h"
#import "CoreDataManager.h"
#import "SettingViewController.h"
@interface RandomTableViewController ()
- (void)genarate;
- (void)showSettings;
@end

@implementation RandomTableViewController
@synthesize fetchResult;
@synthesize tableRandomData;
@synthesize generator;

- (void)dealloc
{
    self.fetchResult = nil;
    self.tableRandomData = nil;
    self.generator = nil;
    [super dealloc];
}

- (void)initFetchResult
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"GeneratedData" inManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext ]];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor* sortDescr = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    fetchRequest.sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescr, nil] autorelease];
    self.fetchResult  = [[[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext ] sectionNameKeyPath:nil cacheName:nil] autorelease];
  
    self.fetchResult.delegate = self;
    NSError *err;
    BOOL success = [fetchResult performFetch:&err];
    if (!success) {
        DBLog(@"fail performFetch");
    }
    [fetchRequest release];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:app];
    
    [self initFetchResult];
    [self.tableView reloadData];
    [self genarate];
 
    UIBarButtonItem *right  = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Setting", @"") style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
    
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    
    [self.navigationItem setLeftBarButtonItem:[self editButtonItem]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.fetchResult = nil;
    self.tableRandomData = nil;
    self.generator = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)genarate
{
    self.generator = [[Generator alloc] init];
    [self.generator release];
    [self.generator startGenerator];
}

- (void) showSettings
{
    SettingViewController* settingViewController = [[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil] autorelease];
    
    [self.navigationController pushViewController:settingViewController animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
        {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationMiddle ];
        }
            break;
        case NSFetchedResultsChangeUpdate:
        {
        }
            break;
        case NSFetchedResultsChangeMove:
        {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
        case NSFetchedResultsChangeDelete:
        {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
            break;
        default:
        {
            DBLog(@"unknown NSFetchedResultsChangeType");
        }
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // Return the number of rows in the section.
    return [[self.fetchResult fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    GeneratedData *data = [self.fetchResult objectAtIndexPath:indexPath];
    cell.textLabel.text = data.number.stringValue;
    
       
    cell.detailTextLabel.text = [self stringWithDate:data.time];
    return cell;
}

#pragma mark - NSDateFormatter methods

- (NSString*) stringWithDate: (NSDate*) date
{
    
    NSDateFormatter *_formatter = [[[NSDateFormatter alloc ] init] autorelease];
    [_formatter setDateFormat: @"dd-MM-yyyy HH:mm:ss"];
    NSString *resStrDate = [_formatter stringFromDate:date];
    return resStrDate;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        GeneratedData* deletingRow = [self.fetchResult objectAtIndexPath:indexPath];
        
        [[[CoreDataManager sharedInstance] managedObjectContext ] deleteObject:deletingRow];
        if([deletingRow isDeleted])
        {
            [[[CoreDataManager sharedInstance] managedObjectContext ] save:nil];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
