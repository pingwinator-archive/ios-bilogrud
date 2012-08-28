//
//  ViewController.m
//  TouchExplorer
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tapLabel;
@synthesize touchLabel;
@synthesize messageLabel;


-(void) dealloc{
    self.messageLabel = nil;
    self.tapLabel = nil;
    self.touchLabel = nil;
    [super dealloc];
}

-(void)updateLabelsFromTouches : (NSSet *)touches{
    NSUInteger numTaps = [[touches anyObject]tapCount];
    NSString *tapsMessage = [[NSString alloc] initWithFormat:@"%d taps detected", numTaps ];
    self.tapLabel.text = tapsMessage;
    
    NSUInteger numTouches = [touches count];
    NSString *touchMessage = [[NSString alloc]initWithFormat:@"%d touches detected", numTouches ];
    self.touchLabel.text = touchMessage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.messageLabel = nil;
    self.tapLabel = nil;
    self.touchLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - Touches Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    messageLabel.text = @"Touches Began";
    [self updateLabelsFromTouches:touches];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    messageLabel.text = @"Touches Cancelled";
    [self updateLabelsFromTouches:touches];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    messageLabel.text = @"Touches Ended";
    [self updateLabelsFromTouches:touches];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    messageLabel.text = @"Touches Moved";
    [self updateLabelsFromTouches:touches];
}
@end
