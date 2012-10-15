//
//  BGView.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BGView.h"
#import "BGViewBorder.h"
@interface BGView()

- (void)customInit;

@end
@implementation BGView
@synthesize viewBorder;

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit
{
    if(isiPhone) {
        self.backgroundColor = [UIColor colorWithRed:39.0f/255.0f green:64.0f/255.0f blue:139.0f/255.0f alpha:1];
        self.viewBorder = [[[BGViewBorder alloc] initWithFrame:self.frame] autorelease ];
        [self addSubview:self.viewBorder];
    } else {
        UIImageView* bgImage = [[[UIImageView alloc] initWithFrame:self.frame] autorelease];
        bgImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;;

        [bgImage setImage:[UIImage imageNamed:@"forest.jpeg"]];
            [self addSubview:bgImage];
        
//        NSInteger offsetX = 150;
//        NSInteger offsetY = 70;
//        CGRect rectForGround = CGRectMake(offsetX, offsetY, self.frame.size.width - offsetX * 2 , self.frame.size.height - offsetY * 2);
//        UIView* groundView = [[[UIView alloc] initWithFrame:rectForGround] autorelease];
//        groundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        groundView.backgroundColor = [UIColor colorWithRed:39.0f/255.0f green:64.0f/255.0f blue:139.0f/255.0f alpha:0.9];
//        [bgImage addSubview:groundView];
//        
//        NSInteger offsetBoard = 30;
//        self.viewBorder = [[[BGViewBorder alloc] initWithFrame:CGRectMake(offsetBoard, offsetBoard, rectForGround.size.width - offsetBoard * 2, 410)] autorelease];
//        self.viewBorder.backgroundColor = [UIColor clearColor];
//        [groundView addSubview:self.viewBorder];
    }
}

- (void)changeSize:(CGRect)frame
{
    UIImageView* bgImage = [[[UIImageView alloc] initWithFrame:frame] autorelease];
    [bgImage setImage:[UIImage imageNamed:@"forest.jpeg"]];
    [self addSubview:bgImage];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    NSInteger iPhoneAddOffset;
//     CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, borderThin);
//    if(isiPhone && rect.size.height > 480) {
//        iPhoneAddOffset = 67;
//    } else {
//        iPhoneAddOffset = 0;
//    }
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
//
//    CGContextAddRect(context, CGRectMake(rect.origin.x + offSetBorderThin, rect.origin.y + offSetBorderThin, rect.size.width - (rect.origin.x + offSetBorderThin ) * 2, rect.size.height - ( rect.origin.y + offSetBorderThin) * 2 - iPhoneAddOffset));
//    CGContextStrokePath(context);
//    CGContextSetLineWidth(context, borderThick);
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//
//    CGContextAddRect(context, CGRectMake(rect.origin.x + offsetBorderThick, rect.origin.y + offsetBorderThick, rect.size.width - (rect.origin.x + offsetBorderThick ) * 2, rect.size.height - ( rect.origin.y + offsetBorderThick) * 2 - iPhoneAddOffset));
//    
//    CGContextStrokePath(context);
}
@end
