//
//  CustomSegment.m
//  EndlessGrid
//
//  Created by Natasha on 01.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomSegment.h"
#import "ShapeDelegate.h"
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
        [self addComponents];
    }
    return self;
}

- (id)init
{
    self = [self initWithFrame:startFrameForSubview];
    if (self) {

    }
    return self;
}

- (void)addComponents
{
    CGRect rect = CGRectMake(30, 20, 80, 30);
    self.xText = [[[UILabel alloc] initWithFrame:rect] autorelease];
    self.xText.text = @"x1";
    self.xText.contentMode = UIViewContentModeRight;
    [self addSubview:self.xText];
    
    rect.origin.y += 40;
    self.yText = [[[UILabel alloc] initWithFrame:rect] autorelease];
    self.yText.text = @"y1";
    self.yText.contentMode = UIViewContentModeRight;
    [self addSubview:self.yText];
    
    rect.origin.y += 40;
    self.xText = [[[UILabel alloc] initWithFrame:rect] autorelease];
    self.xText.text = @"x2";
    self.xText.contentMode = UIViewContentModeRight;
    [self addSubview:self.xText];
    
    rect.origin.y += 40;
    self.yText = [[[UILabel alloc] initWithFrame:rect] autorelease];
    self.yText.text = @"y2";
    self.yText.contentMode = UIViewContentModeRight;
    [self addSubview:self.yText];
    
    CGRect rectTextField = CGRectMake(125, 20, 80, 30);
    self.xFirstPoint = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
    self.xFirstPoint.borderStyle = UITextBorderStyleRoundedRect;
    self.xFirstPoint.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.xFirstPoint.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.xFirstPoint.text = @"-1";
    self.xFirstPoint.delegate = self;
    [self addSubview:self.xFirstPoint];
    
    rectTextField.origin.y += 40;
    self.yFirstPoint = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
    self.yFirstPoint.borderStyle = UITextBorderStyleRoundedRect;
    self.yFirstPoint.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.yFirstPoint.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.yFirstPoint.text = @"2";
    self.yFirstPoint.delegate = self;
    [self addSubview:self.yFirstPoint];
    
    rectTextField.origin.y += 40;
    self.xSecondPoint = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
    self.xSecondPoint.borderStyle = UITextBorderStyleRoundedRect;
    self.xSecondPoint.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.xSecondPoint.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.xSecondPoint.text = @"-5";
    self.xSecondPoint.delegate = self;
    [self addSubview:self.xSecondPoint];
    
    rectTextField.origin.y += 40;
    self.ySecondPoint = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
    self.ySecondPoint.borderStyle = UITextBorderStyleRoundedRect;
    self.ySecondPoint.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ySecondPoint.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.ySecondPoint.text = @"7";
    self.ySecondPoint.delegate = self;
    [self addSubview:self.ySecondPoint];
    
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
- (void)close
{
    if ([self.delegate respondsToSelector:@selector(closeCustomShapeView:)]) {
        [self.delegate closeCustomShapeView: self];
    }
}

- (void)save
{
    if ([self.delegate respondsToSelector:@selector(createSegment:secondPoint:)]) {
        CGPoint first = CGPointMake([self.xFirstPoint.text floatValue], [self.yFirstPoint.text floatValue]);
        CGPoint second = CGPointMake([self.xSecondPoint.text floatValue], [self.ySecondPoint.text floatValue]);
        [self.delegate createSegment: first secondPoint: second];
    }
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    return [textField resignFirstResponder];
}

@end
