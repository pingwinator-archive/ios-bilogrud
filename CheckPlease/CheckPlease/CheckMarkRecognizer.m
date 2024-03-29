//
//  CheckMarkRecognizer.m
//  CheckPlease
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CheckMarkRecognizer.h"
#import "CGPointUtils.h"
#import "UIKit/UIGestureRecognizerSubclass.h"

#define kMinimumCheckMarkAngle 50 
#define kMaximumCheckMarkAngle 135 
#define kMinimumCheckMarkLength 10

@implementation CheckMarkRecognizer
@synthesize lastPreviousPoint;
@synthesize lastCurrentPoint;
@synthesize lineLengthSoFar;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    lastPreviousPoint = point;
    lastCurrentPoint = point;
    lineLengthSoFar = 0.0f;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint previousPoint = [ touch previousLocationInView:self.view];
    CGPoint currentPoint = [ touch locationInView:self.view];
    CGFloat angle = angleBetweenLines(lastPreviousPoint, lastCurrentPoint, previousPoint,currentPoint);
    if (angle >= kMinimumCheckMarkAngle && angle <= kMaximumCheckMarkAngle
        && lineLengthSoFar > kMinimumCheckMarkLength) {
        self.state = UIGestureRecognizerStateEnded;
    }
    lineLengthSoFar += distanceBetweenPoints(previousPoint, currentPoint);
    lastPreviousPoint = previousPoint;
    lastCurrentPoint = currentPoint;
}
@end
