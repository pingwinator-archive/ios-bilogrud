//
//  GridGraphic.m
//  EndlessGrid
//
//  Created by Natasha on 24.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//
#import <math.h>
#import "GridGraphic.h"
#import "SPoint.h"
#import "SLine.h"
#import "SSegment.h"


@interface GridGraphic()
@property (assign, nonatomic) CGPoint firstTouchPoint;
@property (assign, nonatomic) NSInteger offsetForIntAsixX;
@property (assign, nonatomic) NSInteger offsetForIntAsixY;
@property (assign, nonatomic) NSInteger amountLinesX;
@property (assign, nonatomic) NSInteger amountLinesY;
@property (retain, nonatomic) NSMutableArray* shapes;
@property (assign, nonatomic) BOOL existStartOfSegment;
@property (assign, nonatomic) BOOL existStartOfLine;
@property (assign, nonatomic) CGPoint firstDekartSegment;
@property (assign, nonatomic) CGPoint lastDekartSegment;
@property (assign, nonatomic) CGPoint firstDekartLinePoint;
@property (assign, nonatomic) CGPoint lastDekartLinePoint;
@property (assign, nonatomic) CGFloat lastCellScale;

@property (retain, nonatomic) SLine* xMinDekartLine;
@property (retain, nonatomic) SLine* xMaxDekartLine;
@property (retain, nonatomic) SLine* yMinDekartLine;
@property (retain, nonatomic) SLine* yMaxDekartLine;

- (void)addGesture;
- (void)performTapGesture: (UITapGestureRecognizer*)tapGestureRecognizer;
- (void)performPinchGesture: (UIPinchGestureRecognizer*)pinchGestureRecognizer;
- (void)performPanGesture: (UIPanGestureRecognizer*)panGestureRecognizer;
- (CGPoint)screenToDekart: (CGPoint)screen;
- (CGPoint)dekartToScreen: (CGPoint)dekart;
- (void)drawGrid:(CGRect)rect withContext: (CGContextRef)context;
- (void)drawSegment: (SSegment*)shapeSegment withContext: (CGContextRef)context;
- (void)drawLine: (SLine*)shapeLine withContext: (CGContextRef)context;
@end
 
@implementation GridGraphic
@synthesize cellHeight;
@synthesize cellWidth;
@synthesize gridOffsetX;
@synthesize gridOffsetY;
@synthesize firstTouchPoint;
@synthesize offsetForIntAsixX;
@synthesize offsetForIntAsixY;
@synthesize amountLinesX;
@synthesize amountLinesY;
@synthesize shapes;
@synthesize actionType;
@synthesize existStartOfSegment;
@synthesize firstDekartSegment;
@synthesize lastDekartSegment;
@synthesize existStartOfLine;
@synthesize firstDekartLinePoint;
@synthesize lastDekartLinePoint;
@synthesize lastCellScale;
@synthesize xMaxDekartLine;
@synthesize xMinDekartLine;
@synthesize yMaxDekartLine;
@synthesize yMinDekartLine;
@synthesize shapeColor;
- (void) dealloc
{
    self.cellHeight = nil;
    self.cellWidth = nil;
    self.xMaxDekartLine = nil;
    self.xMinDekartLine = nil;
    self.yMaxDekartLine = nil;
    self.yMinDekartLine = nil;
    self.shapeColor = nil;
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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self addGesture];
        [self addInitGraphic];
    }
    return self;
}

- (void)addInitGraphic
{
  
    self.cellHeight = [NSNumber numberWithDouble:kCellHeight_iPhone];
    self.cellWidth = [NSNumber numberWithDouble:kCellWidth_iPhone];
    
    self.amountLinesX = self.frame.size.width  / [self.cellWidth intValue];
    self.amountLinesY = self.frame.size.height  / [self.cellHeight intValue];
    
    self.gridOffsetX =  0.0f;
    self.gridOffsetY = - self.frame.size.height;
    DBLog(@"offset y %f", self.gridOffsetY);
    
    self.shapes = [[NSMutableArray alloc] init];
    
    SPoint* testPoint = [[SPoint alloc] initWithPoint:CGPointMake(2, -3) WithColor:[UIColor greenColor]];
    [self.shapes addObject:testPoint];
    [testPoint release];
    
    SSegment* testSegment = [[SSegment alloc] initWithFirstPoint:CGPointMake(1, -1) LastPoint:CGPointMake(3, -2) withColor:[UIColor redColor]];
    [self.shapes addObject:testSegment];
    [testSegment release];
    
    SLine* testLine = [[SLine alloc] initWithFirstPoint:CGPointMake(1, -1) secondPoint:CGPointMake(2, 0) withColor:[UIColor brownColor]];
    [self.shapes addObject:testLine];
    [testLine release];
    
    self.actionType = kAddPoint;
    self.lastCellScale = kCellHeight_iPhone;
    self.shapeColor = [self lastShape].color;
}

