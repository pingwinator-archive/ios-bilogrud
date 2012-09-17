//
//  InfoViewController.m
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//
#import <dispatch/dispatch.h>
#import "InfoViewController.h"
#import "SBJson.h"
#import "Connect.h"
#import "NSDictionary+HTTPParametrs.h"
#import "UserData.h"
#import "Cell.h"

@interface InfoViewController()<UITableViewDataSource, UITableViewDelegate>
{
}
@property (nonatomic, retain) NSMutableDictionary *conDict;
@property(retain, nonatomic) NSArray *statusesArr;
@property(retain, nonatomic) NSMutableArray *allPosts;
@property(retain,nonatomic) NSString *nextPage;//older messages
@property(retain, nonatomic) NSString *previousPage;//new message
//@property(retain,nonatomic) NSArray *testArrayWith;
@property(assign, nonatomic) BOOL updatePreviousPage;
@end

@implementation InfoViewController
@synthesize personalInfo;
@synthesize userImage;
@synthesize testImageConnection;
@synthesize testData;
@synthesize conDict;
@synthesize userIdValue;
@synthesize nameLabel;
@synthesize statusesInfoTable;
@synthesize statusesArr;
@synthesize allPosts;
@synthesize imageCache;
@synthesize nextPage;
@synthesize previousPage;
@synthesize updatePreviousPage;
@synthesize postButton;
@synthesize textPost;
-(void)dealloc{
    self.userImage = nil;
    self.personalInfo = nil;
    self.testImageConnection = nil;
    self.testData = nil;
    self.conDict = nil;
    self.userIdValue = nil;
    self.nameLabel = nil;
    self.statusesArr = nil;
    self.statusesInfoTable = nil;
    self.imageCache = nil;
    self.nextPage = nil;
    self.pagingStructure = nil;
    self.textPost = nil;
    self.postButton = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    ODRefreshControl *refreshControl = [[[ODRefreshControl alloc] initInScrollView:self.statusesInfoTable]autorelease];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
      self.updatePreviousPage = NO;
    
    self.textPost.delegate = self;
    self.conDict = [[[NSMutableDictionary alloc]init]autorelease];
   //if use cache loading
    // self.imageCache = [[NSCache alloc]init];
    self.statusesInfoTable.separatorColor = [UIColor clearColor];
    [self loadImage];
    [self addConnectInfo];
    [self addConnectStatus];
}
#pragma mark - Post Methods
-(IBAction)post
{
    NSString *message =self.textPost.text;
    NSMutableDictionary *dictparametrs = [NSMutableDictionary dictionary];
    [dictparametrs setValue:kToken forKey:@"access_token"];
    [dictparametrs setValue:message forKey:@"message"];

    NSString *urlStr = [[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/feed", userIdValue];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];

     [request setHTTPMethod:@"POST"];
    
     NSString *postParam = [dictparametrs paramFromDict];
    
      NSData *postData = [postParam dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
      [request setHTTPBody:postData];
    
    void(^postBlock)(Connect *, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message was send" message:self.textPost.text delegate:nil cancelButtonTitle:@"great!" otherButtonTitles: nil];
            [alert show];
        }
    };
    
      Connect *post = [Connect urlRequest:request withBlock:postBlock];
    [ self addConnectToDict:post];
}

- (NSMutableDictionary*)baseDict
{
    NSMutableDictionary *dictparametrs = [NSMutableDictionary dictionary];
    [dictparametrs setValue:kToken forKey:@"access_token"];
    return dictparametrs;
}

- (NSString*)getFileName:(NSURL*)url
{
    NSString* path = url.path;
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return [NSTemporaryDirectory() stringByAppendingPathComponent:path];
}

-(void)closeImageDownloading:(Connect*)con
{
    [self removeConnect:con];
}

-(BOOL)isImageInCash:(NSURL *)imageURL
{
    return ([[NSFileManager defaultManager] fileExistsAtPath: [self getFileName:imageURL]]);
}

-(void)cashingImage:(NSURL *)url dataImage:(NSData *)_data
{
    [_data writeToFile:[self getFileName:url] atomically:YES];
}

-(UIImage *)loadFromCash:(NSURL*)url
{
    NSString *filePath =[self getFileName:url];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *testImage = [UIImage imageWithData: imageData];
    
    return testImage;
}

#pragma mark - Add connects

-(void) loadImage
{    
   NSString *urlStr = [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture", self.userIdValue];
   NSURL *url = [NSURL URLWithString:urlStr ];

   [self.userImage loadImage:url ];// cashImages:self.imageCache];
}

-(void)addConnectInfo
{
    NSMutableDictionary *dictparametrs = [self baseDict];
    NSString *path = [dictparametrs paramFromDict];
     NSString *urlStr = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/?%@", self.userIdValue, path] autorelease];
    
    NSURL *urlInfo = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlInfo];
 
    void(^infoBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            [self userInfoLoading:con];
        }
    };
    Connect *connectInfo = [Connect urlRequest:request withBlock:infoBlock];
    [self addConnectToDict:connectInfo];
}

-(void)addConnectStatus
{    
    NSMutableDictionary *dictparametrs = [self baseDict];
    
    [dictparametrs setValue:@"message,from" forKey:@"fields"];
    NSString *path = [dictparametrs paramFromDict];
    
    NSString *urlStr = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/feed?%@", self.userIdValue, path] autorelease];
    
    
    NSURL *urlStatus = [NSURL URLWithString: urlStr];
    NSURLRequest *statusRequest= [NSURLRequest requestWithURL:urlStatus];
      
    void(^statusBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            [self userStatusLoading:con];
        }
    };
    Connect *connectStatus = [Connect urlRequest: statusRequest withBlock:statusBlock];
    [self addConnectToDict:connectStatus];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.userImage = nil;
    self.personalInfo = nil;
    self.testImageConnection = nil;
    self.testData = nil;
    self.conDict = nil;
    self.userIdValue = nil;
    self.nameLabel = nil;
    self.statusesArr = nil;
    self.statusesInfoTable = nil;
    self.imageCache = nil;
    self.nextPage = nil;
    self.pagingStructure = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - connection dict

-(void)addConnectToDict: (Connect *)con
{
    [self.conDict setValue:con forKey:[con description]];
}

- (void)removeConnect:(Connect*)connect
{
    NSString* key =  [connect description];
    [connect retain];
    [self.conDict removeObjectForKey:key];
    [connect autorelease];
}

-(Connect*)connectByConnection: (NSURLConnection*) con
{
    return [self.conDict valueForKey:con.description];
}

#pragma mark - Data loading

-(void)userImageLoading: (Connect*)connect
{
GCD_MAIN_BEGIN
    UIImage *testImage = [UIImage imageWithData: connect.data];
    if (testImage) {
        self.userImage.image = testImage;
    }
GCD_END
}

-(void)userInfoLoading:(Connect*)connect
{
    NSDictionary* parseObj = [connect objectFromResponce];
    
    if ([parseObj valueForKey:@"name"]) {
        self.nameLabel.text = [parseObj valueForKey:@"name"];
    }
    NSString* information = @"";
    
    if ([parseObj valueForKey:@"birthday"]) {
        information = [information stringByAppendingFormat: @"Birthday: %@\n",[parseObj valueForKey:@"birthday"] ] ;
    }
    NSDictionary *location = [parseObj valueForKey:@"location"];
    if([location valueForKey:@"name"]){
        information = [information stringByAppendingFormat:@"Location: %@\n",[location valueForKey:@"name"] ] ;
    }
    //...
    self.personalInfo.text = information;
}

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
}

