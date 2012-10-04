//
//  CustomPoint.m
//  EndlessGrid
//
//  Created by Natasha on 01.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomPoint.h"
#import "ShapeDelegate.h"
#import "SPoint.h"
@interface CustomPoint ()
@property(retain, nonatomic) UITextField* xCoordinate;
@property(retain, nonatomic) UITextField* yCoordinate;
@property(retain, nonatomic) UILabel* xText;
@property(retain, nonatomic) UILabel* yText;
@property(retain, nonatomic) UIButton* cancelButton;
@property(retain, nonatomic) UIButton* saveButton;
- (void)close;
- (void)save;
@end

@implementation CustomPoint
@synthesize xCoordinate;
@synthesize yCoordinate;
@synthesize xText;
@synthesize yText;
@synthesize cancelButton;
@synthesize saveButton;
@synthesize delegate;
- (void)dealloc
{
    self.xCoordinate = nil;
    self.yCoordinate = nil;
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

- (void)addComponents
{
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
    self.xCoordinate = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
    self.xCoordinate.borderStyle = UITextBorderStyleRoundedRect;
    self.xCoordinate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.xCoordinate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.xCoordinate.text = @"1";
    self.xCoordinate.delegate = self;
    //self.xCoordinate.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.xCoordinate];
    
    rectTextField.origin.y += 40;
    self.yCoordinate = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
    self.yCoordinate.borderStyle = UITextBorderStyleRoundedRect;
    self.yCoordinate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.yCoordinate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.yCoordinate.text = @"1";
    self.yCoordinate.delegate = self;
    //self.yCoordinate.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.yCoordinate];
    
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
    if ([self fullFields] && [self numericFields]) {
       if ([self.delegate respondsToSelector:@selector(createPoint:)]) {
        CGPoint point = CGPointMake([self.xCoordinate.text floatValue], [self.yCoordinate.text floatValue]);
        [self.delegate createPoint:point];
       }
    }
}

- (BOOL)fullFields
{
    return [self.xCoordinate.text length] && [self.yCoordinate.text length];
}
                              
- (BOOL)numericFields
{
//?
    return [self.xCoordinate.text floatValue]  && [self.yCoordinate.text floatValue];
}
#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    return [textField resignFirstResponder];
}
@end
