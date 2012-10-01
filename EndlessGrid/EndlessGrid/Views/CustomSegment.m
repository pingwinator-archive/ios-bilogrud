//
//  CustomSegment.m
//  EndlessGrid
//
//  Created by Natasha on 01.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomSegment.h"
@interface CustomSegment()
@property (nonatomic, retain) UILabel* xText;
@property (nonatomic, retain) UILabel* yText;
@property (nonatomic, retain) UITextField* xFirstPoint;
@property (nonatomic, retain) UITextField* yFirstPoint;
@property (nonatomic, retain) UITextField* xSecondPoint;
@property (nonatomic, retain) UITextField* ySecondPoint;
@property(retain, nonatomic) UIButton* cancelButton;
@property(retain, nonatomic) UIButton* saveButton;
@end

@implementation CustomSegment
@synthesize xText;
@synthesize yText;
@synthesize xFirstPoint;
@synthesize yFirstPoint;
@synthesize xSecondPoint;
@synthesize ySecondPoint;
@synthesize cancelButton;
@synthesize saveButton;
- (void)dealloc
{
    self.xText = nil;
    self.yText = nil;
    self.xFirstPoint = nil;
    self.yFirstPoint = nil;
    self.xSecondPoint = nil;
    self.ySecondPoint = nil;
    self.cancelButton = nil;
    self.saveButton = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [self initWithFrame:startFrameForSubview];
    if (self) {
        CGRect rect = CGRectMake(30, 20, 80, 30);
        self.xText = [[[UILabel alloc] initWithFrame:rect] autorelease];
        self.xText.text = @"x";
        self.xText.contentMode = UIViewContentModeRight;
        [self addSubview:self.xText];
        
        rect.origin.y += 40;
        self.yText = [[[UILabel alloc] initWithFrame:rect] autorelease];
        self.yText.text = @"y";
        self.yText.contentMode = UIViewContentModeBottomRight;
        [self addSubview:self.yText];
        
        CGRect rectTextField = CGRectMake(125, 20, 80, 30);
        self.yFirstPoint = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
        self.yFirstPoint.borderStyle = UITextBorderStyleRoundedRect;
        self.yFirstPoint.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.yFirstPoint.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.yFirstPoint.text = @"-1";
        //self.yCoordinate.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.yFirstPoint];
        
//        rectTextField.origin.y += 40;
//        self.xCoordinate = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
//        self.xCoordinate.borderStyle = UITextBorderStyleRoundedRect;
//        self.xCoordinate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        self.xCoordinate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        self.xCoordinate.text = @"4";
//        //self.xCoordinate.keyboardType = UIKeyboardTypeNumberPad;
//        [self addSubview:self.xCoordinate];
//        
        CGRect rectButton = CGRectMake(30, 180, 80, 30);
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
