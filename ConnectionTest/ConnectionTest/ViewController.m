//
//  ViewController.m
//  ConnectionTest
//
//  Created by Natasha on 30.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "SBJSON/SBJson.h"
#include "NSDictionary+HTTPParametrs.h"
#define kToken @"AAACEdEose0cBAAqRtwrWkei8ziOXgayvYFSJG1FnIiuBZBZCqT2WAba7GZA69QWvNZAUJ2qXZCuIG6YhYhY2ZArNTFUZAKEprS1Xa553foyL1wgp46pb4Tf"
@interface ViewController ()

@end

@implementation ViewController
@synthesize testButton;
@synthesize testTextView;
@synthesize testData;
@synthesize testConnection;
@synthesize textMessage;

-(void)dealloc{
    self.testData = nil;
    self.testTextView = nil;
    self.testButton = nil;
    self.testConnection = nil;
    [super dealloc];
}
-(NSMutableURLRequest*)requestWithImage: (NSURL*)url{
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60]autorelease];
    NSString *boundary = @"----BoundarycC4YiaUFwM44F6rT";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
     NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
    UIImage *image = [UIImage imageNamed:@"image.png"];
    NSData* imageData = UIImagePNGRepresentation(image);
    
    [body appendData:[@"Content-Disposition: form-data; name=\"source\";filename=\"picture.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     
    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
                       
     // and again the delimiting boundary
     [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                       
     // adding the body we've created to the request
     [request setHTTPBody:body];
    return request;
}

-(IBAction)test{

    NSMutableDictionary *dictparametrs = [NSMutableDictionary dictionary];
    [dictparametrs setValue:kToken forKey:@"access_token"];
//    [dictparametrs setValue:self.textMessage.text forKey:@"message"];
//    [dictparametrs setValue:@"http://ya.ru" forKey:@"link"];
//
    [dictparametrs setValue:@"http://a5.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/430702_274084829330398_269741610_n.jpg" forKey:@"url"];
  //  [dictparametrs setValue:@"" forKey:@"source"];
    NSString *urlStr = /*https://graph.facebook.com/me/photos@"";*/[[[NSString alloc]initWithFormat: @"https://graph.facebook.com/me/photos?access_token=%@", kToken]autorelease];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest* request = [self requestWithImage:url];//[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    
  //  NSString *postParam = [dictparametrs paramFromDict];// [NSString stringWithFormat: @"message=%@&access_token=%@" , self.textMessage.text,kToken];
    
   // NSData *postData = [postParam dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   //[request setHTTPBody:postData];
    self.testConnection = [[[NSURLConnection alloc] initWithRequest:request delegate:self]autorelease];
    
    [self.testConnection start];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - NSURLConnectionDataDelegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
     self.testData = [NSMutableData data];
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.testData appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
 //   NSString *str = [[[NSString alloc] initWithData:self.testData encoding:NSUTF8StringEncoding]autorelease];
//    NSLog(@"json responce = %@ /n",str);
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    NSDictionary* parseObj = [parser objectWithData:self.testData];
    [parser release];
    NSLog(@"%@",parseObj);
//    NSArray *arrData = [parseObj valueForKey:@"data"];
//    
//    NSDictionary *lastObj = [arrData lastObject];
//    //from
//    NSDictionary *from = [lastObj valueForKey:@"from"];
//    NSString *fromName = [from valueForKey:@"name"];
//    //message
//    NSString *text = [lastObj valueForKey:@"message"];
//    
//    NSString *message = [[NSString alloc]initWithFormat:@"From: %@ \nMessage: %@", fromName, text ];

//    self.testTextView.text = message;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:[parseObj valueForKey:@"id"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil ];
    [alert show];
    [alert release];
}
@end
