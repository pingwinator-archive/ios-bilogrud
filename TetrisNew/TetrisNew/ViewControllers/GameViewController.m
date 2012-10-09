//
//  ViewController.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "GameViewController.h"
#import "BoardViewController.h"
#import "BoardView.h"
#import "BGView.h"
@interface GameViewController ()
@property (retain, nonatomic) BoardViewController* boardViewController;
@property (retain, nonatomic) BGView* backgroundView;
@property (retain, nonatomic) BoardView* nextShapeView;
@property (retain, nonatomic) UIButton* playButton;
@property (retain, nonatomic) UIButton* leftButton;
@property (retain, nonatomic) UIButton* downButton;
@property (retain, nonatomic) UIButton* rightButton;
@property (retain, nonatomic) UIButton* rotateButton;
@property (retain, nonatomic) UILabel* playLabel;
@property (retain, nonatomic) UILabel* leftLabel;
@property (retain, nonatomic) UILabel* downLabel;
@property (retain, nonatomic) UILabel* rightLabel;
@property (retain, nonatomic) UILabel* rotateLabel;
@property (assign, nonatomic) BOOL firstStart;
@property (retain, nonatomic) NSTimer* buttonTimer;
@property (retain, nonatomic) NSTimer* gameTimer;
@property (assign, nonatomic) CGRect boardRect;
- (void)addUIControls;
- (void)timerTick;
- (void)rotate;
//
- (void)moveRightPressed;
- (void)moveRightUnPressed;
- (void)moveLeftPressed;
- (void)moveLeftUnPressed;
- (void)moveDownPressed;
- (void)moveDownUnPressed;
@end

