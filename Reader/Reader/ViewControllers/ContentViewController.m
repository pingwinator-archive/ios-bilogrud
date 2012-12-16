//
//  ContentViewController.m
//  Reader
//
//  Created by Natasha on 15.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ContentViewController.h"
#import "PDFScrollView.h"

@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize pdfContentView;
@synthesize currentPageNumber;
@synthesize urlToFile;

- (id)initWithUrl:(NSURL*)url andCurrentNumber:(NSInteger)currentPage
{
    self = [super init];
    if (self) {
        self.urlToFile = url;
        self.currentPageNumber = currentPage;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pdfContentView = [[PDFView alloc] initWithFrame:self.view.frame url:self.urlToFile andCurPage:self.currentPageNumber];
    [self.view addSubview:self.pdfContentView];
    
    // Create our PDFScrollView and add it to the view controller.
//	PDFScrollView *sv = [[PDFScrollView alloc] initWithFrame:self.view.bounds];
//	
//    [[self view] addSubview:sv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