#pragma mark - GestureRecognizers Methods

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
    switch (self.actionType) {
        case kAddPoint: {
            CGPoint tapedPoint =  [tapGestureRecognizer locationInView:self];
            DBLog(@">>>>>>tap! %f %f", tapedPoint.x, tapedPoint.y);
            SPoint*  shapePoint = [[SPoint alloc] initWithPoint:[self screenToDekart:tapedPoint] WithColor:self.shapeColor];
            [self.shapes addObject:shapePoint];
            [shapePoint release];
            [self setNeedsDisplay];
        }
            break;
        case kAddLine: {
            DBLog(@"draw line!!!!");
            if(self.existStartOfLine) {
                 CGPoint secondTap = [tapGestureRecognizer locationInView:self];
                self.lastDekartLinePoint = [self screenToDekart:secondTap];
                SLine* line = [[SLine alloc] initWithFirstPoint:self.firstDekartLinePoint secondPoint:self.lastDekartLinePoint withColor:self.shapeColor];
                
                [self.shapes addObject:line];
                [line release];
                [self setNeedsDisplay];
                self.existStartOfLine = NO;
            } else {
                CGPoint firstTap = [tapGestureRecognizer locationInView:self];
                self.firstDekartLinePoint = [self screenToDekart:firstTap];
                self.existStartOfLine = YES;
            }
        }
            break;
        case kAddSegment: {
            if(self.existStartOfSegment) {
                CGPoint secondTap = [tapGestureRecognizer locationInView:self];
                self.lastDekartSegment = [self screenToDekart:secondTap];
                SSegment* segment = [[SSegment alloc] initWithFirstPoint:self.firstDekartSegment LastPoint:self.lastDekartSegment withColor:self.shapeColor];//]hFirstPoint:firstDekart lastPoint:secondDekart];
                [self.shapes addObject:segment];
                [segment release];
                [self setNeedsDisplay];
                self.existStartOfSegment = NO;
            } else {
                CGPoint firstTap = [tapGestureRecognizer locationInView:self];
                self.firstDekartSegment = [self screenToDekart:firstTap];
                self.existStartOfSegment = YES;
            }
        }
            break;
        default: {
            DBLog(@"undefine drawing. Who is here?");
        }
            break;
    }
}

- (void)performPinchGesture: (UIPinchGestureRecognizer*) pinchGestureRecognizer
{
    DBLog(@"%f",[pinchGestureRecognizer scale ]);

    CGFloat newH = [pinchGestureRecognizer scale] * [self.cellHeight floatValue];
    DBLog(@"%f", newH);
    
    if(newH < minZoom){
        newH = minZoom;
    }
    if(newH > maxZoom) {
        newH = maxZoom;
    }
    self.cellHeight = [NSNumber numberWithFloat:newH];
    self.cellWidth = [NSNumber numberWithFloat:newH];
    [self setNeedsDisplay];
}

- (void)performPanGesture: (UIPanGestureRecognizer*) panGestureRecognizer
{
    CGPoint translation = [panGestureRecognizer translationInView:self];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.firstTouchPoint = translation;
    }
    CGFloat deltaX = translation.x - self.firstTouchPoint.x;
    CGFloat deltaY = translation.y - self.firstTouchPoint.y;
    self.firstTouchPoint = translation;

    self.gridOffsetX  = deltaX + self.gridOffsetX;
    self.gridOffsetY = deltaY + self.gridOffsetY;
    [self setNeedsDisplay ];
}

#pragma mark - Сonversion Points Methods

- (CGPoint) dekartToScreen: (CGPoint)dekart 
{
    CGPoint screen = CGPointMake(dekart.x * [self.cellWidth floatValue] + self.gridOffsetX, self.frame.size.height - (dekart.y * [self.cellHeight floatValue] - self.gridOffsetY ));
    DBLog(@"h : %f", self.frame.size.height);
    return screen;
}

