//
//  CustomLine.m
//  EndlessGrid
//
//  Created by Natasha on 02.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomLine.h"
#import "ShapeDelegate.h"
@interface CustomLine()
@property (nonatomic, retain) UILabel* xText;
@property (nonatomic, retain) UILabel* yText;
@property (nonatomic, retain) UILabel* equalText;
@property (nonatomic, retain) UITextField* aKoeff;
@property (nonatomic, retain) UITextField* bKoeff;
@property (nonatomic, retain) UITextField* cKoeff;
@property(retain, nonatomic) UIButton* cancelButton;
@property(retain, nonatomic) UIButton* saveButton;
@end
@implementation CustomLine
@synthesize xText;
@synthesize yText;
@synthesize equalText;
@synthesize aKoeff;
@synthesize bKoeff;
@synthesize cKoeff;
@synthesize cancelButton;
@synthesize saveButton;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addComponents];
    }
    return self;
}

- (void)dealloc
{
    self.xText = nil;
    self.yText = nil;
    self.equalText = nil;
    self.aKoeff = nil;
    self.bKoeff = nil;
    self.cKoeff = nil;
    self.cancelButton = nil;
    self.saveButton = nil;
    [super dealloc];
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
    CGRect rectA = CGRectMake(60, 20, 50, 30);
  
    self.aKoeff = [[[UITextField alloc] initWithFrame:rectA] autorelease];
    self.aKoeff.borderStyle = UITextBorderStyleRoundedRect;
    self.aKoeff.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.aKoeff.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.aKoeff.text = @"-1";
    self.aKoeff.delegate = self;
    [self addSubview:self.aKoeff];

    rectA.origin.x += 60;
    self.xText = [[[UILabel alloc] initWithFrame:rectA] autorelease];
    self.xText.text = @"x + ";
    self.xText.contentMode = UIViewContentModeRight;
    [self addSubview:self.xText];

     CGRect rectB = CGRectMake(60, 60, 50, 30);
    self.bKoeff = [[[UITextField alloc] initWithFrame:rectB] autorelease];
    self.bKoeff.borderStyle = UITextBorderStyleRoundedRect;
    self.bKoeff.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.bKoeff.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.bKoeff.text = @"-1";
    self.bKoeff.delegate = self;
    [self addSubview:self.bKoeff];

    rectB.origin.x += 60;
    self.yText = [[[UILabel alloc] initWithFrame:rectB] autorelease];
    self.yText.text = @"y + ";
    self.yText.contentMode = UIViewContentModeRight;
    [self addSubview:self.yText];
    
    
    CGRect rectC = CGRectMake(60, 100, 50, 30);
    self.cKoeff = [[[UITextField alloc] initWithFrame:rectC] autorelease];
    self.cKoeff.borderStyle = UITextBorderStyleRoundedRect;
    self.cKoeff.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.cKoeff.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.cKoeff.text = @"-1";
    self.cKoeff.delegate = self;
    [self addSubview:self.cKoeff];
    
    rectC.origin.x += 60;
    self.equalText = [[[UILabel alloc] initWithFrame:rectC] autorelease];
    self.equalText.text = @" = 0";
    self.equalText.contentMode = UIViewContentModeRight;
    [self addSubview:self.equalText];

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
   
    if ([self.delegate respondsToSelector:@selector( createLineWithKoeffA:B:C:)]) {
       
        
        [self.delegate  createLineWithKoeffA:[self.aKoeff.text floatValue]
                                           B:[self.bKoeff.text floatValue]
                                           C:[self.cKoeff.text floatValue]];
    }
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    return [textField resignFirstResponder];
}


@end
