//
//  FB2ViewController.m
//  Reader
//
//  Created by Natasha on 07.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "FB2ViewController.h"
#import "DocumentModel.h"

@interface FB2ViewController ()
@property (assign, nonatomic) NSInteger currentPageNumber;
@property (strong, nonatomic) NSURL* urlToFile;
@end

@implementation FB2ViewController


- (id)initWithDocument:(DocumentModel*)model
{
    self = [super init];
    if (self) {
        self.urlToFile = model.documentUrl;
        self.currentPageNumber = model.documentLastPage;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
