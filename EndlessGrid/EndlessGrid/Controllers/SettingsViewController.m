//
//  SettingsViewController.m
//  EndlessGrid
//
//  Created by Natasha on 27.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize closeButton;
@synthesize delegate;
@synthesize addLine;
@synthesize addPoint;
@synthesize addSegment;
@synthesize senderActionType;

- (void)dealloc
{
    self.closeButton = nil;
    self.delegate = nil;
    self.addLine = nil;
    self.addPoint = nil;
    self.addSegment = nil;
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
	// Do any additional setup after loading the view.
    
   }
-(void)viewDidUnload
{
    self.closeButton = nil;
    self.delegate = nil;
    self.addLine = nil;
    self.addPoint = nil;
    self.addSegment = nil;
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
        case kAddPointTag: {
            self.senderActionType = kAddPoint;
        }
            break;
        case kAddLineTag: {
            self.senderActionType = kAddLine;
        }
            break;
        case kAddSegmentTag:{
            self.senderActionType = kAddSegment;
        }
            break;
        case kOnlyClose:{
            self.senderActionType = kAddNone;
        }
            break;
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(hideSettingsView:)]) {
        [self.delegate hideSettingsView:self.senderActionType];
    }
}
@end
