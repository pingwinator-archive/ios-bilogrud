//
//  GridGraphic.m
//  EndlessGrid
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//
#import <math.h>
#import "GridGraphic.h"
#define kCellHeight 40.0
#define kCellWidth 40.0

@interface GridGraphic()
@property (assign, nonatomic) CGPoint firstTouchPoint;
@property (assign, nonatomic) CGPoint lastTouchPoint;
@end
@implementation GridGraphic
@synthesize cellHeight;
@synthesize cellWidth;
@synthesize gridOffsetX;
@synthesize gridOffsetY;
@synthesize rectDrawing;
@synthesize firstTouchPoint;
@synthesize lastTouchPoint;

- (void) dealloc
{
    self.cellHeight = nil;
    self.cellWidth = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGesture];
    }
    return self;
}
- (id) init
{
    self = [super init];
    if(self) {
        [self addGesture];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self addGesture];
        self.gridOffsetX = 0.f;
        self.rectDrawing = self.frame;
    }
    return self;
}

- (void)addGesture
{
    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(performPanGesture:)];
    [panGestureRecognizer setMinimumNumberOfTouches: 1];
    [panGestureRecognizer setMaximumNumberOfTouches: 1];
    [self addGestureRecognizer:panGestureRecognizer];
    [panGestureRecognizer release];
}

- (void) performPanGesture: (UIPanGestureRecognizer*) panGestureRecognizer
{
    CGPoint translation = [panGestureRecognizer translationInView:self];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.firstTouchPoint = translation;
    }
    CGFloat deltaX = translation.x - self.firstTouchPoint.x;
    CGFloat deltaY = translation.y - self.firstTouchPoint.y;
    self.firstTouchPoint = translation;
//    NSLog(@"---translation %d %d", (int)translation.x, (int)translation.y);
    self.gridOffsetX  = deltaX + self.gridOffsetX;
    self.gridOffsetY = deltaY + self.gridOffsetY;
    
    CGRect test = CGRectMake(self.rectDrawing.origin.x , self.rectDrawing.origin.y, self.rectDrawing.size.width, self.rectDrawing.size.height);
  
    self.rectDrawing = test;
    [self setNeedsDisplayInRect:self.rectDrawing];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.cellHeight = [NSNumber numberWithDouble:kCellHeight];
    self.cellWidth = [NSNumber numberWithDouble:kCellWidth];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
//    for (int i = self.gridOffsetX; i < self.gridOffsetX  + self.frame.size.width;  i += kCellWidth) {
//        NSLog(@"%f", self.gridOffsetX);
//        CGContextMoveToPoint(context, i, 0);
//        CGContextAddLineToPoint(context, i, self.frame.size.height);
//    }
    float offsetForCellX = fmodf(self.gridOffsetX, [cellWidth floatValue]);// [self.gridOffsetX intValue] % [cellWidth intValue];
    for(int i = rect.origin.x + offsetForCellX; i < rect.origin.x + rect.size.width; i += kCellWidth)
    {
        CGContextMoveToPoint(context, i, 0);
        CGContextAddLineToPoint(context, i, self.frame.size.height);
    }
    
    float offsetForCellY = fmodf(self.gridOffsetY, [cellHeight floatValue]);
    for (int j = rect.origin.y + offsetForCellY; j < rect.origin.y + rect.size.height; j += kCellHeight ) {
        CGContextMoveToPoint(context, 0, j);
        CGContextAddLineToPoint(context, self.frame.size.width, j);
    }
//    NSLog(@"rect : %f %f", self.rectDrawing.origin.x, self.rectDrawing.origin.y);
//    for(int j = self.gridOffsetY ; j < self.gridOffsetY + self.frame.size.height; j += kCellHeight ){
//        CGContextMoveToPoint(context, 0, j);
//        CGContextAddLineToPoint(context, self.frame.size.width, j);
//    }
    
    CGContextStrokePath(context);
}

@end
