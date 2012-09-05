//
//  FilesystemExplorerAppDelegate.m
//  FilesystemExplorer
//
//  Created by Chris Adamson on 11/4/08.
//  Copyright Subsequently and Furthermore, Inc. 2008. All rights reserved.
//
//
//  Licensed with the Apache 2.0 License
//  http://apache.org/licenses/LICENSE-2.0
//


#import "FilesystemExplorerAppDelegate.h"


@implementation FilesystemExplorerAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
	
//START:code.FilesystemExplorer.setfirstdirectory
	// populate the first view
	directoryViewController.directoryPath = NSHomeDirectory();
//END:code.FilesystemExplorer.setfirstdirectory

}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
