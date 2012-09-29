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
#import "NSDate+DateFormat.h"
@interface FeedViewController ()

@property(retain, nonatomic) NSArray *statusesArr;
@property(retain, nonatomic) NSMutableArray *allPosts;
@property(retain, nonatomic) NSString *nextPage;//older messages
@property(retain, nonatomic) NSString *previousPage;//new message
@property(assign, nonatomic) BOOL updatePreviousPage;
@property(retain, nonatomic) NSMutableSet* idPost;

@end

@implementation FeedViewController
@synthesize idPost;
@synthesize allPosts;
@synthesize nextPage;
@synthesize previousPage;
@synthesize statusesArr;
- (void)dealloc
{
    self.statusesArr = nil;
    self.allPosts = nil;
    self.nextPage = nil;
    self.previousPage = nil;
    self.idPost = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.separatorColor = [UIColor clearColor];
    
    ODRefreshControl *refreshControl = [[[ODRefreshControl alloc] initInScrollView:self.tableView] autorelease];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    self.idPost = [[NSMutableSet alloc]init];
    self.updatePreviousPage = NO;
    [self statusLoading];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.statusesArr = nil;
    self.allPosts = nil;
    self.nextPage = nil;
    self.previousPage = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - ODRefreshControl Method

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self loadPreviousPage];
        [refreshControl endRefreshing];
    });
}

#pragma mark - next, previous pages 

- (void)loadNextPage
{
    NSURL *url = [NSURL URLWithString:self.nextPage];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    void(^nextPageBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            //add to arr
            [self userStatusParsing:con];
        }
    };
    [Connect urlRequest:req withBlock:nextPageBlock];
}

- (void)loadPreviousPage
{
    NSURL *url = [NSURL URLWithString:self.previousPage];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    self.updatePreviousPage = YES;
    
    void(^prevPageBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            //add to arr
            [self userStatusParsing:con];
        }
    };
    
  [Connect urlRequest:req withBlock:prevPageBlock];
}


#pragma mark - status loading

- (void)statusLoading
{
    NSMutableDictionary *dictparametrs = [[SettingManager sharedInstance] baseDict];
    [dictparametrs setValue:@"message,from,likes,comments" forKey: kFields];
    NSString *path = [dictparametrs paramFromDict];
    
    NSString *urlStr = [[[NSString alloc] initWithFormat: @"%@/me/feed?%@", basePathUrl, path] autorelease];
    
    NSURL *urlStatus = [NSURL URLWithString: urlStr];
    NSURLRequest *statusRequest= [NSURLRequest requestWithURL:urlStatus];
    
    void(^statusBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            [self userStatusParsing:con];
        }
    };
    [Connect urlRequest: statusRequest withBlock:statusBlock];
}

#pragma mark - status info parsing

- (void)userStatusParsing:(Connect*)connect
{
    NSDictionary* parseObj = [connect objectFromResponce];
    NSArray *dataArr = [parseObj valueForKey:kData];
    NSDictionary *pageDict = [parseObj valueForKey:kPaging];
    if([pageDict valueForKey: kNext]){
        self.nextPage = [pageDict valueForKey: kNext];
    }
    // пустой
    if(![self.allPosts count]) {
        self.previousPage = [pageDict valueForKey:kPrevious];
        self.allPosts = [self updateDataInTable:[self onlyHasMessagePost:dataArr]];
        [self.tableView reloadData];
    }
    else{
        if(self.nextPage)
            [self userNextPageStatusLoading:dataArr];
    }
    //need to update previous page when customer pull to refresh
    if(self.updatePreviousPage){
        self.updatePreviousPage = NO;
        
        [self userPrevPageStatusLoading:dataArr];
        self.previousPage = [pageDict valueForKey:kPrevious];
    }
}

