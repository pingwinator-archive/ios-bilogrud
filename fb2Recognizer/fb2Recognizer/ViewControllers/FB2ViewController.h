//
//  ViewController.h
//  fb2Recognizer
//
//  Created by Natasha on 11.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Fb2Parser;
@class DocumentModel;

@interface FB2ViewController : UIViewController<UIWebViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

- (id)initWithDocument:(DocumentModel*)model;

@property (strong, nonatomic) Fb2Parser* testBook;
@property (strong, nonatomic) UIPageViewController* pageViewController;

@end