- (CGPoint) screenToDekart: (CGPoint)screen 
{
    CGPoint dekart;
    dekart.x = screen.x / [self.cellWidth floatValue]  - self.gridOffsetX / [self.cellWidth floatValue];
    
    dekart.y = (self.frame.size.height  + self.gridOffsetY - screen.y) / [self.cellHeight floatValue];
    return dekart;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    UIColor *magentaColor = [UIColor colorWithRed:0.5f  green:0.0f blue:0.5f alpha:1.0f];
    [magentaColor set];
   
    self.amountLinesX = self.frame.size.width  / [self.cellWidth intValue];
    self.amountLinesY = self.frame.size.height  / [self.cellHeight intValue];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
 
    //grid
    [self drawGrid:rect withContext:context];
    
    self.yMinDekartLine = [[SLine alloc] initWithKoefA:0 B:1 C:-(gridOffsetY/[self.cellHeight intValue]) withColor:nil];
    self.yMaxDekartLine = [[[SLine alloc] initWithKoefA:0 B:1 C:-((gridOffsetY + rect.size.height)/[self.cellHeight intValue]) withColor:nil] autorelease];
    for (id shape in self.shapes) {
        //point
        if([shape isKindOfClass:[SPoint class]]) {
            [self drawPoint:shape withContext:context];
        }
        //segment
        if([shape isKindOfClass:[SSegment class]]) {
            [self drawSegment:shape withContext:(CGContextRef)context];
        }
        //line
        if([shape isKindOfClass:[SLine class]]) {
           [self drawLine:shape withContext:context];
        }
    }
    CGContextStrokePath(context);
}

- (void)drawGrid:(CGRect)rect withContext:(CGContextRef)context
{
    float offsetForCellX = fmodf(self.gridOffsetX, [cellWidth floatValue]);
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f];
    //vertical lines
    self.offsetForIntAsixX = self.gridOffsetX / -[self.cellWidth intValue];
    for(int i = rect.origin.x + offsetForCellX, j = 0; i < (rect.origin.x + rect.size.width) && j <= amountLinesX + 1; i += [self.cellWidth intValue], j++)
    {
        CGContextMoveToPoint(context, i, 0);
        CGContextAddLineToPoint(context, i, rect.origin.y + self.frame.size.height);
        
        NSString *numberXStr = [NSString stringWithFormat:@"%d", j + self.offsetForIntAsixX];
        [numberXStr drawAtPoint:CGPointMake(i + 2., 2.) withFont:helveticaBold];
    }
    self.xMinDekartLine = [[[SLine alloc] initWithKoefA:1 B:0 C:-(gridOffsetX/[self.cellWidth intValue]) withColor:nil] autorelease];
    self.xMaxDekartLine = [[[SLine alloc] initWithKoefA:1 B:0 C:-((gridOffsetX + rect.size.width)/[self.cellWidth intValue]) withColor:nil] autorelease];
    
    float offsetForCellY = fmodf(self.gridOffsetY, [cellHeight floatValue]);
    
    self.offsetForIntAsixY = self.gridOffsetY / [self.cellHeight intValue];
    
    for (int i = rect.origin.y + offsetForCellY, j = self.amountLinesY; i < (rect.origin.y + rect.size.height) && j >= - 1; i += [self.cellHeight intValue], j--) {
        CGContextMoveToPoint(context, 0, i);
        CGContextAddLineToPoint(context, self.frame.size.width, i);
        //text
        NSString *numberYStr = [NSString stringWithFormat:@"%d", j + self.offsetForIntAsixY];
        [numberYStr drawAtPoint:CGPointMake(2., i +2.) withFont:helveticaBold];
    }
}

- (void)drawPoint:(SPoint*)shapePoint withContext:(CGContextRef)context
{
    CGContextStrokePath(context);
    CGContextSetStrokeColorWithColor(context, shapePoint.color.CGColor);
    [shapePoint.color setFill];
    CGPoint screen = [self dekartToScreen:shapePoint.dekartPoint];
    CGContextAddEllipseInRect(context,(CGRectMake (screen.x - radPoint/2, screen.y - radPoint/2,radPoint, radPoint)));
    CGContextFillEllipseInRect(context, CGRectMake (screen.x - radPoint/2, screen.y - radPoint/2,radPoint, radPoint));
    CGContextDrawPath(context, kCGPathFill);
}

