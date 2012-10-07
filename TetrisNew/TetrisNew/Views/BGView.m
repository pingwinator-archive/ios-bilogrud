//
//  BGView.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "BGView.h"

@implementation BGView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
      self.backgroundColor = [UIColor colorWithRed:39.0f/255.0f green:64.0f/255.0f blue:139.0f/255.0f alpha:1];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
   

    CGContextRef context = UIGraphicsGetCurrentContext();
  //  CGContextClearRect(context, rect);
    CGContextSetLineWidth(context, borderThin);
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    
    NSInteger iPhoneAddOffset;
    
    if(isiPhone && rect.size.height > 480) {
        iPhoneAddOffset = 88;
    } else {
        iPhoneAddOffset = 0;
    }
    CGContextAddRect(context, CGRectMake(rect.origin.x + offSetBorderThin, rect.origin.y + offSetBorderThin, rect.size.width - (rect.origin.x + offSetBorderThin ) * 2, rect.size.height - ( rect.origin.y + offSetBorderThin) * 2 - iPhoneAddOffset));
     CGContextStrokePath(context);
     CGContextSetLineWidth(context, borderThick);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextAddRect(context, CGRectMake(rect.origin.x + offsetBorderThick, rect.origin.y + offsetBorderThick, rect.size.width - (rect.origin.x + offsetBorderThick ) * 2, rect.size.height - ( rect.origin.y + offsetBorderThick) * 2 - iPhoneAddOffset));

  //  self.backgroundColor = [UIColor colorWithRed:39.0f/255.0f green:64.0f/255.0f blue:139.0f/255.0f alpha:1];
    CGContextStrokePath(context);
}


@end