- (NSMutableArray*)updateDataInTable:(NSArray*)newPosts
{
    NSMutableArray* uniqPosts = [[NSMutableArray alloc] init];
    NSMutableArray *updateIndexPaths = [[NSMutableArray alloc] init];
    for (UserData* userData in newPosts) {
        if(![self.idPost containsObject: userData.feedID]){
            [uniqPosts addObject:userData];
            [self.idPost addObject:userData.feedID];
            NSUInteger i = [self indexOfAccessibilityElement:userData];
            if(i != NSNotFound) {
                [updateIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        }
    }
    [self.tableView reloadRowsAtIndexPaths:updateIndexPaths withRowAnimation: UITableViewRowAnimationTop];
    [updateIndexPaths release];
    return uniqPosts;
}

- (void)userPrevPageStatusLoading:(NSArray*) dataArr
{
    NSArray *add = [self updateDataInTable: [self onlyHasMessagePost:dataArr]];
//  [self updateDataInTable: [self onlyHasMessagePost:dataArr]];  [self updateDataInTable:add];
    NSArray *tempArray = [add arrayByAddingObjectsFromArray:self.allPosts ];
    self.allPosts = (NSMutableArray *)tempArray;
    //[self.allPosts sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES]]];
}

-(void)userNextPageStatusLoading:(NSArray*) dataArr
{
    NSArray *add =   [self updateDataInTable:[self onlyHasMessagePost:dataArr]];
    //[self updateDataInTable:add];
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

- (NSMutableArray *)onlyHasMessagePost: (NSArray *)allPost
{
    NSMutableArray *onlyMessage = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *resultArr = [NSMutableArray array];
    
    for(int i = 0; i < [allPost count]; i++){
        if([[allPost objectAtIndex:i]valueForKey:kMessage]){
            [onlyMessage addObject:[allPost objectAtIndex:i]];
            NSDictionary *temp = [allPost objectAtIndex:i];
            UserData *data = [[UserData alloc] init];
            if([temp valueForKey:kMessage]) {
                data.message = [temp valueForKey:kMessage];
            }
            if([temp valueForKey: kFrom]) {
                NSDictionary* from = [temp valueForKey: kFrom];
                data.userFromID = [from valueForKey: kId];
                data.userFromName = [from valueForKey: kName];
            }
            if([temp valueForKey: kTime]) {
                
                data.time = [self dateFromString:[temp valueForKey: kTime]];
            }
            if([temp valueForKey: kId]) {
                data.feedID = [temp valueForKey: kId];
            }
            if([temp valueForKey: kLikes]) {
                data.likes = [temp valueForKey: kLikes];
                id i = [data.likes valueForKey: kCount];
                NSLog(@"%@", i);
            }
            if([temp valueForKey: kComments]) {
                data.comments = [temp valueForKey: kComments];
            }
            [resultArr addObject:data];
            [data release];
        }
    }
    return resultArr;
}

- (NSDate*) dateFromString: (NSString*) string
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc ] init] autorelease];
    [formatter setDateFormat: dateFormatISO8601];
    NSDate *resultDate = [formatter dateFromString:string];
    return resultDate;
}


- (NSString*) stringWithDate: (NSDate*) date
{
     
    NSDateFormatter *_formatter = [[[NSDateFormatter alloc ] init] autorelease];
    [_formatter setDateFormat: dateFormatStatus];
    NSString *resStrDate = [_formatter stringFromDate:date];
    return resStrDate;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.allPosts count];
    if(count){
        tableView.separatorColor = [UIColor brownColor];
        tableView.separatorStyle = UITableViewStylePlain;
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
        
        if(status.userFromName != status.userName) {
            cell.nameLabel.text = status.userFromName;
        }
        cell.timeLabel.text = [status.time dateStringWithFormat];
        
        cell.messageLabel.text = status.message;
        cell.messageLabel.font = [UIFont systemFontOfSize:(CGFloat)kFontMesage];
        
        if([status.likes valueForKey: kCount]){
            NSNumber* i = [status.likes valueForKey: kCount];
            cell.likeLabel.text = [i stringValue];
        } else {
            cell.likeLabel.text = @"0";
        }
       
        NSString *urlStr = [NSString stringWithFormat: @"%@/%@/picture?%@", basePathUrl, status.userFromID, [[[SettingManager sharedInstance] baseDict] paramFromDict]];
        NSURL *url = [NSURL URLWithString:urlStr ];
        [cell.photoImageView loadImage:url ];//singleton cache
        //  if "global" cache
        //  [cell.photoImageView loadImage:url cashImages:self.imageCache];
        if([self.allPosts count] < ([indexPath row] + 7)){
            [self loadNextPage];
        }
    }
    return cell;
}

#pragma  mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* text = [[self.allPosts objectAtIndex:indexPath.row] message];
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:kFontMesage]  constrainedToSize:CGSizeMake(280, 2000)];
    return MAX(cellHeight, textSize.height + kCellOffset) ;
}

@end
