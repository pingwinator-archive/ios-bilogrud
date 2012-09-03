//
//  InfoViewController.h
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Connect.h"
@interface InfoViewController : UIViewController<ConnectDelegate,UITableViewDataSource, UITableViewDelegate>

@property(retain, nonatomic) IBOutlet UITextView *personalInfo;
@property(retain, nonatomic) IBOutlet UITextView *statusInfo;
@property(retain, nonatomic) IBOutlet UITableView *statusesInfoTable;
@property(retain, nonatomic) IBOutlet UIImageView *userImage;
@property(retain, nonatomic) IBOutlet UILabel *nameLabel;
@property(retain, nonatomic) IBOutlet UIActivityIndicatorView* loadImageActivity;
@property(retain, nonatomic) NSMutableData* testData;
@property(retain, nonatomic) NSURLConnection *testImageConnection;
@property(retain, nonatomic) NSURLConnection *testInfoConnection;
@property(retain, nonatomic) NSString *userIdValue;
@property(retain, nonatomic) NSArray *statusesArr;
@end
