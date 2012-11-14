//
//  PhotoView.m
//  PhotoMultipleExposure
//
//  Created by Natasha on 14.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView
@synthesize firstLayerImageView;
@synthesize secondLayerImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.firstLayerImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        self.secondLayerImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
