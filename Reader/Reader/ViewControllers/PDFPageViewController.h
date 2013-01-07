//
//  PDFPageViewController.h
//  Reader
//
//  Created by Natasha on 15.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DocumentModel;
@interface PDFPageViewController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (strong, nonatomic) UIPageViewController* pageViewController;

- (id)initWithUrlDocument:(NSURL*)url andLastOpenedPage:(NSInteger)page;
- (id)initWithDocument:(DocumentModel*)model;
@end
