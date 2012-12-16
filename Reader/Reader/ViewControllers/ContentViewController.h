//
//  ContentViewController.h
//  Reader
//
//  Created by Natasha on 15.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFView.h"

@interface ContentViewController : UIViewController

@property (strong, nonatomic) PDFView* pdfContentView;
@property (assign, nonatomic) NSInteger currentPageNumber;
@property (strong, nonatomic) NSURL* urlToFile;

- (id)initWithUrl:(NSURL*)url andCurrentNumber:(NSInteger)currentPage;

@end
