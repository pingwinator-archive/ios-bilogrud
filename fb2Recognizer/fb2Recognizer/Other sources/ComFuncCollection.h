//
//  ComFuncCollection.h
//  MultiExpoNew
//
//  Created by Natasha on 04.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>


CGRect CGRectScale(CGRect rect, CGFloat scale);
CGFloat distanceBetweenPoints (CGPoint first, CGPoint second);
BOOL sizeMoreThan(CGSize size, CGFloat side);
CGFloat getMinSide(CGSize sizeFirst, CGSize sizeSecond);
CGSize proportionalMinimizeSize(CGSize size, CGFloat side);
UIImage* imageForCurrentDeviceNamed(NSString* nameResourse);
BOOL isRuLang();
BOOL isDeLang();