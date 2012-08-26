//
//  DeleteMeController.h
//  Nav
//
//  Created by Natasha on 26.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SecondLevelViewController.h"

@interface DeleteMeController : SecondLevelViewController

@property (retain, nonatomic) NSMutableArray *list;
-(IBAction)toggleEdit:(id)sender;
@end
