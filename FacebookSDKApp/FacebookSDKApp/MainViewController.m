//
//  MainViewController.m
//  FacebookSDKApp
//
//  Created by Natasha on 10.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "MainViewController.h"
#import "StatusViewController.h"
#import "LoginViewController.h"
#import "FeedViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tokenLabel;
@synthesize userImageView;

-(void)viewWillAppear:(BOOL)animated
{
    if([self isActiveToken]){
        [self loadImage];
    } else {
        LoginViewController *login = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil]autorelease];
       [self presentModalViewController:login animated:YES];
    }
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tokenLabel = nil;
    self.userImageView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)isActiveToken{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return ([def valueForKey:@"token"]) ? YES : NO;
}

#pragma mark - 

-(void) loadImage
{
    NSString *urlStr = [NSString stringWithFormat: @"https://graph.facebook.com/me/picture?access_token=BAACB0SVqSSEBAK0jiuUNVOsAWqjydt6kZAY0FexOU35zkr9Nxe5tx7KUu4ryPYd47vUEmoOIqoU6ZBfw6REW9LOPCDiBA6mIPltd6Kg4X3KddLsW0pj2oxx8NfLScZD"];
    NSURL *url = [NSURL URLWithString:urlStr ];
    
    [self.userImageView loadImage:url ];// cashImages:self.imageCache];
}
-(IBAction)createStatus
{
    StatusViewController *detail = [[StatusViewController alloc]initWithNibName:@"StatusViewController" bundle:nil];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}
-(IBAction)showFeed
{
    FeedViewController *feed = [[FeedViewController alloc]initWithNibName:@"FeedViewController" bundle:nil];
    [self.navigationController pushViewController:feed animated:YES];
}
-(IBAction)logOut
{
    
}
@end
