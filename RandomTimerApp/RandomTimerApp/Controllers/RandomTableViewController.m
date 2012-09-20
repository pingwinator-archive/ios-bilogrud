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
@property (retain, nonatomic) Generator* generator;
- (void)genarate;
- (void)showSettings;
@end

@implementation RandomTableViewController
@synthesize fetchResult;
@synthesize tableRandomData;
@synthesize generator;
@synthesize useLocal;

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
        NSLog(@"fail performFetch");
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
 
    [self performSelector:@selector(genarate) withObject:nil afterDelay:2];
  
    UIBarButtonItem *right  = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Setting", @"") style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
    
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    
    [self.navigationItem setLeftBarButtonItem:[self editButtonItem]];
}

- (void)viewDidUnload
{
     [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)applicationWillEnterForeground:(NSNotification *)notification
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}

- (void)refreshFields
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.useLocal = (BOOL)[defaults objectForKey:@"kRandom"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)genarate
{
    self.generator = [[Generator alloc] init];
    [self.generator doGenerate];
    [self.generator release];
}

- (void) showSettings
{
    NSLog(@"setting button");
    SettingViewController* settingViewController = [[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil] autorelease];
    
    
    [self.navigationController pushViewController:settingViewController animated:YES];
}

#pragma mark fetch

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
            NSLog(@"unknown NSFetchedResultsChangeType");
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", data.number];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", data.time];
    
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        GeneratedData* deletingRow = [self.fetchResult objectAtIndexPath:indexPath];
        
        self.fetchResult.delegate = nil;
        
        [[[CoreDataManager sharedInstance] managedObjectContext ] deleteObject:deletingRow];
        if([deletingRow isDeleted])
        {
            [[[CoreDataManager sharedInstance] managedObjectContext ] save:nil];
            
            NSError* fetchingError;
            if ([self.fetchResult performFetch:&fetchingError]){
                NSLog(@"Successfully fetched.");
                NSArray *rowsToDelete = [[NSArray alloc] initWithObjects:indexPath, nil] ;
                [self.tableView deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
                [rowsToDelete release];
            } else {
                NSLog(@"Failed to fetch with error = %@", fetchingError); 
        }
        }
        
        self.fetchResult.delegate = self;
        
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
