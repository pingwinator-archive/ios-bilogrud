//
//  FileViewController.h
//  fb2Recognizer
//
//  Created by Natasha on 24.04.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "DocumentModel.h"

@interface FileViewController : UIViewController<UIWebViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) ContentViewController* contentViewController;
@property (strong, nonatomic) UIPageViewController* pageViewController;
@property (weak, nonatomic) DocumentModel* docModel;

- (id)initWithDocument:(DocumentModel*)model;

@end
