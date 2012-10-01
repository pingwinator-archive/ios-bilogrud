  //
//  CustomPointVIewController.m
//  EndlessGrid
//
//  Created by Natasha on 30.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomPointVIewController.h"

@interface CustomPointVIewController ()
@property(retain, nonatomic) UITextField* xCoordinate;
@property(retain, nonatomic) UITextField* yCoordinate;
@property(retain, nonatomic) UILabel* xText;
@property(retain, nonatomic) UILabel* yText;
@property(retain, nonatomic) UIButton* canselButton;
@property(retain, nonatomic) UIButton* saveButton;
@end

@implementation CustomPointVIewController
@synthesize xCoordinate;
@synthesize yCoordinate;
@synthesize xText;
@synthesize yText;
@synthesize canselButton;
@synthesize saveButton;

- (void)dealloc
{
    self.xCoordinate = nil;
    self.yCoordinate = nil;
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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(45, 110, 20, 30);
    self.xText = [[[UILabel alloc] initWithFrame:rect] autorelease];
    self.xText.text = @"x";
    self.xText.contentMode = UIViewContentModeLeft;
    [self.view addSubview:self.xText];
    
    rect.origin.y += 40;
    self.yText = [[[UILabel alloc] initWithFrame:rect] autorelease];
    self.yText.text = @"y";
    self.yText.contentMode = UIViewContentModeLeft;
    [self.view addSubview:self.yText];

    CGRect rectTextField = CGRectMake(75, 110, 50, 30);
    self.yCoordinate = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
    self.yCoordinate.borderStyle = UITextBorderStyleRoundedRect;
    self.yCoordinate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.yCoordinate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.yCoordinate.text = @"-1";
    [self.view addSubview:self.yCoordinate];
    
    rectTextField.origin.y += 40;
    self.xCoordinate = [[[UITextField alloc] initWithFrame:rectTextField] autorelease];
    self.xCoordinate.borderStyle = UITextBorderStyleRoundedRect;
    self.xCoordinate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.xCoordinate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.xCoordinate.text = @"4";
    [self.view addSubview:self.xCoordinate];
    
    CGRect rectButton = CGRectMake(75, 180, 80, 30);
    self.canselButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.canselButton.frame = rectButton;
    [self.canselButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.canselButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.canselButton];
    
    rectButton.origin.x += 100;
    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.saveButton.frame = rectButton;
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)close
{
    if ([self.delegate respondsToSelector:@selector(closeCustomShapeView)]) {
        [self.delegate closeCustomShapeView];
    }
}

- (void)save
{
//    if ([self.delegate respondsToSelector:@selector(hideCustomPointView:)]) {
//        if([self.xCoordinate.text length] && [self.yCoordinate.text length]) {
//            NSValue* val = [NSValue valueWithCGPoint:CGPointMake([self.xCoordinate.text floatValue], [self.yCoordinate.text floatValue])];
//            [self.delegate hideCustomPointView: val];
//        } else {
//             [self.delegate hideCustomPointView: nil];
//        }
//    }
//     [self dismissModalViewControllerAnimated:YES];
}
@end
