//
//  FileViewController.m
//  fb2Recognizer
//
//  Created by Natasha on 24.04.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "FileViewController.h"
#import "DocumentModel.h"

@interface FileViewController ()

@end

@implementation FileViewController

- (id)initWithDocument:(DocumentModel*)model
{
    self = [super init];
    if (self) {
        self.docModel = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UIPageViewControllerDataSource Methods
/*
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
//    self.currentNode = self.contentViewController.currentNode;
//    NSLog(@" currentNode %d", self.currentNode);
//    self.currentPosition = self.contentViewController.currentPosition;
//    NSLog(@"currentPosition %d", self.contentViewController.currentPosition);
    [self decreasePageNumber];
    //update init
    self.contentViewController = [[ContentViewController alloc] initWithNodes:self.testBook andCurrentNumber:self.currentPageNumber];
    self.contentViewController.moveAhead = NO;
    [self.contentViewController changePage: self.currentPageNumber withCurrentNode:self.currentNode andCurrentPosition:self.currentPosition];
    
    return self.contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    self.currentNode = self.contentViewController.currentNode;
    NSLog(@" currentNode %d", self.currentNode);
    
    self.currentPosition = self.contentViewController.currentPosition;
    NSLog(@"currentPosition %d", self.contentViewController.currentPosition);
    
    [self increasePageNumber];
    
    self.contentViewController = [[ContentViewController alloc] initWithNodes:self.testBook andCurrentNumber:self.currentPageNumber];
    
    self.contentViewController.moveAhead = YES;
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
*/
@end
