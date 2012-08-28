//
//  ViewController.m
//  Swipes.
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#define kMaximumVariance 5
#define kMinGestureLen 25
@interface ViewController ()

@end

@implementation ViewController
@synthesize label;
@synthesize gestureStartPoint;

-(void)labelErase{
    self.label.text = @"";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (NSUInteger touchCount = 1; touchCount <= 5; touchCount++) { UISwipeGestureRecognizer *vertical;
        vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVerticalSwipe:)];
        vertical.direction = UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
        vertical.numberOfTouchesRequired = touchCount;
        [self.view addGestureRecognizer:vertical];
        
        UISwipeGestureRecognizer *horizontal;
        horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorisontalSwipe:)];
        horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
        horizontal.numberOfTouchesRequired = touchCount;
        [self.view addGestureRecognizer:horizontal];
    }
    
//    UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(reportVerticalSwipe:)];
//    vertical.direction = UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
//    [self.view addGestureRecognizer:vertical];
//    
//    UISwipeGestureRecognizer *horisontal = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(reportHorisontalSwipe:)];
//    horisontal.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:horisontal];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    self.label = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)reportHorisontalSwipe: (UIGestureRecognizer *) recognizer{
    //label.text = @"Horisontal swipe detected";
    label.text = [NSString stringWithFormat:@"%@ Horisontal swipe", [self descriptionForTouchCount:[recognizer numberOfTouches]]];
    [self performSelector:@selector(labelErase) withObject:nil afterDelay:2];
}

-(void)reportVerticalSwipe: (UIGestureRecognizer *) recognizer{
    //label.text = @"Vertical swipe detected";
      label.text = [NSString stringWithFormat:@"%@ Vertical swipe", [self descriptionForTouchCount:[recognizer numberOfTouches]]];
    [self performSelector:@selector(labelErase) withObject:nil afterDelay:2];
}
- (NSString *)descriptionForTouchCount:(NSUInteger)touchCount {
    switch (touchCount) {
    case 2:
        return @"Double ";
    case 3:
        return @"Triple ";
    case 4:
        return @"Quadruple ";
    case 5:
        return @"Quintuple ";
    default:
        return @"";
}
}
//
//#pragma mark - Touches Methods
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    self.gestureStartPoint = [touch locationInView:self.view];
//}
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint curPos = [touch locationInView:self.view];
//    
//    CGFloat deltaX = fabsf(self.gestureStartPoint.x - curPos.x);
//    CGFloat deltaY = fabsf(self.gestureStartPoint.y - curPos.y);
//    
//    if (deltaX >= kMinGestureLen && deltaY <= kMaximumVariance) {
//        self.label.text = @"Horisontal swipe detected";
//        [self performSelector:@selector(labelErase)withObject:nil afterDelay:2];
//    }
//    else if (deltaX <= kMaximumVariance && deltaY >=kMinGestureLen){
//        self.label.text = @"Vertical swipe detected";
//        [self performSelector:@selector(labelErase)withObject:nil afterDelay:2];
//    }
//}
@end
