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

#define kToken @"AAACEdEose0cBAIHIj5UxZBold7tikDV9KSnJBKRComMZA0NOhOUyLlbEsI7ZAr1D5eNtCa37JnSkJh7hchoazFXAPZBhClk2jViL7r3peulwhe8gCMt1"
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
-(void)dealloc{
    self.userImage = nil;
    self.personalInfo = nil;
    self.testImageConnection = nil;
    self.testData = nil;
    self.conDict = nil;
    self.userIdValue = nil;
    self.loadImageActivity = nil;
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
    NSString *urlString = [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture", self.userIdValue];
    NSURL *url = [NSURL URLWithString:urlString ];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
   
    NSURLConnection *imageCon = [NSURLConnection connectionWithRequest:imageRequest delegate:self];

    Connect *connectImage = [[Connect alloc] initConnect:imageCon responce:eResponceTypeImage];
    [self addConnectionToDict:connectImage];
    [connectImage startConnect];
    [connectImage release];
    
    NSString *urlInfoString = [[[NSString alloc]initWithFormat: @"https://graph.facebook.com/%@/?access_token=%@", self.userIdValue,kToken]autorelease];
    NSURL *urlInfo = [NSURL URLWithString:urlInfoString];
    NSURLRequest *infoRequest= [NSURLRequest requestWithURL:urlInfo];
    
    NSURLConnection *infoCon = [NSURLConnection connectionWithRequest:infoRequest delegate:self];
    
    Connect *connectInfo = [[Connect alloc] initConnect:infoCon responce:eResponceTypeJson];
    [self addConnectionToDict:connectInfo];
    [connectInfo startConnect];
    [connectInfo release];
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - NSURLConnectionDataDelegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.testData = [NSMutableData data];
    [[self connectByConnection:connection] resetConnectData];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.testData appendData:data]; 
    
    [[self connectByConnection:connection ] appendConnectData: data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    Connect* connect = [self connectByConnection:connection];
    switch (connect.responceType) {
        case eResponceTypeImage:
        {
            
            UIImage *testImage = [UIImage imageWithData: connect.data];
            [self.loadImageActivity stopAnimating];
            self.userImage.image = testImage;
           
        }
            break;
        case eResponceTypeJson:
        {
            SBJsonParser* parser = [[SBJsonParser alloc] init];
            NSDictionary* parseObj = [parser objectWithData:connect.data];
                [parser release];
                NSLog(@"%@",parseObj);
         
            NSMutableString* information = [[NSMutableString alloc]init];
            if ([parseObj valueForKey:@"name"]) {
                [information appendFormat:@"Name: %@\n",[parseObj valueForKey:@"name"] ] ;
            }
            if ([parseObj valueForKey:@"birthday"]) {
                [information appendFormat:@"Birthday: %@\n",[parseObj valueForKey:@"birthday"] ] ;
            }
            if ([parseObj valueForKey:@"gender"]) {
                [information appendFormat:@"Gender: %@\n",[parseObj valueForKey:@"gender"] ] ;
            }
            self.personalInfo.text = information;
        }
        default:
            break;
    }
    [self deleteConnectionFromDict:connection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@" error %@",error);
    Connect* C = [self connectByConnection:connection];
    if(C.responceType == eResponceTypeImage){
        [self.loadImageActivity stopAnimating];
    }
    [self deleteConnectionFromDict:connection];
}

#pragma mark - connection dict

-(void)addConnectionToDict: (Connect *)con{
    [self.conDict setValue:con forKey:[con.connection description]];
}

- (void)removeConnect:(Connect*)connect
{
    NSString* key =  [connect.connection description];
    [connect retain];
    [self.conDict removeObjectForKey:key];
    [connect autorelease];
}

-(void)deleteConnectionFromDict: (NSURLConnection*)con{
     NSString* key =  [con description];
     [self.conDict removeObjectForKey:key];
}

-(Connect*)connectByConnection: (NSURLConnection*) con{
    return [self.conDict valueForKey:con.description];
}
@end