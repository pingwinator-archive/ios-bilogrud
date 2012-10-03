//
//  CustomLine.h
//  EndlessGrid
//
//  Created by Natasha on 02.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomShapeDelegate;
@interface CustomLine : UIView<UITextFieldDelegate>
@property (nonatomic, assign) id <CustomShapeDelegate> delegate;
@end
