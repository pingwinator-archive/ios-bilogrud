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
        //self.alpha = 0.5f;
        self.backgroundColor = [UIColor redColor];
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withText:(NSString*)text andTargetFrame:(CGRect)rect
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.alpha = 0.5f;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2 - 100, 100, 200, 100)];
        textLabel.text = text;
        [self addSubview: textLabel];
        
        
        // Initialization code
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
