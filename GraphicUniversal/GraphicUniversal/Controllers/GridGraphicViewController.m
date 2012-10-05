//
//  GridGraphicViewController.m
//  GraphicUniversal
//
//  Created by Natasha on 05.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

/*
#import <math.h>
#import "SPoint.h"
#import "SLine.h"
#import "SSegment.h"
#import "GridGraphicViewController.h"
#import "Grid.h"
@interface GridGraphicViewController ()

@property (retain, nonatomic) NSMutableArray* shapes;

- (void)addGesture;
- (void)performTapGesture: (UITapGestureRecognizer*)tapGestureRecognizer;
- (void)performPinchGesture: (UIPinchGestureRecognizer*)pinchGestureRecognizer;
- (void)performPanGesture: (UIPanGestureRecognizer*)panGestureRecognizer;
- (CGPoint)screenToDekart: (CGPoint)screen;
- (CGPoint)dekartToScreen: (CGPoint)dekart;
@end

@implementation GridGraphicViewController
@synthesize shapes;
@synthesize actionType;
- (void) dealloc
{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
*/
