//
//  AlertView.h
//  AlertTest
//
//  Created by Natasha on 15.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id )delegate cancelButtonTitle:(NSString *)cancelButtonTitle doneButtonTitles:(NSString *)doneButtonTitle;
@end

@protocol AlertViewDelegate <NSObject>

- (void)alertView:(AlertView *)alertView clickedButton:(NSInteger)buttonIndex;

@end