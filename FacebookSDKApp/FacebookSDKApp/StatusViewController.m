//
//  StatusViewController.m
//  FacebookSDKApp
//
//  Created by Natasha on 10.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "StatusViewController.h"

@interface StatusViewController ()

@end

@implementation StatusViewController
@synthesize statusInput;

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
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"send"
                                                                   style:UIBarButtonItemStyleBordered target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem = sendButton;
}
-(void)sendStatus{
    NSLog(@"ура!");
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *testToken = [def valueForKey:@"token"];
   // NSLog(@"access token %@", testToken);
    
    NSString *message = statusInput.text;
    
     NSMutableDictionary *dictparametrs = [NSMutableDictionary dictionary];
     [dictparametrs setValue:testToken forKey:@"access_token"];
     [dictparametrs setValue:message forKey:@"message"];
     
     NSString *urlStr = [[NSString alloc]initWithFormat: @"https://graph.facebook.com/me/feed"];
     NSURL* url = [NSURL URLWithString:urlStr];
     NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
     
     [request setHTTPMethod:@"POST"];
     
     NSString *postParam = [dictparametrs paramFromDict];
     
     NSData *postData = [postParam dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
     [request setHTTPBody:postData];
     
     void(^postBlock)(Connect *, NSError *) = ^(Connect *con, NSError *err){
         if(!err){
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message was send" message:message delegate:nil cancelButtonTitle:@"great!" otherButtonTitles: nil];
             [alert show];
         }
     };
     
     Connect *post = [Connect urlRequest:request withBlock:postBlock];
   //  [ self addConnectToDict:post];
     
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
