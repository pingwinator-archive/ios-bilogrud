//
//  FilesystemExplorerAppDelegate.h
//  FilesystemExplorer
//
//  Created by Chris Adamson on 11/4/08.
//  Copyright Subsequently and Furthermore, Inc. 2008. All rights reserved.
//
//
//  Licensed with the Apache 2.0 License
//  http://apache.org/licenses/LICENSE-2.0
//


#import <UIKit/UIKit.h>
#import "DirectoryViewController.h"

@interface FilesystemExplorerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	IBOutlet DirectoryViewController *directoryViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

