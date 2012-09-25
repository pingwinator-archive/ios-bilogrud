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
@property (assign, nonatomic) NSInteger axisX;
@property (assign, nonatomic) NSInteger axisY;
@end

@implementation GridGraphic
@synthesize cellHeight;
@synthesize cellWidth;
@synthesize gridOffsetX;
@synthesize gridOffsetY;
@synthesize rectDrawing;
@synthesize firstTouchPoint;
@synthesize axisX;
@synthesize axisY;

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
        self.axisX = -2;
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
    
    
    //pinch
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(performPinchGesture:)];
    [self addGestureRecognizer:pinch];
    [pinch release];
    
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performTapGesture:)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [self addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer release];

}
- (void)performTapGesture: (UITapGestureRecognizer*)tapGestureRecognizer
{
    CGPoint p =  [tapGestureRecognizer locationInView:self];
       NSLog(@">>>>>>tap! %f %f", p.x, p.y);
}

- (void)performPinchGesture: (UIPinchGestureRecognizer*) pinchGestureRecognizer
{
    pinchGestureRecognizer.view.transform = CGAffineTransformScale(pinchGestureRecognizer.view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    
    pinchGestureRecognizer.scale = 1;
   // self.cellWidth = [NSNumber numberWithInt:50];
   // self.cellHeight = [NSNumber numberWithInt:50];

}

- (void)performPanGesture: (UIPanGestureRecognizer*) panGestureRecognizer
{
    CGPoint translation = [panGestureRecognizer translationInView:self];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.firstTouchPoint = translation;
    }
    CGFloat deltaX = self.firstTouchPoint.x - translation.x;//translation.x - self.firstTouchPoint.x;
    CGFloat deltaY = self.firstTouchPoint.y - translation.y;//translation.y - self.firstTouchPoint.y;
    self.firstTouchPoint = translation;
//    NSLog(@"---translation %d %d", (int)translation.x, (int)translation.y);
    self.gridOffsetX  = deltaX + self.gridOffsetX;
    self.gridOffsetY = deltaY + self.gridOffsetY;
   // NSLog(@"-------   %f", gridOffsetX);
    CGRect test = CGRectMake(self.rectDrawing.origin.x , self.rectDrawing.origin.y, self.rectDrawing.size.width, self.rectDrawing.size.height);
  
    self.rectDrawing = test;
    [self setNeedsDisplayInRect:self.rectDrawing];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //font, color for numbers
    UIColor *magentaColor = [UIColor colorWithRed:0.5f  green:0.0f blue:0.5f alpha:1.0f];
    [magentaColor set];
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
    
    self.cellHeight = [NSNumber numberWithDouble:kCellHeight];
    self.cellWidth = [NSNumber numberWithDouble:kCellWidth];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    int addX = 0;
    
    float offsetForCellX = fmodf(self.gridOffsetX, [cellWidth floatValue]);
    
    if(offsetForCellX < 0)
        addX = 1;
    int offsetForIntAsixX = self.gridOffsetX / [self.cellWidth intValue];
   
    int amountLinesX = self.frame.size.width  / [cellWidth intValue];
    //NSLog(@"amount visible lines %d", amountLinesX);
    for(int i = rect.origin.x + offsetForCellX, j = 0; i < (rect.origin.x + rect.size.width) && j <= amountLinesX + addX; i += kCellWidth, j++)
    {
        CGContextMoveToPoint(context, i, 0);
        CGContextAddLineToPoint(context, i, rect.origin.y + self.frame.size.height);
       // NSLog(@"h:  %f", self.frame.size.height);
         //text
        NSString *myString = [NSString stringWithFormat:@"%d", j + offsetForIntAsixX];//self.axisX;
        [myString drawAtPoint:CGPointMake(i + 5., 1.) withFont:helveticaBold];
    }
    
    int addY = 0;
    float offsetForCellY = fmodf(self.gridOffsetY, [cellHeight floatValue]);
    
    if(offsetForCellY < 0)
        addY = 1;
    int offsetForIntAsixY = self.gridOffsetY / [self.cellHeight intValue];
    
    int amountLinesY = self.frame.size.height  / [cellHeight intValue];
    for (int i = rect.origin.y + offsetForCellY, j = 0; i < (rect.origin.y + rect.size.height) && j <= amountLinesY + addY; i += kCellHeight, j++) {
        CGContextMoveToPoint(context, 0, i);
        CGContextAddLineToPoint(context, self.frame.size.width, i);
        //text
        NSString *myString = [NSString stringWithFormat:@"%d", j + offsetForIntAsixY];
        [myString drawAtPoint:CGPointMake(1., i +5.) withFont:helveticaBold];
    }
    
    CGContextStrokePath(context);
}

@end
