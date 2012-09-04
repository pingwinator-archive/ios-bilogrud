//
//  InfoViewController.m
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "InfoViewController.h"
#import "SBJson.h"
#import "Connect.h"
#include <dispatch/dispatch.h>

#define kToken @"AAACEdEose0cBAErmwTIrNeZAJJJa7tFsbMip29o37J3QY1g7naDkdZA1oYobDbZAqvAInvlC1VvVo6fYncBLsDdLykO3EwFDE0IUEGfZBzntZBai1CYiX"

#define kUserInfoTag 1
#define kUserImage 2
#define kUserStatus 3
#define kUserFeedTag 4
@interface InfoViewController ()
@property (nonatomic, retain)NSMutableDictionary *conDict;
@end

@implementation InfoViewController
@synthesize personalInfo;
@synthesize userImage;
@synthesize testImageConnection;
@synthesize testData;
@synthesize conDict;
@synthesize userIdValue;
@synthesize loadImageActivity;
@synthesize nameLabel;
@synthesize statusInfo;
@synthesize statusesInfoTable;
@synthesize statusesArr;
-(void)dealloc{
    self.userImage = nil;
    self.personalInfo = nil;
    self.testImageConnection = nil;
    self.testData = nil;
    self.conDict = nil;
    self.userIdValue = nil;
    self.loadImageActivity = nil;
    self.nameLabel = nil;
    self.statusInfo = nil;
    self.statusesArr = nil;
    self.statusesInfoTable = nil;
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
//    //image loading
//    NSString* urlsstring =@"https://graph.facebook.com/100001866482612/picture";
//    NSURL* url = [NSURL URLWithString:urlsstring];
//    NSURLRequest* req = [NSURLRequest requestWithURL:url];
//    NSOperationQueue* queue = [NSOperationQueue mainQueue];
//   [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse* resp, NSData* data, NSError* error){
//       UIImage* image = [UIImage imageWithData:data];
//       self.userImage.image = image;
//    }];

    self.conDict = [[[NSMutableDictionary alloc]init]autorelease];
    [self.loadImageActivity startAnimating];
    
    [self addConnectImage];
    [self addConnectInfo];
    [self addConnectStatus];
    [self addConnectFeed];
}

#pragma mark - Add connects
- (void)downloadImageURL:(NSURL *)imageURL
            completition:(void (^)(UIImage *))completitionBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // cached image filename
//        NSString *filePath = getCachePath(imageURL);
//        // try to get cached image
//        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//            NSData *imageData = [NSData dataWithContentsOfFile:filePath]; UIImage *image = [UIImage imageWithData:imageData];
//            // if succeeded - call completition block and return
//            if (image) {
//                // call completition on main queue (thread)
//                dispatch_async(dispatch_get_main_queue(), ^{ completitionBlock(image); });
//                return; }
//        }
        // no cached data – download and cache
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) { // download image data and create UIImage
            NSData* imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:imageData];
