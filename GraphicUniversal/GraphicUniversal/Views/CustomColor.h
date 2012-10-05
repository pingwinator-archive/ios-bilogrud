//
//  CustomColor.h
//  EndlessGrid
//
//  Created by Natasha on 02.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ColorPickerViewDelegate;
@interface CustomColor : UIView<UIPickerViewDelegate>
@property (assign, nonatomic) id <ColorPickerViewDelegate> delegate;
- (id)initWithIndexColor:(NSInteger)startColor;
@end

@protocol ColorPickerViewDelegate <NSObject>

- (void)closePickerViewWithColor:(UIColor*)color atIndex:(NSInteger)indexColor;

@end