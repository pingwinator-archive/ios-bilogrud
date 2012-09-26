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
@property (assign, nonatomic) NSInteger offsetForIntAsixX;
@property (assign, nonatomic) NSInteger offsetForIntAsixY;
@property (assign, nonatomic) NSInteger amountLinesX;
@property (assign, nonatomic) NSInteger amountLinesY;
@end

@implementation GridGraphic
@synthesize cellHeight;
@synthesize cellWidth;
@synthesize gridOffsetX;
@synthesize gridOffsetY;
@synthesize rectDrawing;
@synthesize firstTouchPoint;
@synthesize offsetForIntAsixX;
@synthesize offsetForIntAsixY;
@synthesize amountLinesX;
@synthesize amountLinesY;
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
        self.cellHeight = [NSNumber numberWithDouble:kCellHeight];
        self.cellWidth = [NSNumber numberWithDouble:kCellWidth];

        self.amountLinesX = self.frame.size.width  / [self.cellWidth intValue];
        self.amountLinesY = self.frame.size.height  / [self.cellHeight intValue];
        
        self.gridOffsetX =  0.0f + [self.cellWidth intValue];//- self.amountLinesX * [self.cellWidth intValue]; //0.f;
        self.gridOffsetY = - (self.amountLinesY ) * [self.cellHeight intValue];
    }
    return self;
}

- (void)addGesture
{
    //pan
    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(performPanGesture:)];
    [panGestureRecognizer setMinimumNumberOfTouches: 1];
    [panGestureRecognizer setMaximumNumberOfTouches: 1];
    [self addGestureRecognizer:panGestureRecognizer];
    [panGestureRecognizer release];

    //pinch
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(performPinchGesture:)];
    [self addGestureRecognizer:pinch];
    [pinch release];
    
    //tap
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performTapGesture:)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [self addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer release];

}
- (void)performTapGesture: (UITapGestureRecognizer*)tapGestureRecognizer
{
    CGPoint tapedPoint =  [tapGestureRecognizer locationInView:self];
    NSLog(@">>>>>>tap! %f %f", tapedPoint.x, tapedPoint.y);
    //to dekart coordinates
    CGPoint dekart = [self screenToDekart:tapedPoint withHeigth:self.frame.size.height];
    NSLog(@"to dekart: %f %f", dekart.x, dekart.y);
    NSLog(@"offsetForIntAsixX: %d", self.offsetForIntAsixX);
    for (int i = self.offsetForIntAsixX; i < self.offsetForIntAsixX + self.amountLinesX; i++) {
        if(tapedPoint.x > i * [self.cellWidth intValue] && tapedPoint.x < (i + 1) * [self.cellWidth intValue])
            NSLog(@"x: %d", i );
        }
}

- (CGPoint) dekartToScreen: (CGPoint)dekart withHeigth
{
    return CGPointMake(dekart.x, self.frame.size.height - dekart.y);
}

- (CGPoint) screenToDekart: (CGPoint)screen withHeigth: (CGFloat) height
{
    return CGPointMake(screen.x, height - screen.y);
}

- (void)performPinchGesture: (UIPinchGestureRecognizer*) pinchGestureRecognizer
{
//    pinchGestureRecognizer.view.transform = CGAffineTransformScale(pinchGestureRecognizer.view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//    
//    pinchGestureRecognizer.scale = 1;
//   // self.cellWidth = [NSNumber numberWithInt:50];
//   // self.cellHeight = [NSNumber numberWithInt:50];
    [self setNeedsDisplayInRect:CGRectMake(100, 200, 200, 200)];

}

- (void)performPanGesture: (UIPanGestureRecognizer*) panGestureRecognizer
{
    CGPoint translation = [panGestureRecognizer translationInView:self];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.firstTouchPoint = translation;
    }
    CGFloat deltaX = translation.x - self.firstTouchPoint.x;
    CGFloat deltaY = translation.y - self.firstTouchPoint.y;
    //self.firstTouchPoint.y - translation.y;//translation.y - self.firstTouchPoint.y;
    self.firstTouchPoint = translation;
//    NSLog(@"---translation %d %d", (int)translation.x, (int)translation.y);
    self.gridOffsetX  = deltaX + self.gridOffsetX;
    self.gridOffsetY = deltaY + self.gridOffsetY;
   // NSLog(@"-------   %f", gridOffsetX);
    CGRect test = CGRectMake(self.rectDrawing.origin.x , self.rectDrawing.origin.y, self.rectDrawing.size.width, self.rectDrawing.size.height);
  
    self.rectDrawing = test;
    [self setNeedsDisplay ];//]InRect:CGRectMake(0, 0, 200, 200)];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   // rect = self.bounds;
    //font, color for numbers
    UIColor *magentaColor = [UIColor colorWithRed:0.5f  green:0.0f blue:0.5f alpha:1.0f];
    [magentaColor set];
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f];
    
   
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    float offsetForCellX = fmodf(self.gridOffsetX, [cellWidth floatValue]);
    

    self.offsetForIntAsixX = self.gridOffsetX / -[self.cellWidth intValue];
    NSLog(@"frig offsetx %f and left val %d first x %f", self.gridOffsetX, self.offsetForIntAsixX, rect.origin.x + offsetForCellX);
   
    for(int i = rect.origin.x - [self.cellWidth intValue] + offsetForCellX, j = 0; i < (rect.origin.x + rect.size.width) && j <= amountLinesX + 1; i += kCellWidth, j++)
    {
        CGContextMoveToPoint(context, i, 0);
        CGContextAddLineToPoint(context, i, rect.origin.y + self.frame.size.height);
    
        NSString *myString = [NSString stringWithFormat:@"%d", j + self.offsetForIntAsixX];
        [myString drawAtPoint:CGPointMake(i + 2., 2.) withFont:helveticaBold];
    }
    
    int addY = 0;
    float offsetForCellY = fmodf(self.gridOffsetY, [cellHeight floatValue]);
    
    if(offsetForCellY < 0)
        addY = 1;
    //int
    self.offsetForIntAsixY = self.gridOffsetY / [self.cellHeight intValue];
    
    for (int i = rect.origin.y + offsetForCellY, j = self.amountLinesY; i < (rect.origin.y + rect.size.height) && j >= - addY; i += kCellHeight, j--) {
        CGContextMoveToPoint(context, 0, i);
        CGContextAddLineToPoint(context, self.frame.size.width, i);
        //text
        NSString *myString = [NSString stringWithFormat:@"%d", j + self.offsetForIntAsixY];
        [myString drawAtPoint:CGPointMake(2., i +2.) withFont:helveticaBold];
    }
    
    CGContextStrokePath(context);
}


@end
