//
//  CustomSegment.h
//  EndlessGrid
//
//  Created by Natasha on 01.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomShapeDelegate;

@protocol CustomShapeDelegate;

@interface CustomSegment : UIView<UITextFieldDelegate>

@property (nonatomic, assign) id <CustomShapeDelegate> delegate;
@end
