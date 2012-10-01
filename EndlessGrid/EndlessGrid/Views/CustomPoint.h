//
//  CustomPoint.h
//  EndlessGrid
//
//  Created by Natasha on 01.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomShapeDelegate;

@interface CustomPoint : UIView
@property (nonatomic, assign) id <CustomShapeDelegate> delegate;
@end

//@protocol CustomPointViewDelegate <NSObject>
//- (void)hideCustomPointView:(NSValue*)pointValue;
//- (void)closeCustomPointView;
//@end
