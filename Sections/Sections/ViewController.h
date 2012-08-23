//
//  ViewController.h
//  Sections
//
//  Created by Natasha on 23.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UISearchBar *search;
@property (retain, nonatomic) NSDictionary *allNames;
@property (retain, nonatomic) NSMutableDictionary *names;
@property (retain, nonatomic) NSMutableArray *keys;
@property (assign, nonatomic) BOOL isSearching;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;
@end
