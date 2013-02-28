//
//  ViewController.m
//  fb2Recognizer
//
//  Created by Natasha on 11.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "fb2Parser.h"
#import "ContentViewController.h"

@interface ViewController ()
@property (assign, nonatomic) NSInteger currentPageNumber;
@property (assign, nonatomic) NSInteger currentNode;
@property (assign, nonatomic) NSInteger currentPosition;
@property (strong, nonatomic) ContentViewController* contentViewController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.testBook = [[fb2Parser alloc] init];
    self.currentPageNumber = 0;
    self.currentNode = 0;
    
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
    self.contentViewController = [[ContentViewController alloc] initWithNodes:self.testBook andCurrentNumber:self.currentPageNumber];
    
    NSArray *viewControllers = [NSArray arrayWithObject:self.contentViewController];
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

    NSString* bookString = [NSMutableString string];
    for (NSString* s in self.testBook.elementArray) {
        bookString = [bookString stringByAppendingString:s];
    }
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    self.currentNode = self.contentViewController.currentNode;
    self.currentPosition = self.contentViewController.currentPosition;
    [self decreasePageNumber];
    //update init
    self.contentViewController = [[ContentViewController alloc] initWithNodes:self.testBook andCurrentNumber:self.currentPageNumber];
    [self.contentViewController changePage: self.currentPageNumber withCurrentNode:self.currentNode andCurrentPosition:self.currentPosition];

    return self.contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    self.currentNode = self.contentViewController.currentNode;
    self.currentPosition = self.contentViewController.currentPosition;

    [self increasePageNumber];

    self.contentViewController = [[ContentViewController alloc] initWithNodes:self.testBook andCurrentNumber:self.currentPageNumber];

    [self.contentViewController changePage: self.currentPageNumber withCurrentNode:self.currentNode andCurrentPosition:self.currentPosition];
    
    return self.contentViewController;
}

- (void)decreasePageNumber
{
    if (self.currentPageNumber > 0) {
        self.currentPageNumber--;
    }
    NSLog(@"current page %d", self.currentPageNumber);
}

- (void)increasePageNumber
{
    if (self.contentViewController.currentNode < [self.testBook.elementArray count]) {
        self.currentPageNumber++;
    }
    NSLog(@"current page %d", self.currentPageNumber);
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
    }
    return nil;
}
@end
