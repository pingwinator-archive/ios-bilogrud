//
//  SettingView.m
//  EndlessGrid
//
//  Created by Natasha on 27.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingView.h"

@implementation SettingView
@synthesize test;
@synthesize delegate;

- (void)dealloc
{
    self.test = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initControls];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initControls];
    }
    return self;
}
- ( void)initControls
{
    self.test
    = [[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 20)] autorelease];
    self.test.titleLabel.text = @"hide";
    self.test.backgroundColor = [UIColor greenColor];
    [self.test addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.test];
}

- (void)hide
{
    if ([self.delegate respondsToSelector:@selector(hideSettingsView)]) {
        [self.delegate hideSettingsView];
    }
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
