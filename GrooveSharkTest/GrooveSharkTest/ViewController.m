//
//  ViewController.m
//  GrooveSharkTest
//
//  Created by Natasha on 17.07.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"
#import "NSString+HMAC.h"
#import "CustomGrooveClient.h"



@interface ViewController ()

@property (nonatomic, strong) NSMutableData *jsonData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[CustomGrooveClient sharedClient] setOnReady:^(BOOL isReady) {
        if (isReady) {
            [self.searchField setBackgroundColor:[UIColor redColor]];
        } 
    }];
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
    NSString* searchText = self.searchField.text;
    if (![searchText length]) {
        searchText = @"Scorp";
    }
    [[CustomGrooveClient sharedClient] getArtistSearchResults:searchText withCallbackBlock:^(NSDictionary* dict, NSError* err) {

        NSArray* artistCollection = dict[@"result"][@"artists"];
        for (NSUInteger i = 0; i < [artistCollection count]; i++) {
            
            NSDictionary* d = artistCollection[i][@"ArtistName"];
            NSLog(@"%@", artistCollection[i]);
        }
        
        NSLog(@"check result");
    }];
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
