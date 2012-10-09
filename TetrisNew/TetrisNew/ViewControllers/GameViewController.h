//
//  ViewController.h
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGView;
@class BoardView;

@interface GameViewController : UIViewController
@property (assign, nonatomic) BOOL isStart;
@property (retain, nonatomic) NSTimer* gameTimer;
@end
