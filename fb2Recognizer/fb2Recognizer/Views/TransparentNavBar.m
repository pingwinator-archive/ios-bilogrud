//
//  TransparentNavBar.m
//  MultiExpoNew
//
//  Created by Natasha on 02.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "TransparentNavBar.h"
#define navBarWidth 320
#define navbarHeight 55
@implementation TransparentNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//       self.translucent = YES;
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = CGSizeMake(navBarWidth, navbarHeight);
    return newSize;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
@end
