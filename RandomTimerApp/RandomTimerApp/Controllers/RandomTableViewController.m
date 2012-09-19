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

@interface RandomTableViewController ()

@end

@implementation RandomTableViewController
@synthesize fetchResult;
@synthesize tableRandomData;
@synthesize listGeneratedData;

-(void)dealloc
{
    self.fetchResult = nil;
    self.tableRandomData = nil;
    self.listGeneratedData = nil;
    [super dealloc];
}
- (NSManagedObjectContext *) managedObjectContext
{    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* managedContext = appDelegate.managedObjectContext;
    
    return managedContext;
}

-(void) initFetchResult
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"GeneratedData" inManagedObjectContext:[self managedObjectContext]];
    
    [fetchRequest setEntity:entity];
    fetchRequest.sortDescriptors = [[NSArray alloc] initWithArray: nil];//[NSSortDescriptor sortDescriptorWithKey:<#(NSString *)#> ascending:<#(BOOL)#>
    self.fetchResult  = [[[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:nil] autorelease];
    
    
    self.fetchResult.delegate = self;
    NSError *err;
    BOOL success = [fetchResult performFetch:&err];
    if (!success) {
        NSLog(@"fail");
        
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

-(void)genarate
{
    Generator* gen = [[Generator alloc] init];
    [gen doGenerate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initFetchResult];
 //   NSArray* resultArray = [self.fetchResult fetchedObjects];
    
    [self performSelector:@selector(genarate) withObject:nil afterDelay:2];
    
   }

- (void)viewDidUnload
{
     [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
            [self.listGeneratedData addObject:anObject];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationMiddle ];
        }
            break;
            
        default:
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
