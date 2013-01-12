//
//  ViewController.h
//  fb2Recognizer
//
//  Created by Natasha on 11.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class fb2Parser;
@interface ViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UITextView* textView;
@property (strong, nonatomic) fb2Parser* testBook;
@end
