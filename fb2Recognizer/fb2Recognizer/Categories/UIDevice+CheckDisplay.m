//
//  UIDevice+CheckDisplay.m
//  MultiExpoNew
//
//  Created by Natasha on 03.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "UIDevice+CheckDisplay.h"

@implementation UIDevice (CheckDisplay)
- (BOOL)has4inchDisplay
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) //if iPhone
    {
        if (([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale) >= 1136.0f) //if screen size 1136x640
        {
            return YES;
        }
    }
    return NO;
}
@end
