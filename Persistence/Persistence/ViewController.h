//
//  ViewController.h
//  Persistence
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(nonatomic, unsafe_unretained) IBOutlet UITextField *field1;
@property(nonatomic, unsafe_unretained) IBOutlet UITextField *field2;
@property(nonatomic, unsafe_unretained) IBOutlet UITextField *field3;
@property(nonatomic, unsafe_unretained) IBOutlet UITextField *field4;
-(NSString *)dataFilePath;
-(void)applicationWillResignActive:(NSNotification *)notification;
@end
