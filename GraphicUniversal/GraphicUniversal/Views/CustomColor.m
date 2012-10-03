//
//  CustomColor.m
//  EndlessGrid
//
//  Created by Natasha on 02.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomColor.h"

@interface CustomColor ()
@property (retain, nonatomic) UIPickerView* colorPickerView;
@property(retain, nonatomic) UIButton* cancelButton;
@property(retain, nonatomic) UIButton* saveButton;
@property(retain ,nonatomic) NSMutableArray* colors;
@property(assign, nonatomic) NSInteger currentColorIndex;
- (void)close;
- (void)cancel;
@end

@implementation CustomColor
@synthesize cancelButton;
@synthesize saveButton;
@synthesize colorPickerView;
@synthesize colors;
@synthesize currentColorIndex;
- (void)dealloc
{
    self.cancelButton = nil;
    self.cancelButton = nil;
    self.colorPickerView = nil;
    self.colors = nil;
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
    self.colors = [[NSMutableArray alloc] initWithObjects:
                   [UIColor redColor],
                   [UIColor orangeColor],
                   [UIColor purpleColor],
                   [UIColor magentaColor],
                   [UIColor greenColor],
                   [UIColor brownColor],
                   [UIColor grayColor],
                   [UIColor blueColor],
                   [UIColor blackColor],
                   nil];
    CGRect cPickerRect = CGRectMake(30, 20, 180, 50);
    self.colorPickerView = [[UIPickerView alloc] initWithFrame:cPickerRect];
    self.colorPickerView.delegate = self;
    self.colorPickerView.showsSelectionIndicator = YES;
    self.colorPickerView.frame = cPickerRect;
    [self addSubview:self.colorPickerView];
    
    CGRect rectButton = CGRectMake(30, 190, 80, 30);
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancelButton.frame = rectButton;
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
    
    rectButton.origin.x += 100;
    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.saveButton.frame = rectButton;
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.saveButton];
}

#pragma mark - UIPickerViewDelegate Methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    self.currentColorIndex = row;
  //  NSLog(@"row: %d", row);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.colors count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if(!view) {
        CGFloat widthColorCell = [self pickerView:pickerView widthForComponent:row];
        CGFloat heightColorCell = [self pickerView:pickerView rowHeightForComponent:row];
        view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, widthColorCell, heightColorCell)] autorelease];
    }
    view.backgroundColor = [self.colors objectAtIndex:row];
    return view;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat sectionWidth = 150;
    
    return sectionWidth;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44.0f;
}

- (void)cancel
{
    if([self.delegate respondsToSelector:@selector(closePickerViewWithColor:)]) {
        if(self.currentColorIndex < [self.colors count]) {
            [self.delegate closePickerViewWithColor: nil];
        }
    }
}
- (void)close
{
    if([self.delegate respondsToSelector:@selector(closePickerViewWithColor:)]) {
        if(self.currentColorIndex < [self.colors count]) {
            [self.delegate closePickerViewWithColor: [self.colors objectAtIndex:self.currentColorIndex]];
        }
    }
}
@end
