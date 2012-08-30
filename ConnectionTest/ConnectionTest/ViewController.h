//
//  ViewController.h
//  ConnectionTest
//
//  Created by Natasha on 30.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property(retain, nonatomic)IBOutlet UIButton *testButton;
@property(retain, nonatomic)IBOutlet UITextView *testTextView;
@property(retain, nonatomic)IBOutlet UITextField *textMessage;
@property(retain, nonatomic)NSMutableData* testData;
@property(nonatomic, retain)NSURLConnection *testConnection;
-(IBAction)test;
@end