//            if (image) {
//                // cache to disk
//                dispatch_async(dispatch_get_global_queue(0, 0), ^(void) { [imageData writeToFile:getCachePath(imageURL) atomically:YES]; });
//            }
//          //  call completition on main queue (thread)
//            ￼￼//
            dispatch_async(dispatch_get_main_queue(), ^{ completitionBlock(image); });
        }); });
}
-(void) addConnectImage{
    NSString *urlString = [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture", self.userIdValue];
    NSURL *url = [NSURL URLWithString:urlString ];
//    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
//    
//    Connect *connectImage = [Connect urlRequest:imageRequest withBlock: ^(Connect *Con, NSError *err){
//        [self.loadImageActivity stopAnimating];
//        [self userImageLoading:Con];
//       
//    }];
//    [self addConnectToDict:connectImage];
    
    [self downloadImageURL:url completition:^(UIImage* testImage)  {
        self.userImage.image = testImage;
        [self.loadImageActivity stopAnimating];
    }];
   
}

-(void)addConnectInfo{
    NSString *urlInfoString = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/?access_token=%@", self.userIdValue, kToken] autorelease];
    NSURL *urlInfo = [NSURL URLWithString:urlInfoString];
    NSURLRequest *infoRequest= [NSURLRequest requestWithURL:urlInfo];
    
    Connect *connectInfo = [Connect urlRequest:infoRequest withBlock:^(Connect* con, NSError* er){
                 [self userStatusLoading:con];
    }];

    [self addConnectToDict:connectInfo];
    //[connectInfo release];
}

-(void)addConnectStatus{
    NSString *urlStatusString = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/statuses?access_token=%@", self.userIdValue, kToken] autorelease];
    NSURL *urlStatus = [NSURL URLWithString: urlStatusString];
    NSURLRequest *statusRequest= [NSURLRequest requestWithURL:urlStatus];
    
    Connect *connectStatus = [Connect urlRequest:statusRequest  withBlock:^(Connect* con, NSError* er){
          [self userStatusLoading:con];
    }];
     
    [self addConnectToDict:connectStatus];
   // [connectStatus release];
}

-(void)addConnectFeed{
    NSString *urlFeedString = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/feed?access_token=%@", self.userIdValue, kToken] autorelease];
    NSURL *urlFeed = [NSURL URLWithString:urlFeedString];
    NSURLRequest *feedRequest= [NSURLRequest requestWithURL:urlFeed];
   
    Connect *connectFeed = [Connect urlRequest:feedRequest withBlock:^(Connect* con, NSError* er){
             [self userFeedLoading:con];
    }];
   
    [self addConnectToDict:connectFeed];
    //[connectFeed release];
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
    self.loadImageActivity = nil;
    self.nameLabel = nil;
    self.statusInfo = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
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

-(void)deleteConnectFromDict: (NSURLConnection*)con{
     NSString* key =  [con description];
     [self.conDict removeObjectForKey:key];
}

-(Connect*)connectByConnection: (NSURLConnection*) con{
    return [self.conDict valueForKey:con.description];
}

#pragma mark - ConnectDelegate Method

-(void)didLoadingData:(Connect *)connect error:(NSError *)err{  /*  
if (!err) {
        NSLog(@"connect");
        switch (connect.tag) {
            case kUserImage:{
                [self userImageLoading:connect];
            }
                break;
            case kUserInfoTag:{
                [self userInfoLoading:connect];
            }
                break;
            case kUserStatus:
            {
                [self userStatusLoading:connect];
            }
            case kUserFeedTag:{
                [self userFeedLoading:connect];
            }
                break;
            default:
                break;
        }
    }
    else{
        if(connect.responceType == eResponceTypeImage){
            [self.loadImageActivity stopAnimating];
        }
    }
    [self deleteConnectFromDict:connect.connection];
  */
}
#pragma mark - Data loading by tag
-(void)userImageLoading: (Connect*)connect{
    UIImage *testImage = [UIImage imageWithData: connect.data];
    [self.loadImageActivity stopAnimating];
    self.userImage.image = testImage;
}

-(void)userInfoLoading:(Connect*)connect{
    NSDictionary* parseObj = [connect objectFromResponce];
    if ([parseObj valueForKey:@"name"]) {
        self.nameLabel.text = [parseObj valueForKey:@"name"];
    }
    
    NSMutableString* information = [[[NSMutableString alloc]init]autorelease];
    
    if ([parseObj valueForKey:@"birthday"]) {
        [information appendFormat:@"Birthday: %@\n",[parseObj valueForKey:@"birthday"] ] ;
    }
    NSDictionary *location = [parseObj valueForKey:@"location"];
    if([location valueForKey:@"name"]){
        [information appendFormat:@"Location: %@\n",[location valueForKey:@"name"] ] ;
    }
    //...
    self.personalInfo.text = information;
}

-(void)userStatusLoading:(Connect*)connect{
    NSDictionary* parseObj = [connect objectFromResponce];
    NSArray *dataArr = [parseObj valueForKey:@"data"];
    self.statusesArr = dataArr;
    
    NSDictionary *status = [dataArr objectAtIndex:0];
   
    NSString *message = [status valueForKey:@"message"];
    [self.statusesInfoTable reloadData];
    self.statusInfo.text = message;
}

-(void)userFeedLoading:(Connect*)connect{
    NSDictionary* parseObj = [connect objectFromResponce];
    
    NSArray *dataArr = [parseObj valueForKey:@"data"];
   
    NSDictionary *status = [dataArr objectAtIndex:0];
//@!!!!
}

#pragma  mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (self.statusesArr) ?([self.statusesArr count]):0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"SimpleTableId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier] autorelease];
        
    }
    NSUInteger row = [indexPath row];
    if([self.statusesArr count] != 0){
    NSDictionary *status = [self.statusesArr objectAtIndex:row];
    
    NSString *message = [status valueForKey:@"message"];
    NSString *time = [status valueForKey:@"updated_time"];
    cell.textLabel.text = message;
    cell.detailTextLabel.text = time;
    }
    return cell;
}
#pragma  mark UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end