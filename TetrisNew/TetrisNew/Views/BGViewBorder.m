//
//  BGViewBorder.m
//  TetrisNew
//
//  Created by Natasha on 11.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BGViewBorder.h"

@interface BGViewBorder()
@property (retain, nonatomic) UILabel* superLabel;
- (void)addSuperLabel;
@end
@implementation BGViewBorder

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:39.0f/255.0f green:64.0f/255.0f blue:139.0f/255.0f alpha:1];
        [self addSuperLabel];
    }
    return self;
}


- (void)addSuperLabel
{
    self.superLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 50)/2, 0, 50, 12)];
    self.superLabel.text = @"SUPER";
    [self.superLabel setFont:textButtonFont];
    self.superLabel.backgroundColor = [UIColor colorWithRed:39.0f/255.0f green:64.0f/255.0f blue:139.0f/255.0f alpha:1];
    self.superLabel.textColor = [UIColor whiteColor];
    self.superLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:self.superLabel];
    [self.superLabel release];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSInteger iPhoneAddOffset;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, borderThin);
    if(isiPhone && rect.size.height > 480) {
        iPhoneAddOffset = 67;
    } else {
        iPhoneAddOffset = 0;
    }
    
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    
    CGContextAddRect(context, CGRectMake(rect.origin.x + offSetBorderThin, rect.origin.y + offSetBorderThin, rect.size.width - (rect.origin.x + offSetBorderThin ) * 2, rect.size.height - ( rect.origin.y + offSetBorderThin) * 2 - iPhoneAddOffset));
    CGContextStrokePath(context);
    CGContextSetLineWidth(context, borderThick);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextAddRect(context, CGRectMake(rect.origin.x + offsetBorderThick, rect.origin.y + offsetBorderThick, rect.size.width - (rect.origin.x + offsetBorderThick ) * 2, rect.size.height - ( rect.origin.y + offsetBorderThick) * 2 - iPhoneAddOffset));
    
    CGContextStrokePath(context);

}


@end
