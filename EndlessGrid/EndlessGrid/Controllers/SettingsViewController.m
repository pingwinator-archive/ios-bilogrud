//
//  SettingsViewController.m
//  EndlessGrid
//
//  Created by Natasha on 27.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIImage+RoundedCorner.h"
#import "CustomPointVIewController.h"
@interface SettingsViewController ()
@property (retain, nonatomic) CustomPointVIewController* customPointView;
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
@synthesize pointsOfCustomShape;
@synthesize beforeAddCustomShapeState;

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
    self.pointsOfCustomShape = nil;
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
//    UIImage* imagePoint = [[UIImage imageNamed:@"PointIcon.png" ] roundedCornerImage:7 borderSize:0];
//    self.addPointImageView.image = imagePoint;
    self.pointsOfCustomShape = [[[NSMutableArray alloc] init] autorelease];
    self.beforeAddCustomShapeState = kAddPoint;
   // self.senderActionType = kAddPoint;
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
    self.pointsOfCustomShape = nil;
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
            self.beforeAddCustomShapeState = self.senderActionType;
            self.senderActionType = kAddCustomPoint;
            self.customPointView = [[CustomPointVIewController alloc]init];
            [self presentModalViewController:self.customPointView animated:YES];
            self.customPointView.delegate = self;
        }
            break;
        case kAddCustomLineTag: {
            self.beforeAddCustomShapeState = self.senderActionType;
            self.senderActionType = kAddCustomLine;
        }
            break;
        case kAddCustomSegmentTag: {
            self.beforeAddCustomShapeState = self.senderActionType;
            self.senderActionType = kAddCustomSegment;
        }
            break;
        case kClearBoardTag: {
            self.beforeAddCustomShapeState = self.senderActionType;
            self.senderActionType = kClearBoard;
            
        }
            break;
        case kChangeColorTag: {
            
            self.senderActionType = kChangeColor;
        }
            break;
        default:
            break;
    }
    if ((self.senderActionType != kAddCustomPoint) &&
        (self.senderActionType != kAddCustomLine) &&
        (self.senderActionType != kAddCustomSegment)) {
        if ([self.delegate respondsToSelector:@selector(hideSettingsView:)]) {
            [self.delegate hideSettingsView:self.senderActionType];
        }
    }
   
}
- (void)hideCustomPointView:(CGPoint)point
{
    
    NSLog(@"%f %f", point.x, point.y);
    [self.pointsOfCustomShape addObject:[NSValue valueWithCGPoint:point]];
  //  [self.delegate hideSettingsView:self.beforeAddCustomShapeState];
    if ([self.delegate respondsToSelector:@selector(hideSettingsView:)]) {
        [self.delegate hideSettingsView:self.beforeAddCustomShapeState];
    }
}
@end
