//
//  ItemMenuView.m
//  SimpleShader
//
//  Created by Natasha on 20.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ItemMenuView.h"
#import "UIImage+RoundedCorner.h"

@interface ItemMenuView ()
@property (strong, nonatomic) UIImageView* itemImageView;

@end

@implementation ItemMenuView
@synthesize itemImageView;

- (id)initWithFrame:(CGRect)frame andImage:(UIImage*)itemImage withName:(NSString*)nameImage
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat offsetX = frame.size.width * 0.1f;
        CGFloat offsetY = frame.size.height * 0.1f;
         CGRect frameImage = CGRectMake(offsetX, offsetY, frame.size.width - offsetX * 2, frame.size.height - offsetY * 2);
        self.itemImageView = [[UIImageView alloc] initWithFrame:frameImage];
        self.itemImageView.image =  [itemImage roundedCornerImage:kRoundedCornerImageSize borderSize:kBorderSize];
        [self addSubview:self.itemImageView];
        
        UILabel* nameFilterLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameImage.origin.x, frameImage.origin.y + (frameImage.size.height), frameImage.size.width, 30)];
        nameFilterLabel.text = nameImage;//@"Sepia";
        nameFilterLabel.lineBreakMode = NSLineBreakByWordWrapping;//CharWrapping;
        nameFilterLabel.numberOfLines = 2;
        nameFilterLabel.backgroundColor = [UIColor yellowColor];
        nameFilterLabel.textAlignment = NSTextAlignmentCenter;
        nameFilterLabel.font = filterNameFont;
        [self addSubview:nameFilterLabel];
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
