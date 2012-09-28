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
    [self.singInButton setTitle:NSLocalizedString(@"Sing In", @"") forState:UIControlStateNormal];
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
- (IBAction)authButtonAction
{
    [self openSessionWithAllowLoginUI:YES];
}

#pragma mark - Facebook

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    if([[FBSession activeSession] accessToken])
    {
        NSLog(@"!!!User session found");

    }
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // valid session
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
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:error.localizedDescription  delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
   NSArray *permissions = [[[NSArray alloc] initWithObjects:
                            permissionStr,
                            nil] autorelease];
    
//    NSArray *permissions = [NSArray arrayWithObjects:@"user_photos", @"friends_photos", nil];
    
//    [[FBSession activeSession] reauthorizeWithReadPermissions:permissions
//                                            completionHandler:^(FBSession *session, NSError *error) {
//                                                /* handle success + failure in block */
//                                            }];
    
    return [FBSession  openActiveSessionWithPermissions:permissions  allowLoginUI:allowLoginUI completionHandler:^(FBSession *session, FBSessionState status,  NSError *error)
            {
                [self sessionStateChanged:session  state:status  error:error];
            }];
}

@end
