//
//  ViewController.h
//  fb2Recognizer
//
//  Created by Natasha on 11.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class fb2Parser;
@interface ViewController : UIViewController<UIWebViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) fb2Parser* testBook;



@property (strong, nonatomic) UIPageViewController* pageViewController;
@end
