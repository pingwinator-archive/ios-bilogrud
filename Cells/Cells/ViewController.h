//
//  ViewController.h
//  Cells
//
//  Created by Natasha on 22.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) NSArray *computers;
@end
