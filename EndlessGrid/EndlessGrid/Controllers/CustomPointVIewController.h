//
//  CustomPointVIewController.h
//  EndlessGrid
//
//  Created by Natasha on 30.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomShapeDelegate;

@interface CustomPointVIewController : UIViewController
@property (nonatomic, assign) id <CustomShapeDelegate> delegate;
- (void)close;
- (void)save;
@end
