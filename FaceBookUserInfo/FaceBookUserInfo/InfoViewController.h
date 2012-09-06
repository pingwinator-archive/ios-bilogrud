//
//  InfoViewController.h
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connect.h"
#import "SelfloadImage.h"
@interface InfoViewController : UIViewController

@property(retain, nonatomic) IBOutlet UITextView *personalInfo;
@property(retain, nonatomic) IBOutlet UITableView *statusesInfoTable;
@property(retain, nonatomic) IBOutlet SelfloadImage *userImage;
@property(retain, nonatomic) IBOutlet UILabel *nameLabel;
@property(retain, nonatomic) NSMutableData* testData;
@property(retain, nonatomic) NSURLConnection *testImageConnection;
@property(retain, nonatomic) NSURLConnection *testInfoConnection;
@property(retain, nonatomic) NSString *userIdValue;

@end
