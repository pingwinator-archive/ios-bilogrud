//
//  CustomColor.m
//  EndlessGrid
//
//  Created by Natasha on 02.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomColor.h"

@interface CustomColor ()

@property(retain, nonatomic) UIButton* cancelButton;
@property(retain, nonatomic) UIButton* saveButton;
- (void)close;
- (void)save;
@end

@implementation CustomColor
@synthesize cancelButton;
@synthesize saveButton;
- (void)dealloc
{
    self.cancelButton = nil;
    self.cancelButton = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addComponents];
    }
    return self;
}
- (id)init
{
    self = [self initWithFrame:startFrameForSubview];
    if(self) {
        
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
- (void) addComponents
{
    
    CGRect rectButton = CGRectMake(30, 190, 80, 30);
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancelButton.frame = rectButton;
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
    
    rectButton.origin.x += 100;
    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.saveButton.frame = rectButton;
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.saveButton];
}
@end
