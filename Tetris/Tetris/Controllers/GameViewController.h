//
//  ViewController.h
//  Tetris
//
//  Created by Natasha on 29.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BoardViewController;
@interface GameViewController : UIViewController
@property (retain, nonatomic) BoardViewController* boardViewController;
@end
