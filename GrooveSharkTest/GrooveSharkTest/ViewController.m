//
//  ViewController.m
//  GrooveSharkTest
//
//  Created by Natasha on 17.07.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "CustomGrooveClient.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableData *jsonData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[CustomGrooveClient sharedClient] setOnReady:^(BOOL isReady) {
        if (isReady) {
            [self.searchField setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5f]];
        } 
    }];
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
        NSString* artistInfo = @"";
        NSArray* artistCollection = dict[@"result"][@"artists"];
        for (NSUInteger i = 0; i < [artistCollection count]; i++) {
            
            NSString* d = artistCollection[i][@"ArtistName"];
            artistInfo = [NSString stringWithFormat:@"%@\n%@", artistInfo, d];
            NSLog(@"%@", artistCollection[i]);
        }
        self.resultText.text = artistInfo;
        NSLog(@"check result");
    }];
    
    [[CustomGrooveClient sharedClient] getArtistAlbumsByArtistID:@"4144" withCallbackBlock:^(NSDictionary* dict, NSError* err) {
        NSLog(@"1589599 id test");
    }];
}

@end
