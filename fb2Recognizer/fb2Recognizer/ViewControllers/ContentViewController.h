//
//  ContentViewController.h
//  fb2Recognizer
//
//  Created by Natasha on 13.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class fb2Parser;

@interface ContentViewController : UIViewController

@property (strong, nonatomic) UIWebView* webView;
@property (strong, nonatomic) fb2Parser* testBookNodes;
@property (assign, nonatomic) NSInteger currentPage;
- (id)initWithNodes:(fb2Parser*)nodes andCurrentNumber:(NSInteger)curNumber;

@end
