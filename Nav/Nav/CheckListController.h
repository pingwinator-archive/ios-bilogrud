//
//  CheckListController.h
//  Nav
//
//  Created by Natasha on 25.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SecondLevelViewController.h"

@interface CheckListController : SecondLevelViewController
@property (retain, nonatomic) NSArray *list;
@property (retain, nonatomic) NSIndexPath *lastIndexPath;
@end
