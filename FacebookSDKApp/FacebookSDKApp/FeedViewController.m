//
//  FeedViewController.m
//  FacebookSDKApp
//
//  Created by Natasha on 11.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "FeedViewController.h"
#import "StatusCell.h"
#import "UserData.h"
@interface FeedViewController ()

@property(retain, nonatomic) NSArray *statusesArr;
@property(retain, nonatomic) NSMutableArray *allPosts;
@property(retain,nonatomic) NSString *nextPage;//older messages
@property(retain, nonatomic) NSString *previousPage;//new message
@property(assign, nonatomic) BOOL updatePreviousPage;

@end

@implementation FeedViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
#pragma mark - Next, Previous page loding
/*
-(void)loadNextPage
{
    NSURL *url = [NSURL URLWithString:self.nextPage];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    void(^nextPageBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            //add to arr
            [self userStatusLoading:con];
        }
    };
    Connect *nextPageConnect = [Connect urlRequest:req withBlock:nextPageBlock];
    [self addConnectToDict:nextPageConnect];
}

-(void)loadPreviousPage
{
    NSURL *url = [NSURL URLWithString:self.previousPage];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    self.updatePreviousPage = YES;
    
    void(^prevPageBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            //add to arr
            [self userStatusLoading:con];
        }
    };
    
    Connect *prevPageConnect = [Connect urlRequest:req withBlock:prevPageBlock];
    [self addConnectToDict:prevPageConnect];
}*/
#pragma mark - Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.allPosts count];
    if(count){
        tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"StatusCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    StatusCell *cell = (StatusCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    if([self.allPosts count]){
        NSUInteger row = [indexPath row];
        UserData *status = [self.allPosts objectAtIndex:row];
        
        cell.name = status.userFromName;
        cell.time = status.time;
        
        cell.message = status.message;
        cell.messageLabel.font = [UIFont systemFontOfSize:(CGFloat)kFontMesage];
        
        NSString *urlStr = [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture", status.userFromID];
        NSURL *url = [NSURL URLWithString:urlStr ];
        [cell.photoImageView loadImage:url ];//singleton cache
        //  "global" cache
        //  [cell.photoImageView loadImage:url cashImages:self.imageCache];
        if([self.allPosts count] < ([indexPath row] + 2)){
         //   [self loadNextPage];
        }
    }
    return cell;
}

#pragma  mark UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* text = [[self.allPosts objectAtIndex:indexPath.row] message];
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:kFontMesage]  constrainedToSize:CGSizeMake(214, 1000)];
    return MAX(75.f, textSize.height + kCellOffset);
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
