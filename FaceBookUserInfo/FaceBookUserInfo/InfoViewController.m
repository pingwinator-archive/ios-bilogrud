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
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
                       
    self.conDict = [[[NSMutableDictionary alloc]init]autorelease];
  //  [self.loadImageActivity startAnimating];
    self.imageCache = [[NSCache alloc]init];
    self.statusesInfoTable.separatorColor = [UIColor clearColor];
    [self addConnectImage];
    [self addConnectInfo];
    [self addConnectStatus];
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

-(void)cashingImage:(NSURL *)url dataImage:(NSData *)_data{
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
-(void) addConnectImage
{    
   NSString *urlStr = [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture", self.userIdValue];
   NSURL *url = [NSURL URLWithString:urlStr ];

    [self.userImage loadImage:url ];// cashImages:self.imageCache];
     //  SelfloadImage *test = [[SelfloadImage alloc]init];
  //  UIImage *image = [test loadImage:url];
//    if ([self isImageInCash:url]) {
//           self.userImage.image = [self loadFromCash:url];
//          [self.loadImageActivity stopAnimating];
//    } else {
//      void(^imageBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
//        if(!err){
//            [self cashingImage:url dataImage:con.data];
//            [self userImageLoading:con];
//        }
//        [self closeImageDownloading:con];
//    };
//        
//    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
//    Connect *connectImage = [Connect urlRequest:imageRequest withBlock: imageBlock];
//    [self addConnectToDict:connectImage];
//    }
}

-(void)addConnectInfo{
  
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

-(void)addConnectStatus{
    
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - connection dict

-(void)addConnectToDict: (Connect *)con{
    [self.conDict setValue:con forKey:[con description]];
}

- (void)removeConnect:(Connect*)connect{
    NSString* key =  [connect description];
    [connect retain];
    [self.conDict removeObjectForKey:key];
    [connect autorelease];
}

-(Connect*)connectByConnection: (NSURLConnection*) con{
    return [self.conDict valueForKey:con.description];
}

#pragma mark - ConnectDelegate Method
-(void)didLoadingData:(Connect *)connect error:(NSError *)err{  

}

#pragma mark - Data loading

-(void)userImageLoading: (Connect*)connect{
    GCD_MAIN_BEGIN
    
    UIImage *testImage = [UIImage imageWithData: connect.data];
    if (testImage) {
        self.userImage.image = testImage;
    }
    GCD_END
}

-(void)userInfoLoading:(Connect*)connect{
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
-(void)loadNextPage{
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

-(NSMutableArray *)messagePost: (NSArray *)allPost{
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
-(void)userStatusLoading:(Connect*)connect{
    NSDictionary* parseObj = [connect objectFromResponce];
    NSArray *dataArr = [parseObj valueForKey:@"data"];
    NSDictionary *pageDict = [parseObj valueForKey:@"paging"];
    self.nextPage = [pageDict valueForKey:@"next"];
    
    if([self.allPosts count])
    {
        NSArray *add = [self messagePost:dataArr];
        self.allPosts = [self.allPosts arrayByAddingObjectsFromArray:add];
    }
    else
    {
        self.allPosts = [self messagePost:dataArr];
    }
    if([self.allPosts count]){
        [self.statusesInfoTable reloadData];
    }
}

#pragma  mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [self.allPosts count];
    if(count){
        self.statusesInfoTable.separatorColor = [UIColor groupTableViewBackgroundColor];// lightGrayColor];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *CellTableIdentifier = @"CellTableIdentifier";
    
  
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"Cell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
            nibsRegistered = YES;
        }
     Cell *cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
 

    if([self.allPosts count] != 0){
      
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
        
        NSLog(@"indexPath row: %d\n",[indexPath row] );
        NSLog(@"allPosts %d", [self.allPosts count]);
        
        if([self.allPosts count] < ([indexPath row] + 6)){
            [self loadNextPage];
        }
    }
    
 
    return cell;
}

#pragma  mark UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* text = [[self.allPosts objectAtIndex:indexPath.row] message];
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:kFontMesage]  constrainedToSize:CGSizeMake(214, 1000)];
    
    return MAX(75.f, textSize.height + kCellOffset);
}

@end