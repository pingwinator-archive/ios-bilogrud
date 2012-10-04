//
//  SettingsViewController.m
//  EndlessGrid
//
//  Created by Natasha on 27.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIImage+RoundedCorner.h"
#import "CustomPoint.h"
#import "CustomSegment.h"
#import "CustomLine.h"
#import "ShapeDelegate.h"
#import "SPoint.h"
#import "SSegment.h"
#import "SLine.h"
#import "CustomColor.h"
@interface SettingsViewController ()
@property (retain, nonatomic) CustomPoint* customPointView;
@property (retain, nonatomic) CustomSegment* customSegmentView;
@property (retain, nonatomic) CustomLine* customLineView;
@property (retain, nonatomic) CustomColor* colorPicker;
@end

@implementation SettingsViewController
@synthesize closeButton;
@synthesize delegate;
@synthesize addLine;
@synthesize addPoint;
@synthesize addSegment;
@synthesize senderActionType;
@synthesize addCustomLine;
@synthesize addCustomPoint;
@synthesize addCustomSegment;
@synthesize changeColor;
@synthesize clearBoard;
@synthesize bgImageView;
@synthesize customPointView;
@synthesize settingButtonsView;
@synthesize customLineView;
@synthesize colorPicker;
- (void)dealloc
{
    self.closeButton = nil;
    self.delegate = nil;
    self.addLine = nil;
    self.addPoint = nil;
    self.addSegment = nil;
    self.addCustomPoint = nil;
    self.addCustomSegment = nil;
    self.addCustomLine = nil;
    self.clearBoard = nil;
    self.changeColor = nil;
    self.bgImageView = nil;
    self.customPointView = nil;
    self.settingButtonsView = nil;
    self.customLineView = nil;
    self.colorPicker = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage* white = [[UIImage imageNamed:@"White.jpeg"] roundedCornerImage:7 borderSize:0];
    self.bgImageView.image = [white roundedCornerImage:10 borderSize:1];
}
-(void)viewDidUnload
{
    self.closeButton = nil;
    self.delegate = nil;
    self.addLine = nil;
    self.addPoint = nil;
    self.addSegment = nil;
    self.addCustomPoint = nil;
    self.addCustomSegment = nil;
    self.addCustomLine = nil;
    self.clearBoard = nil;
    self.changeColor = nil;
    self.bgImageView = nil;
    self.customPointView = nil;
    self.settingButtonsView = nil;
    self.customLineView = nil;
    self.colorPicker = nil;

    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(UIButton*)sender
{
    switch ([sender tag]) {
        case kOnlyClose:{
            self.senderActionType = kAddNone;
        }
            break;
        case kAddPointTag: {
            self.senderActionType = kAddPoint;
        }
            break;
        case kAddLineTag: {
            self.senderActionType = kAddLine;
        }
            break;
        case kAddSegmentTag: {
            self.senderActionType = kAddSegment;
        }
            break;
        case kAddCustomPointTag: {
            self.senderActionType = kAddCustomPoint;
            self.customPointView = [[[CustomPoint alloc] init] autorelease];
            self.customPointView.alpha = 0;
            [self.view addSubview: self.customPointView];
            self.customPointView.delegate = self;
            [UIView animateWithDuration:1 animations:^(void){
                self.customPointView.alpha = 1;
                self.settingButtonsView.alpha = 0;
            }
            completion:nil];
        }
            break;
        case kAddCustomLineTag: {
            self.senderActionType = kAddCustomLine;
            self.customLineView = [[[CustomLine alloc] init] autorelease];
            self.customLineView.alpha = 0;
            [self.view addSubview:self.customLineView];
            self.customLineView.delegate = self;
            [UIView animateWithDuration:1 animations:^(void){
                self.customLineView.alpha = 1;
                self.settingButtonsView.alpha = 0;
            }
            completion:nil];
        }
            break;
        case kAddCustomSegmentTag: {
            self.senderActionType = kAddCustomSegment;
            self.customSegmentView = [[[CustomSegment alloc] init] autorelease];
            self.customSegmentView.alpha = 0;
            [self.view addSubview:self.customSegmentView];
            self.customSegmentView.delegate = self;
            [UIView animateWithDuration:1 animations:^(void){
                self.customSegmentView.alpha = 1;
                self.settingButtonsView.alpha = 0;
            }
            completion:nil];
        }
            break;
        case kClearBoardTag: {
            self.senderActionType = kClearBoard;
        }
            break;
        case kChangeColorTag: {
            self.senderActionType = kChangeColor;
            self.colorPicker = [[[CustomColor alloc] init] autorelease];
            self.colorPicker.alpha = 0;
            self.colorPicker.delegate = self;
            [UIView animateWithDuration:1 animations:^(void){
                self.colorPicker.alpha = 1;
                self.settingButtonsView.alpha = 0;
            }
            completion:nil];
            //[self presentModalViewController:self.colorPicker animated:YES];
            
            [self.view addSubview:self.colorPicker];
        }
            break;
        default:
            break;
    }
    if ((self.senderActionType != kAddCustomPoint) &&
        (self.senderActionType != kAddCustomLine) &&
        (self.senderActionType != kAddCustomSegment) &&
        (self.senderActionType != kChangeColor)) {
        if ([self.delegate respondsToSelector:@selector(hideSettingsView:withCustomShape:)]) {
            [self.delegate hideSettingsView:self.senderActionType withCustomShape:nil];
        }
    }
}

#pragma mark - CustomShapeDelegate Methods
- (void)closeCustomShapeView:(UIView*)curView
{
    if ([curView isKindOfClass:[self.customPointView class]]) {
        [UIView animateWithDuration:delayForSubView animations:^(void){
            self.customPointView.alpha = 0;
            self.settingButtonsView.alpha = 1;
        }completion:nil];
        
        [self.customPointView removeFromSuperview];
    }
    if ([curView isKindOfClass:[self.customSegmentView class]]) {
        [UIView animateWithDuration:delayForSubView animations:^(void){
            self.customSegmentView.alpha = 0;
            self.settingButtonsView.alpha = 1;
        }completion:nil];
        
        [self.customSegmentView removeFromSuperview];
    }
    if ([curView isKindOfClass:[self.customLineView class]]) {
        [UIView animateWithDuration:delayForSubView animations:^(void){
            self.customLineView.alpha = 0;
            self.settingButtonsView.alpha = 1;
        }completion:nil];
        
        [self.customLineView removeFromSuperview];
    }
    if ([self.delegate respondsToSelector:@selector(hideSettingsView:withCustomShape:)]) {
        [self.delegate hideSettingsView:self.senderActionType withCustomShape:nil];
    }
}

- (void)createPoint: (CGPoint)point
{
    [UIView animateWithDuration:delayForSubView animations:^(void){
        self.customPointView.alpha = 0;
    } completion:nil];
    [self.customPointView removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(hideSettingsView:withCustomShape:)]) {
        [self.delegate hideSettingsView:self.senderActionType withCustomShape:[[[SPoint alloc] initWithPoint:point WithColor:nil] autorelease]];
    }
}

