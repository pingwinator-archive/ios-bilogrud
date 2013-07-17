//
//  ViewController.m
//  GrooveSharkTest
//
//  Created by Natasha on 17.07.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"

#define key @"postindustria" 
#define secret @"add0e90de3658b8f132724607d841ae5"

@interface ViewController ()

@property (nonatomic, strong) NSMutableData *jsonData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) doSearch:(id)sender
{
//1 startSession
//2 authenticateUser
//3 addUserFavoriteSong
    NSLog(@"doSearch press");
    NSString* serverAddress = [NSString stringWithFormat:@"http://api.grooveshark.com/ws3.php?sig=%@", secret];

//    {'method': 'addUserFavoriteSong', 'parameters': {'songID': 0}, 'header': {'wsKey': 'key', 'sessionID': 'sessionID'}}
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"POST"];
//    NSDictionary* headerDict = @{@"wsKey": @"key", @"sessionID"};
    NSArray *keys = [NSArray arrayWithObjects:@"method", nil];
    NSArray *objects = [NSArray arrayWithObjects:@"startSession", nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSString* jsonString = [jsonDictionary JSONRepresentation];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    [request setHTTPBody:jsonData];

    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (theConnection) {
        self.jsonData = [NSMutableData data];
    } else {
        NSLog(@"Connection failed");
    }
    
//    NSMutableString* stringData= [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSDictionary    *jsonDictionaryResponse = [stringData JSONValue];
//    
//    NSString *json_message=[jsonDictionaryResponse objectForKey:@"message"];

    NSLog(@"doSearch press");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.jsonData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *result = [[NSString alloc] initWithData:self.jsonData encoding:NSUTF8StringEncoding];
	NSLog( @"%@",result );
    
	SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
	
	NSArray *dataObject = [jsonParser objectWithString:result];
	
    NSLog(@"check");
}
@end