@implementation GameViewController
@synthesize boardViewController;
@synthesize backgroundView;
@synthesize nextShapeView;
@synthesize playButton;
@synthesize rightButton;
@synthesize downButton;
@synthesize leftButton;
@synthesize rotateButton;
@synthesize playLabel;
@synthesize leftLabel;
@synthesize downLabel;
@synthesize rightLabel;
@synthesize rotateLabel;
@synthesize isStart;
@synthesize gameTimer;
@synthesize firstStart;
@synthesize buttonTimer;
@synthesize boardRect;
- (void)dealloc
{
    self.boardViewController = nil;
    self.backgroundView = nil;
    self.nextShapeView = nil;
    self.playButton = nil;
    self.rightButton = nil;
    self.downButton = nil;
    self.leftButton = nil;
    self.rotateButton = nil;
    self.playLabel = nil;
    self.leftLabel = nil;
    self.downLabel = nil;
    self.rightLabel = nil;
    self.rotateLabel = nil;
    self.gameTimer = nil;
    self.buttonTimer = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstStart = YES;
    
    self.backgroundView = [[[BGView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:39.0f/255.0f green:64.0f/255.0f blue:139.0f/255.0f alpha:1]; 
    [self.view addSubview:self.backgroundView];
    
    //board
    if(isiPhone) {
        self.boardRect = CGRectMake(15, 15, 230, 342);
    } else {
        self.boardRect = CGRectMake(15, 15, 650, 850);
    }
    
    self.boardViewController = [[[BoardViewController alloc] initWithFrame:boardRect amountCellX:10 amountCellY:15] autorelease];
    [self.backgroundView addSubview:self.boardViewController.boardView];
	  //next shape View
    [self.backgroundView addSubview:self.boardViewController.nextShapeView];
    [self addUIControls];
}

- (void)addUIControls
{
    //play button
    CGRect rectPlayButton = CGRectMake(self.boardRect.size.width + 30, self.boardRect.origin.y, playSizeButton, playSizeButton);
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.frame = rectPlayButton;
    UIImage* im = [UIImage imageNamed:@"SmallYellow.png"];
    [self.playButton setImage:im forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    [self.playButton release];
    
    //play labe4
    CGRect rectPlayLabel = CGRectMake(rectPlayButton.origin.x , rectPlayButton.size.height + 20, labelMoveTextWidth - 5, labelMoveTextHeigth*2);
    self.playLabel = [[UILabel alloc] initWithFrame:rectPlayLabel];
    self.playLabel.text = @"PLAY/ PAUSE";
    self.playLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    self.playLabel.numberOfLines = 2;
    
    [self.playLabel setFont:textButtonFont];
    self.playLabel.backgroundColor=[UIColor clearColor];
    self.playLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.playLabel];
    [self.playLabel release];
    
    //left button
    CGRect manageButton = CGRectMake(self.boardRect.origin.x + 10, self.boardRect.size.height + 30, moveSizeButton, moveSizeButton);
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = manageButton;
    UIImage* image = [UIImage imageNamed:@"SmallYellow.png"];
    [self.leftButton setImage:image forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(moveLeftPressed) forControlEvents:UIControlEventTouchDown];
    [self.leftButton addTarget:self action:@selector(moveLeftUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    [self.leftButton release];
    
    //left label
    CGRect rectLeftLabel = CGRectMake(manageButton.origin.x , manageButton.origin.y + manageButton.size.height , labelMoveTextWidth, labelMoveTextHeigth);
    self.leftLabel = [[UILabel alloc] initWithFrame:rectLeftLabel];
    self.leftLabel.text = @"LEFT";
    [self.leftLabel setFont:textButtonFont];
    self.leftLabel.backgroundColor=[UIColor clearColor];
    self.leftLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.leftLabel];
    [self.leftLabel release];
    
    //down button
    manageButton.origin.x += 75;
    self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downButton.frame = manageButton;
    [self.downButton setImage:image forState:UIControlStateNormal];
    [self.downButton addTarget:self action:@selector(moveDownPressed) forControlEvents:UIControlEventTouchDown];
    [self.downButton addTarget:self action:@selector(moveDownUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downButton];
    [self.downButton release];
    
    //down label
    CGRect rectDownLabel = CGRectMake(manageButton.origin.x, manageButton.origin.y + manageButton.size.height, labelMoveTextWidth, labelMoveTextHeigth);
    self.downLabel = [[UILabel alloc] initWithFrame:rectDownLabel];
    self.downLabel.text = @"DOWN";
    [self.downLabel setFont:textButtonFont];
    self.downLabel.backgroundColor = [UIColor clearColor];
    self.downLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.downLabel];
    [self.downLabel release];
    
    //rotate button
    manageButton.origin.x += 75;
    self.rotateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rotateButton.frame = manageButton;
    [self.rotateButton setImage:image forState:UIControlStateNormal];
    [self.rotateButton addTarget:self action:@selector(rotate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rotateButton];
    [self.rotateButton release];
    
    //rotate label
    CGRect rectRotateLabel = CGRectMake(manageButton.origin.x, manageButton.size.height + manageButton.origin.y , labelMoveTextWidth, labelMoveTextHeigth);
    self.rotateLabel = [[UILabel alloc] initWithFrame:rectRotateLabel];
    self.rotateLabel.text = @"ROTATE";
    [self.rotateLabel setFont:textButtonFont];
    self.rotateLabel.backgroundColor=[UIColor clearColor];
    self.rotateLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.rotateLabel];
    [self.rotateLabel release];
    
    //right button
    manageButton.origin.x += 75;
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = manageButton;
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(moveRightUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(moveRightPressed) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.rightButton];
    [self.rightButton release];
    
    //right label
    CGRect rectRightLabel = CGRectMake(manageButton.origin.x, manageButton.size.height + manageButton.origin.y , labelMoveTextWidth, labelMoveTextHeigth);
    self.rightLabel = [[UILabel alloc] initWithFrame:rectRightLabel];
    self.rightLabel.text = @"RIGHT";
    [self.rightLabel setFont:textButtonFont];
    self.rightLabel.backgroundColor=[UIColor clearColor];
    self.rightLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.rightLabel];
    [self.rightLabel release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)play
{
    //timer start
    if(self.isStart) {
        self.isStart = NO;
        [self.gameTimer invalidate];
    } else {
        
        if(self.firstStart) {
           [self.boardViewController start];
            self.firstStart = NO;
        } 
        self.isStart = YES;
        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
        NSLog(@"play!");
    }
}

#pragma mark - Timer

- (void)startGameTimer
{
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
}

- (void)stopGameTimer
{
    [self.gameTimer invalidate];
}

- (void)timerTick
{
    if(self.boardViewController.gameOver) {
        [self.gameTimer invalidate];
    } else {
         [self.boardViewController moveShape:downDirectionMove];
    }
    [self.boardViewController.boardView setNeedsDisplay];
}

#pragma mark - Methods for TouchDown Timer

- (void)moveRightPressed
{
    [self.boardViewController moveShape:rightDirectionMove];
    [self performSelector:@selector(moveRightPressed) withObject:nil afterDelay:delayForButtonPressed];
}

- (void)moveRightUnPressed
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveRightPressed) object:nil];
}

- (void)moveLeftPressed
{
    [self.boardViewController moveShape:leftDirectionMove];
    [self performSelector:@selector(moveLeftPressed) withObject:nil afterDelay:delayForButtonPressed];
}

- (void)moveLeftUnPressed
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveLeftPressed) object:nil];
}

- (void)moveDownPressed
{
    [self.boardViewController moveShape:downDirectionMove];
    [self performSelector:@selector(moveDownPressed) withObject:nil afterDelay:delayForButtonPressed];
}

- (void)moveDownUnPressed
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveDownPressed) object:nil];
}

#pragma mark - Rotate shape

- (void)rotate
{
    [self.boardViewController rotateShape:rightDirectionRotate];
}
@end
