//
//  StartViewController.h
//  Reader
//
//  Created by Natasha on 12.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DirectoryWatcher.h"

@interface StartViewController : UITableViewController<DirectoryWatcherDelegate, UIDocumentInteractionControllerDelegate>
@property (nonatomic, strong) DirectoryWatcher *docWatcher;
@property (nonatomic, strong) NSMutableArray *documentURLs;
@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;
@end
