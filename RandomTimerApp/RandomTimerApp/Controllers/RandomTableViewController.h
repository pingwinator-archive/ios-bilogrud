//
//  RandomTableViewController.h
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomTableViewController : UITableViewController< NSFetchedResultsControllerDelegate, NSURLConnectionDataDelegate>

@property (retain, nonatomic) UITableView* tableRandomData;
@property (retain, nonatomic) NSFetchedResultsController* fetchResult;
//@property (retain, nonatomic) NSMutableArray* listGeneratedData;
@property (assign, nonatomic) BOOL useLocal;
@end
