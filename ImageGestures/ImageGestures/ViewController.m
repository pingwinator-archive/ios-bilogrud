//
//  ViewController.m
//  ImageGestures
//
//  Created by Natasha on 28.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "CheckMarkRecognizer.h"
#define xStart 8
#define yStart 8

@interface ViewController ()

@end

@implementation ViewController
@synthesize infoLabel;
@synthesize images;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *sort = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width -40, self.view.frame.size.height - 40, 30.0, 30.0 )];
    sort.backgroundColor = [UIColor blackColor];
    [sort addTarget:nil action:@selector(doSort) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sort];
    sort.userInteractionEnabled = YES;
    
    UIImageView *imageViewContent = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"eifel.png"]  ];
    imageViewContent.frame = CGRectMake(120, 50, 100, 100);
     
    UIImageView *test = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"eifel.png"]  ];
    test.frame = CGRectMake(0, 30, 200, 200);
    
    self.images = [[NSMutableArray alloc]initWithObjects:test, imageViewContent, nil];
  
    //[test sizeToFit];
    
    for(UIImageView* obj in images)
    {
        [self initGesture:obj];
    }
    
   // [self.view addSubview:test];
//        //vertical swipe
//    UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doVerticalSwipe:)];
//    vertical.direction = UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
//    [test addGestureRecognizer:vertical];
//    [vertical release];
    
//    //horisontal swipe
//    UISwipeGestureRecognizer *horisontal = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doHorisontalSwipe:)];
//    horisontal.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
//        [test      addGestureRecognizer:horisontal];
//    [horisontal release];
        [test release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)doSort{
    //for(UIImageView* imageView in self.images){
    CGFloat template = 70.0f;
    if([self.images count] > self.view.frame.size.width / (template + 20) * self.view.frame.size.height / (template + 20)){
        CGFloat newTempl = template * 0.7f;
        template = newTempl;
    }
    CGFloat curViewWith = self.view.frame.size.width;
   __block NSInteger amRow = 0;
    __block NSInteger col = 0;
    __block NSInteger curWith = 0;
    
    [UIView animateWithDuration:2 animations:^(void){
    for (NSInteger i = 0; i < [self.images count]; i++) {
        
           curWith =(xStart + xStart * (col + 1) + (col + 1) * template);
        
        if( curWith > curViewWith)
        {
            NSInteger plsRow = amRow + 1;
            
            amRow = plsRow;
            col = 0;
        }
      
        [[self.images objectAtIndex:i]setFrame:CGRectMake(xStart + xStart * col + col * template, yStart+ yStart*amRow + template * amRow, template, template)];
        col++;
    }
    } ];
}
-(void) labelErase{
    self.infoLabel.text = @"";
}
//
-(void)setGuestures :(UIImageView*)test {

  
    //pinch
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(doPinch:)];
    [test addGestureRecognizer:pinch];
    [pinch release];
    
    //rotate
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(doRotate:)];
    [test addGestureRecognizer:rotate];
    [rotate release];
    
    //pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(doPan:)];
    [test addGestureRecognizer:pan];
    [pan setMinimumNumberOfTouches:1];
	[pan setMaximumNumberOfTouches:1];
    [pan release];
    
    //check mark
    CheckMarkRecognizer *checkMark = [[CheckMarkRecognizer alloc]initWithTarget:self action:@selector(doCheck:)];
    [test addGestureRecognizer:checkMark];
    [checkMark release];
    
    //long press
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(doLongPress:)];
    [test addGestureRecognizer:longPress];
    [longPress release];
    
}
-(void)initGesture:(UIImageView*) imageView{
    if ([imageView isKindOfClass:[UIImageView class]]) {
        imageView.userInteractionEnabled = YES;
        [self setGuestures: imageView];
        [self.view addSubview:imageView];
    }
}
#pragma mark - Swipes Methods

-(void)doHorisontalSwipe: (UIGestureRecognizer *) recognizer
{
    UIView* imageView = [recognizer view];
    infoLabel.text = @"Horisontal swipe detected";
    [self.view bringSubviewToFront:imageView];
    
    CGRect rect  = CGRectMake(imageView.frame.origin.x+10.0f, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    imageView.frame = rect;
    //CGAffineTransformTranslate
    [self performSelector:@selector(labelErase) withObject:nil afterDelay:2];
}

-(void)doVerticalSwipe: (UIGestureRecognizer *) recognizer{
    infoLabel.text = @"Vertical swipe detected";

    [self performSelector:@selector(labelErase) withObject:nil afterDelay:2];
}

#pragma mark - Pan

-(void)doPan: (UIPanGestureRecognizer *) recognizer{
    infoLabel.text = @"Pan!!!";
    [self.view bringSubviewToFront:[recognizer view]];
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    //Deceleration
//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        
//        CGPoint velocity = [recognizer velocityInView:self.view];
//        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
//        CGFloat slideMult = magnitude / 200;
//        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
//        
//        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
//        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
//                                         recognizer.view.center.y + (velocity.y * slideFactor));
//        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
//        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
//        
//        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            recognizer.view.center = finalPoint;
//        } completion:nil];
//        
//    }
}

#pragma mark - Rotate

-(void)doRotate: (UIRotationGestureRecognizer* ) recognizer{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
     [self.view bringSubviewToFront:[recognizer view]];
    self.infoLabel.text = @"Rotate!";
    [self performSelector:@selector(labelErase) withObject:nil afterDelay:1.6];
}

#pragma mark - Pinch

-(void)doPinch: (UIPinchGestureRecognizer* ) recognizer{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
     [self.view bringSubviewToFront:[recognizer view]];
    self.infoLabel.text = @"Pinch!";
    [self performSelector:@selector(labelErase) withObject:nil afterDelay:1.6];
}

#pragma mark - Check

-(void)doCheck: (CheckMarkRecognizer* ) recognizer{
    self.infoLabel.text = @"Check!";
   [self performSelector:@selector(labelErase) withObject:nil afterDelay:1.6];
    UIView* curView = [recognizer view];
     [curView bringSubviewToFront:[recognizer view]];
    if ([curView isKindOfClass:[UIImageView class]]) {
        UIImageView* originImageView = (UIImageView*)curView;
        UIImage* image = originImageView.image;
        CGRect originFrame = originImageView.frame;
        CGRect newFrame = CGRectMake(originFrame.origin.x + 5, originFrame.origin.y + 5, originFrame.size.width, originFrame.size.height);
        
        UIImageView *copyView = [[UIImageView alloc]initWithImage:image];
        copyView.frame = newFrame;
        
        [self.images addObject:copyView];
        [self initGesture:copyView];
       
        [copyView release];
    }
}

#pragma mark - Long Press

-(void)doLongPress: (UILongPressGestureRecognizer *) recognizer{
    self.infoLabel.text = @"Long press!!";
     [self.view bringSubviewToFront:[recognizer view]];
    [self performSelector:@selector(labelErase) withObject:nil afterDelay:1.6];
    UIView* curView = [recognizer view];
    if([self.images containsObject:curView] && self.images.count > 1)
    {
        [self.images removeObject:curView];
        [curView removeFromSuperview];
    }
    
}
@end
