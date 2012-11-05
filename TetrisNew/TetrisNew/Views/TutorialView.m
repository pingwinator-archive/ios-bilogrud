//
//  TutorialView.m
//  TetrisNew
//
//  Created by Natasha on 03.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "TutorialView.h"

@implementation TutorialView

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withText:(NSString*)text andTargetFrame:(CGRect)rect
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        CGRect labelRect;
        if(isiPhone) {
            labelRect = CGRectMake(frame.size.width/2 - 100 , 100, 200, 100);
        } else {
            labelRect = CGRectMake(frame.size.width/2 - 238 , 330, 480, 100);
        }
        UILabel* textLabel = [[UILabel alloc] initWithFrame:labelRect];
        
        textLabel.text = [text uppercaseString];
        textLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8f];
        textLabel.font = settingFont;
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.numberOfLines = 2;
        //NSLineBreakByCharWrapping;
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: textLabel];
        [textLabel release];
        
        UIImageView* arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hintArrow.png"]];
        CGSize arrowSize = CGSizeMake(35, 75);
        arrow.frame = CGRectMake(CGRectGetMidX(rect) - arrowSize.width/2, CGRectGetMinY(rect) - arrowSize.height, arrowSize.width, arrowSize.height);
        [self addSubview:arrow];
        [arrow release];
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