-(NSMutableArray *)messagePost: (NSArray *)allPost
{
    NSMutableArray *onlyMessage = [[[NSMutableArray alloc]init]autorelease];
    NSMutableArray *resultArr = [NSMutableArray array];

    for(int i = 0; i < [allPost count]; i++){
        if([[allPost objectAtIndex:i]valueForKey:@"message"]){
            [onlyMessage addObject:[allPost objectAtIndex:i]];
            NSDictionary *temp = [allPost objectAtIndex:i];
            UserData *data = [[UserData alloc]init];
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

-(void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{ 
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self loadPreviousPage];
        [refreshControl endRefreshing];
    });
}

-(void)userPrevPageStatusLoading:(NSArray*) dataArr
{
      NSArray *add = [self messagePost:dataArr];
      NSArray *tempArray = [add arrayByAddingObjectsFromArray:self.allPosts ];
      self.allPosts = (NSMutableArray *)tempArray;
}

-(void)userNextPageStatusLoading:(NSArray*) dataArr
{
      NSArray *add = [self messagePost:dataArr];
      NSArray *tempArray = [self.allPosts arrayByAddingObjectsFromArray:add];
      self.allPosts =  (NSMutableArray *)tempArray;
            //            NSArray *test = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.allPosts count]-1 inSection:0] ];
            // [self.statusesInfoTable insertRowsAtIndexPaths:test withRowAnimation:NO];
            
           //   [self.statusesInfoTable insertRowsAtIndexPaths:add withRowAnimation:UITableViewRowAnimationTop];
            
            
            //            NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
            //            int ind;
            //            int beginIndex = [self.allPosts count] - [add count];
            //            int endIndex = [self.allPosts count];
            //            for (ind = beginIndex; ind < endIndex; ind++){
            //                NSIndexPath *newPath = [NSIndexPath indexPathForRow:ind inSection:0];
            //                [insertIndexPaths addObject:newPath];
            //            }
            //
            //            [[self statusesInfoTable] reloadData];
            //            [self.statusesInfoTable insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
            
            //            [insertIndexPaths release];
}

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
        self.allPosts = [self messagePost:dataArr];
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
        [self.statusesInfoTable reloadData];
    }
}

#pragma  mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.allPosts count];
    if(count){
        self.statusesInfoTable.separatorColor = [UIColor groupTableViewBackgroundColor];// lightGrayColor];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellTableIdentifier = @"CellTableIdentifier";
    
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"Cell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
            nibsRegistered = YES;
        }
     Cell *cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

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
    return MAX(75.f, textSize.height + kCellOffset);
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITextFieldDelegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end