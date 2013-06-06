//
//  TransparentNavBar.m
//  MultiExpoNew
//
//  Created by Natasha on 02.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "TransparentNavBar.h"
#define navBarWidth 320
#define navbarHeight 50
@implementation TransparentNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.translucent = YES;
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = (isiPhone) ? CGSizeMake(navBarWidth, navbarHeight) : CGSizeMake(768, 90);
    return newSize;
}

// Attention! This method needs for correct draw navigation bar
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

@end
