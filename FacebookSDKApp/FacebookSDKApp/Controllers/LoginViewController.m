//
//  ViewController.m
//  FacebookSDKApp
//
//  Created by Natasha on 10.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize singInButton;

- (void)dealloc
{
    self.singInButton = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.singInButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//
-(IBAction)authButtonAction
{
  //  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // The user has initiated a login, so call the openSession method
    // and show the login UX if necessary.
    [self openSessionWithAllowLoginUI:YES];
    
    
//    
}
#pragma mark - fb

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                NSLog(@"User session found");
                
                SettingManager *setting= [SettingManager sharedInstance];
                [setting saveAccessToken:session.accessToken];
               
                [self dismissModalViewControllerAnimated:YES];
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions = [[[NSArray alloc] initWithObjects:
                            @"user_likes",
                            @"read_stream",
                            @"publish_stream",
                            nil] autorelease];
    return [FBSession openActiveSessionWithPermissions:permissions  allowLoginUI:allowLoginUI completionHandler:^(FBSession *session, FBSessionState state,  NSError *error)
            {
                [self sessionStateChanged:session  state:state  error:error];
            }];
}

@end
