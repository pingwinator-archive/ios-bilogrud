//
//  PhotoView.m
//  PhotoMultipleExposure
//
//  Created by Natasha on 14.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "PhotoView.h"
#import "UIImage+RoundedCorner.h"
@implementation PhotoView
@synthesize firstLayerImageView;
@synthesize secondLayerImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.firstLayerImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        [self addSubview:self.firstLayerImageView];
        self.secondLayerImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        [self addSubview:self.secondLayerImageView];
    }
    return self;
}

- (void)reset
{
    self.firstLayerImageView.image = nil;
    self.secondLayerImageView.image = nil;
}

- (void)defPhoto
{
    self.firstLayerImageView.image = [[UIImage imageNamed:@"IPhoto.png"] roundedCornerImage:kRoundedCornerImageSize borderSize:kBorderSize];
    self.secondLayerImageView.image = [[UIImage imageNamed:@"IPhoto.png"] roundedCornerImage:kRoundedCornerImageSize borderSize:kBorderSize];
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
