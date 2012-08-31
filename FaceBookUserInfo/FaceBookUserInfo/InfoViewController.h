//
//  InfoViewController.h
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property(retain, nonatomic) IBOutlet UITextView *personalInfo;
@property(retain, nonatomic) IBOutlet UIImageView *userImage;
@property(retain, nonatomic) NSMutableData* testData;
@property(retain, nonatomic) NSURLConnection *testImageConnection;
@property(retain, nonatomic) NSURLConnection *testInfoConnection;
@property(retain, nonatomic) NSString* userIdValue;
@property(retain, nonatomic) IBOutlet UIActivityIndicatorView* loadImageActivity;
@end
