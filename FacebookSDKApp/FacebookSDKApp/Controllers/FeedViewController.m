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
#import "NSDictionary+HTTPParametrs.h"
#import "ODRefreshControl.h"
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

    
    ODRefreshControl *refreshControl = [[[ODRefreshControl alloc] initInScrollView:self.tableView] autorelease];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    self.updatePreviousPage = NO;
    [self addConnectStatus];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - ODRefreshControl Method
-(void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
     //   [self loadPreviousPage];
        [refreshControl endRefreshing];
    });
}
#pragma mark - next, previous pages 

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
    [Connect urlRequest:req withBlock:nextPageBlock];
    //[self addConnectToDict:nextPageConnect];
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
    
  [Connect urlRequest:req withBlock:prevPageBlock];
}


#pragma mark - connect status
-(void)addConnectStatus
{
    NSMutableDictionary *dictparametrs = [[SettingManager sharedInstance]baseDict];
    [dictparametrs setValue:@"message,from" forKey:@"fields"];
    NSString *path = [dictparametrs paramFromDict];
    
    NSString *urlStr = [[[NSString alloc] initWithFormat: @"%@/me/feed?%@", basePathUrl, path] autorelease];
    
    
    NSURL *urlStatus = [NSURL URLWithString: urlStr];
    NSURLRequest *statusRequest= [NSURLRequest requestWithURL:urlStatus];
    
    void(^statusBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            [self userStatusLoading:con];
        }
    };
    [Connect urlRequest: statusRequest withBlock:statusBlock];
}

#pragma mark status loading

-(void)userStatusLoading:(Connect*)connect
{
    NSDictionary* parseObj = [connect objectFromResponce];
    NSArray *dataArr = [parseObj valueForKey:@"data"];
    NSDictionary *pageDict = [parseObj valueForKey:@"paging"];
    if([pageDict valueForKey:@"next"]){
        self.nextPage = [pageDict valueForKey:@"next"];
    }
    // пустой
    if(![self.allPosts count]) {
        self.previousPage = [pageDict valueForKey:@"previous"];
        self.allPosts = [self onlyHasMessagePost:dataArr];
        NSLog(@" last %@",[[self.allPosts lastObject] message]);
    }
    else{
        if(self.nextPage)
            [self userNextPageStatusLoading:dataArr];
    }
    //need to update previous page when customer pull to refresh
    if(self.updatePreviousPage){
        self.updatePreviousPage = NO;
        
        [self userPrevPageStatusLoading:dataArr];
        self.previousPage = [pageDict valueForKey:@"previous"];
    }
    if([self.allPosts count]){
        [self.tableView reloadData];
    }
}


-(void)userPrevPageStatusLoading:(NSArray*) dataArr
{
    NSArray *add = [self onlyHasMessagePost:dataArr];
    NSArray *tempArray = [add arrayByAddingObjectsFromArray:self.allPosts ];
    self.allPosts = (NSMutableArray *)tempArray;
}

-(void)userNextPageStatusLoading:(NSArray*) dataArr
{
    NSArray *add = [self onlyHasMessagePost:dataArr];
    NSArray *tempArray = [self.allPosts arrayByAddingObjectsFromArray:add];
    self.allPosts =  (NSMutableArray *)tempArray;

    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    int ind;
    int beginIndex = [self.allPosts count] - [add count];
    int endIndex = [self.allPosts count];
    for (ind = beginIndex; ind < endIndex; ind++){
       NSIndexPath *newPath = [NSIndexPath indexPathForRow:ind inSection:0];
      [insertIndexPaths addObject:newPath];
    }
    
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    
    [insertIndexPaths release];
}


-(NSMutableArray *)onlyHasMessagePost: (NSArray *)allPost
{
    NSMutableArray *onlyMessage = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *resultArr = [NSMutableArray array];
    
    for(int i = 0; i < [allPost count]; i++){
        if([[allPost objectAtIndex:i]valueForKey:@"message"]){
            [onlyMessage addObject:[allPost objectAtIndex:i]];
            NSDictionary *temp = [allPost objectAtIndex:i];
            UserData *data = [[UserData alloc] init];
            if([temp valueForKey:@"message"]) {
                data.message = [temp valueForKey:@"message"];
            }
            if([temp valueForKey: @"from"]) {
                NSDictionary* from = [temp valueForKey:@"from"];
                data.userFromID = [from valueForKey: @"id"];
                data.userFromName = [from valueForKey: @"name"];
            }
            if([temp valueForKey: @"created_time"]) {
                data.time = [temp valueForKey: @"created_time"];
            }
            if([temp valueForKey: @"id"]) {
                data.feedID = [temp valueForKey: @"id"];
            }
            [resultArr addObject:data];
            [data release];
        }
    }
    return resultArr;
}


#pragma mark - Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.allPosts count];
    if(count){
        tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    }
    return count;
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
        
        NSString *urlStr = [NSString stringWithFormat: @"%@/%@/picture?%@", basePathUrl, status.userFromID, [[[SettingManager sharedInstance] baseDict] paramFromDict]];
        NSURL *url = [NSURL URLWithString:urlStr ];
        [cell.photoImageView loadImage:url ];//singleton cache
        //  "global" cache
        //  [cell.photoImageView loadImage:url cashImages:self.imageCache];
        if([self.allPosts count] < ([indexPath row] + 2)){
        [self loadNextPage];
        }
    }
    return cell;
}

#pragma  mark UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* text = [[self.allPosts objectAtIndex:indexPath.row] message];
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:kFontMesage]  constrainedToSize:CGSizeMake(214, 1000)];
    return MAX(93.f, textSize.height + kCellOffset);
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
