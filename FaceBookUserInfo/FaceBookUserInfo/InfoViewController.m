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


@interface InfoViewController ()
@property (nonatomic, retain)NSMutableDictionary *conDict;
@property(retain, nonatomic) NSArray *statusesArr;
@property(retain, nonatomic) NSArray *feedsArr;
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
@synthesize feedsArr;
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


    self.conDict = [[[NSMutableDictionary alloc]init]autorelease];
    [self.loadImageActivity startAnimating];
    
    [self addConnectImage];
    [self addConnectInfo];
    [self addConnectStatus];
    [self addConnectFeed];
}


- (NSString*)getFileName:(NSURL*)url
{
    NSString* path = url.path;
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return [NSTemporaryDirectory() stringByAppendingPathComponent:path];
}

#pragma mark - GCD Methods
- (void)downloadImageURL:(NSURL *)imageURL
            completition:(void (^)(UIImage *))completitionBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSString *filePath =[self getFileName:imageURL];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSData *imageData = [NSData dataWithContentsOfFile:filePath];
            UIImage *image = [UIImage imageWithData:imageData];
            
            if (image) {
                    completitionBlock(image);
            return;
            }
        }
        // no cached data – download and cache
    GCD_BACKGROUND_BEGIN
        NSData* imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        if (image) {
            [imageData writeToFile:[self getFileName:imageURL] atomically:YES];
        }
        completitionBlock(image);
    GCD_END
    });
}
- (void)downloadInformation:(NSURLRequest *)infoRequest
            completition:(void (^)(NSString*))completitionBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSString* nameStr = @"";
    
        NSURLResponse *resp = nil;
        NSError *err = nil;
        NSData* data = [NSURLConnection sendSynchronousRequest:infoRequest returningResponse:&resp error:&err];
        
        SBJsonParser* parser = [[SBJsonParser alloc] init];
        NSDictionary* parseObj = [parser objectWithData:data];
        [parser release];
        if ([parseObj valueForKey:@"name"]) {
            nameStr = [parseObj valueForKey:@"name"];
        }
    
        completitionBlock(nameStr);
 
    });
}

-(void)downloadStatus:(NSURLRequest *)request completition:(void (^)(NSArray *))completitionBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray* dataArr;
        
        NSURLResponse *resp = nil;
        NSError *err = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
        
        SBJsonParser* parser = [[SBJsonParser alloc] init];
        NSDictionary* parseObj = [parser objectWithData:data];
        [parser release];
        
        if(parseObj){
           dataArr = [parseObj valueForKey:@"data"];
                       
            if([dataArr count]){
                NSDictionary *status = [dataArr objectAtIndex:0];
                
                NSString *message = [status valueForKey:@"message"];
                [self.statusesInfoTable reloadData];
                self.statusInfo.text = message;
            }
        }
        completitionBlock(dataArr);
    });
}

-(void)downloadFeed:(NSURLRequest *)request completition:(void (^)(NSArray *))completitionBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray* dataArr;
        
        NSURLResponse *resp = nil;
        NSError *err = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
        
        SBJsonParser* parser = [[SBJsonParser alloc] init];
        NSDictionary* parseObj = [parser objectWithData:data];
        [parser release];
        
        if(parseObj){
            dataArr = [parseObj valueForKey:@"data"];
            
        }
        completitionBlock(dataArr);
    });
}
#pragma mark - Add connects
-(void) addConnectImage{
    NSString *urlString = [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture", self.userIdValue];
    NSURL *url = [NSURL URLWithString:urlString ];
 //   NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
//    
//    Connect *connectImage = [Connect urlRequest:imageRequest withBlock: ^(Connect *Con, NSError *err){
//        [self.loadImageActivity stopAnimating];
//        [self userImageLoading:Con];
//       
//    }];
//    [self addConnectToDict:connectImage];
    
    void(^x)(UIImage*) = ^(UIImage* testImage)  {
        if(testImage){
            GCD_MAIN_BEGIN
            self.userImage.image = testImage;
            [self.loadImageActivity stopAnimating];
            GCD_END
        }
        else{
            [self.loadImageActivity stopAnimating];
        }
    };
    
   [self downloadImageURL:url completition:x];
}

-(void)addConnectInfo{
    NSString *urlInfoString = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/?access_token=%@", self.userIdValue, kToken] autorelease];
    NSURL *urlInfo = [NSURL URLWithString:urlInfoString];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlInfo];
    void (^infoBlock)(NSString*) = ^(NSString *name){
        if(name){
            GCD_MAIN_BEGIN
            self.nameLabel.text = name;
            GCD_END
        }
    };
    [self downloadInformation:request completition:infoBlock];
}

-(void)addConnectStatus{
    NSString *urlStatusString = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/statuses?access_token=%@", self.userIdValue, kToken] autorelease];
    NSURL *urlStatus = [NSURL URLWithString: urlStatusString];
    NSURLRequest *statusRequest= [NSURLRequest requestWithURL:urlStatus];
      
    void(^statusBlock)(NSArray*) = ^(NSArray *feed){
        if(feed){
            GCD_MAIN_BEGIN
            self.statusesArr = feed;
            [self.statusesInfoTable reloadData];
            GCD_END
        }
    };
    [self downloadStatus:statusRequest completition:statusBlock];
}
/*
- (NSComparisonResult)compare:(Person *)otherObject {
    return [self.birthDate compare:otherObject.birthDate];
}*/
-(void)addConnectFeed{
    NSString *urlFeedString = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/feed?access_token=%@", self.userIdValue, kToken] autorelease];
    NSURL *urlFeed = [NSURL URLWithString:urlFeedString];
    NSURLRequest *feedRequest= [NSURLRequest requestWithURL:urlFeed];
   
    void(^feedBlock)(NSArray*) = ^(NSArray *feed){
        if(feed){
            GCD_MAIN_BEGIN
            self.feedsArr = feed;
            
             NSMutableArray *test = [[NSMutableArray alloc]initWithObjects:self.feedsArr,self.statusesArr, nil ];
          
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"updated_time"  ascending:YES] autorelease];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [[NSArray alloc]init];
            sortedArray = [test sortedArrayUsingDescriptors:sortDescriptors];
            
            self.statusesArr = sortedArray;
            
            [self.statusesInfoTable reloadData];
                       //[self.statusesInfoTable reloadData];
            GCD_END
        }
    };
    [self downloadFeed:feedRequest completition:feedBlock];
//    Connect *connectFeed = [Connect urlRequest:feedRequest withBlock:^(Connect* con, NSError* er){
//             [self userFeedLoading:con];
//    }];
 //
 //   [self addConnectToDict:connectFeed];
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
/*
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
    
    if([dataArr count]){
    NSDictionary *status = [dataArr objectAtIndex:0];
   
    NSString *message = [status valueForKey:@"message"];
    [self.statusesInfoTable reloadData];
    self.statusInfo.text = message;
    }
}

-(void)userFeedLoading:(Connect*)connect{
    NSDictionary* parseObj = [connect objectFromResponce];
    
    NSArray *dataArr = [parseObj valueForKey:@"data"];
   
    if([dataArr count]){
    NSDictionary *status = [dataArr objectAtIndex:0];
    self.feedsArr = dataArr;
    }
    
    //arr of feed , sort by updated_time???
//@!!!!
}
*/
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