- (void)drawSegment:(SSegment*)shapeSegment withContext:(CGContextRef)context
{
    CGContextStrokePath(context);
    if(!shapeSegment.color) {
        shapeSegment.color = self.shapeColor;
    }
    CGContextSetStrokeColorWithColor(context, shapeSegment.color.CGColor);
    CGPoint firstPointScreen = [self dekartToScreen: shapeSegment.firstPointDekart];
    CGPoint lastPointScreen = [self dekartToScreen: shapeSegment.lastPointDekart];
    CGContextMoveToPoint(context, firstPointScreen.x, firstPointScreen.y);
    CGContextAddLineToPoint(context, lastPointScreen.x, lastPointScreen.y);
    CGContextStrokePath(context);
    [shapeSegment.color setFill];
    CGContextAddEllipseInRect(context,(CGRectMake (firstPointScreen.x - radPoint/2, firstPointScreen.y - radPoint/2,radPoint, radPoint)));
    CGContextFillEllipseInRect(context, CGRectMake (firstPointScreen.x - radPoint/2, firstPointScreen.y - radPoint/2,radPoint, radPoint));
    CGContextAddEllipseInRect(context,(CGRectMake (lastPointScreen.x - radPoint/2, lastPointScreen.y - radPoint/2,radPoint, radPoint)));
    CGContextFillEllipseInRect(context, CGRectMake (lastPointScreen.x - radPoint/2, lastPointScreen.y - radPoint/2,radPoint, radPoint));
    CGContextDrawPath(context, kCGPathFill);
}

- (void)drawLine:(SLine*)shapeLine withContext:(CGContextRef)context
{
    BOOL count = NO;
    CGPoint firstIntersectWithAsix;
    CGPoint secondIntersectWithAsix;
    if(!shapeLine.color) {
        shapeLine.color = self.shapeColor;
    }

    NSValue* val  = [SLine intersectLine:shapeLine withSecondLine:self.xMinDekartLine];
    if(val) {
        CGPoint p = [val CGPointValue];
        if(count )  {
            secondIntersectWithAsix = p;
        } else {
            if(p.x != 0) {
                firstIntersectWithAsix = p;
                count = YES;
            }
        }
    }
    val  = [SLine intersectLine:shapeLine withSecondLine:self.yMinDekartLine];
    if(val) {
        CGPoint p = [val CGPointValue];
        if(count) {
            secondIntersectWithAsix = p;
        } else {
            if(p.x != 0) {
                firstIntersectWithAsix = p;
                count = YES;
            }
        }
    }
    val  = [SLine intersectLine:shapeLine withSecondLine:self.xMaxDekartLine];
    if(val) {
        CGPoint p = [val CGPointValue];
        if(count) {
            secondIntersectWithAsix = p;
        } else {
            if(p.x != 0) {
                firstIntersectWithAsix = p;
                count = YES;
            }
        }
    }
    val  = [SLine intersectLine:shapeLine withSecondLine:self.yMaxDekartLine];
    if(val) {
        CGPoint p = [val CGPointValue];
        if(count) {
            secondIntersectWithAsix = p;
        } else {
            if(p.x != 0) {
                firstIntersectWithAsix = p;
                count = YES;
            }
        }
    }
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, shapeLine.color.CGColor);
    //points intersect to screen
    CGPoint firstPointScreen = [self dekartToScreen: firstIntersectWithAsix];
    CGPoint lastPointScreen = [self dekartToScreen: secondIntersectWithAsix];
    CGContextMoveToPoint(context, firstPointScreen.x, firstPointScreen.y);
    CGContextAddLineToPoint(context, lastPointScreen.x, lastPointScreen.y);
}

- (void)clearBoard
{
    if(self.actionType == kClearBoard) {
        [self.shapes removeAllObjects];
        self.shapeColor = [UIColor blackColor];
        [self setNeedsDisplay];
    }
}

- (Shape*)lastShape
{
    return [self.shapes lastObject];
}

//call by view controller
- (void)addCustomShape:(Shape*)shape
{
    [self.shapes addObject:shape];
    [self setNeedsDisplay];
}
@end
