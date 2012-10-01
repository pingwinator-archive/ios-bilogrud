//
//  CustomPoint.h
//  EndlessGrid
//
//  Created by Natasha on 01.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomShapeDelegate;

@interface CustomPoint : UIView<CustomShapeDelegate, UITextFieldDelegate>
@property (nonatomic, assign) id <CustomShapeDelegate> delegate;
@end

