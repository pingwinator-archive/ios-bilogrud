//
//  CustomPointVIewController.h
//  EndlessGrid
//
//  Created by Natasha on 30.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomPointViewDelegate;
@interface CustomPointVIewController : UIViewController
@property (nonatomic, assign) id <CustomPointViewDelegate> delegate;
- (void)close;
- (void)save;
@end

@protocol CustomPointViewDelegate <NSObject>
- (void)hideCustomPointView:(NSValue*)pointValue;
- (void)closeCustomPointView;
@end
