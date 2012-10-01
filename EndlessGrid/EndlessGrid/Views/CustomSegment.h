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
@interface CustomSegment : UIView

@property (nonatomic, assign) id <CustomShapeDelegate> delegate;
@end
//
//@protocol CustomSegmentViewDelegate <NSObject>
////- (void)closeView;
////- (void)saveView: (Shape*)shape;
//@end