- (void)createSegment: (CGPoint)firstPoint secondPoint:(CGPoint)secondPoint
{
    [UIView animateWithDuration:delayForSubView animations:^(void){
        self.customPointView.alpha = 0;
    } completion:nil];
    [self.customSegmentView removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(hideSettingsView:withCustomShape:)]) {
        [self.delegate hideSettingsView:self.senderActionType withCustomShape:[[[SSegment alloc] initWithFirstPoint:firstPoint LastPoint:secondPoint withColor:nil] autorelease]];
    }

}

// ax+by+c = 0
- (void)createLineWithKoeffA: (CGFloat)a B:(CGFloat)b C:(CGFloat)c
{
    [UIView animateWithDuration:delayForSubView animations:^(void){
        self.customLineView.alpha = 0;
    } completion:nil];
    [self.customLineView removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(hideSettingsView:withCustomShape:)]) {
        [self.delegate hideSettingsView:self.senderActionType withCustomShape:[[[SLine alloc] initWithKoefA:a B:b C:c withColor:nil] autorelease] ];
    }
}

#pragma mark - ColorPickerViewDelegate Methods
- (void)closePickerViewWithColor:(UIColor*)color
{
    if ([self.delegate respondsToSelector: @selector(changeColor:)]) {
        [self.delegate changeColor: color];
       
            [UIView animateWithDuration:delayForSubView animations:^(void){
                self.colorPicker.alpha = 0;
                self.settingButtonsView.alpha = 1;
            }completion:nil];
            
            [self.colorPicker removeFromSuperview];
    }
}

@end
