//
//  PDFPageViewController.m
//  Reader
//
//  Created by Natasha on 15.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "PDFPageViewController.h"
#import "ContentViewController.h"
#import "PDFView.h"

@interface PDFPageViewController ()
@property (strong, nonatomic) PDFView* pdfView;
@property (assign, nonatomic) NSInteger currentPageNumber;
@property (strong, nonatomic) NSURL* urlToFile;
//@property (nonatomic, strong) NSMutableArray* modelArray;
@end

@implementation PDFPageViewController
//@synthesize webView;
@synthesize pageViewController;
@synthesize pdfView;
@synthesize currentPageNumber;
@synthesize urlToFile;


- (id)initWithUrlDocument:(NSURL*)url andLastOpenedPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.urlToFile = url;
        self.currentPageNumber = page;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
//    CGRect frame = self.view.bounds;//CGRectMake(0, 0, 768, 800);
//    self.pdfView = [[PDFView alloc] initWithFrame:frame];
//    self.pdfView.document = self.currentDoc;

//    [self.view addSubview:self.pdfView];
    
    //Step 1
    //Instantiate the UIPageViewController.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //Step 2:
    //Assign the delegate and datasource as self.
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    //Step 3:
    //Set the initial view controllers.
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithUrl:self.urlToFile andCurrentNumber:self.currentPageNumber];

    NSArray *viewControllers = [NSArray arrayWithObject:contentViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    //Step 4:
    //ViewController containment steps
    //Add the pageViewController as the childViewController
    [self addChildViewController:self.pageViewController];
    
    //Add the view of the pageViewController to the current view
    [self.view addSubview:self.pageViewController.view];
    
    //Call didMoveToParentViewController: of the childViewController, the UIPageViewController instance in our case.
    [self.pageViewController didMoveToParentViewController:self];
    
    //Step 5:
    // set the pageViewController's frame as an inset rect.
    CGRect pageViewRect = self.view.bounds;
    //pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    self.pageViewController.view.frame = pageViewRect;
    
    //Step 6:
    //Assign the gestureRecognizers property of our pageViewController to our view's gestureRecognizers property.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
      ContentViewController *contentViewController = [[ContentViewController alloc] initWithUrl:self.urlToFile andCurrentNumber:self.currentPageNumber];
    self.currentPageNumber = [contentViewController.pdfContentView increasePageNumber];
    return contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithUrl:self.urlToFile andCurrentNumber:self.currentPageNumber];
    
    self.currentPageNumber = [contentViewController.pdfContentView decreasePageNumber];
    return contentViewController;
}

#pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        //Set the array with only 1 view controller
        UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        //Important- Set the doubleSided property to NO.
        self.pageViewController.doubleSided = NO;
        //Return the spine location
        return UIPageViewControllerSpineLocationMin;
    } /*
    else
    {
        NSArray *viewControllers = nil;
        ContentViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        
        NSUInteger currentIndex = [self.modelArray indexOfObject:[(ContentViewController *)currentViewController labelContents]];
        if(currentIndex == 0 || currentIndex %2 == 0)
        {
            UIViewController *nextViewController = [self pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
        }
        else
        {
            UIViewController *previousViewController = [self pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
        }
        //Now, set the viewControllers property of UIPageViewController
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        return UIPageViewControllerSpineLocationMid;
    } */
}

@end
