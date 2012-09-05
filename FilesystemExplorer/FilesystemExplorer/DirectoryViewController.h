//
//  MasterViewController.h
//  FilesystemExplorer
//
//  Created by Natasha on 05.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface DirectoryViewController : UITableViewController
{
    NSString *directoryPath;
	NSArray *directoryContents;
}
@property (strong, nonatomic) DetailViewController *detailViewController;
@property(retain, nonatomic) NSArray *directoryContents;
@property (nonatomic, retain) NSString *directoryPath;
@end
