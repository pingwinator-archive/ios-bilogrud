//
//  SPoint.h
//  EndlessGrid
//
//  Created by Natasha on 28.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPoint : NSObject
@property(assign, nonatomic) CGPoint dekartPoint;
@property(retain, nonatomic) UIColor* color;
- (id) initWithPoint: (CGPoint)point;
@end
