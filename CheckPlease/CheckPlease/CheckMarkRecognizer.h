//
//  CheckMarkRecognizer.h
//  CheckPlease
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckMarkRecognizer : UIGestureRecognizer
@property (assign, nonatomic) CGPoint lastPreviousPoint;
@property (assign, nonatomic) CGPoint lastCurrentPoint;
@property (assign, nonatomic) CGFloat lineLengthSoFar;
@end
