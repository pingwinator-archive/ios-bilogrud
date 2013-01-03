//
//  TableViewController.h
//  TableTest
//
//  Created by Natasha on 30.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyTableView.h"

@interface TableViewController : UIViewController<EasyTableViewDelegate>
@property (nonatomic) EasyTableView* horizontalView;
@end
