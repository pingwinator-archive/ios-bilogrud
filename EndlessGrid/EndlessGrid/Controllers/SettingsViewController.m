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
@interface SettingsViewController ()
@property (retain, nonatomic) CustomPoint* customPointView;
@property (retain, nonatomic) CustomSegment* customSegment;
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
@synthesize settingButtonsView;
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
    self.settingButtonsView = nil;
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
    self.pointsOfCustomShape = nil;
    self.settingButtonsView = nil;
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
        }
            break;
        case kAddCustomSegmentTag: {
            self.senderActionType = kAddCustomSegment;
            self.customSegment = [[[CustomSegment alloc] init] autorelease];
            self.customSegment.alpha = 0;
            [self.view addSubview:self.customSegment];
            self.customSegment.delegate = self;
            [UIView animateWithDuration:1 animations:^(void){
                self.customSegment.alpha = 1;
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

#pragma mark - CustomShapeDelegate Methods
- (void)closeCustomShapeView
{

}

- (void)createPoint: (CGPoint)point
{
    [self.pointsOfCustomShape addObject:[NSValue valueWithCGPoint:point]];
    [self.customPointView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(hideSettingsView:)]) {
        [self.delegate hideSettingsView:self.senderActionType];
    }

}

- (void)createSegment: (CGPoint)firstPoint secondPoint:(CGPoint)secondPoint
{

}

// ax+by+c = 0
- (void)createLineWithKoeffA: (CGFloat)a B:(CGFloat)b C:(CGFloat)c
{

}


- (void)closeCustomPointView
{
    [UIView animateWithDuration:1 animations:^(void){
        self.customPointView.alpha = 0;
        self.settingButtonsView.alpha = 1;
    }completion:nil];
    
//    [self.customPointView.view removeFromSuperview];
}
@end
