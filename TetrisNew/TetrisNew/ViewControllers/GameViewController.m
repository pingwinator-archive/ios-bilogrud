//
//  ViewController.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "GameViewController.h"
#import "SettingViewController.h"
#import "BoardView.h"
#import "BGView.h"
#import "UIViewController+Deprecated.h"
//#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface GameViewController ()
@property (retain, nonatomic) BoardViewController* boardViewController;
@property (retain, nonatomic) SettingViewController* settingViewController;
@property (retain, nonatomic) BoardView* nextShapeView;
@property (retain, nonatomic) UIButton* settingButton;
@property (retain, nonatomic) UIButton* playButton;
@property (retain, nonatomic) UIButton* resetButton;
@property (retain, nonatomic) UIButton* leftButton;
@property (retain, nonatomic) UIButton* downButton;
@property (retain, nonatomic) UIButton* rightButton;
@property (retain, nonatomic) UIButton* rotateButton;
@property (retain, nonatomic) UIButton* soundButton;
@property (retain, nonatomic) UILabel* playLabel;
@property (retain, nonatomic) UILabel* leftLabel;
@property (retain, nonatomic) UILabel* downLabel;
@property (retain, nonatomic) UILabel* rightLabel;
@property (retain, nonatomic) UILabel* rotateLabel;
@property (retain, nonatomic) UILabel* lineLabel;
@property (retain, nonatomic) UILabel* resetLabel;
@property (retain, nonatomic) UILabel* soundLabel;
@property (retain, nonatomic) NSTimer* buttonTimer;
@property (assign, nonatomic) BOOL firstStart;
@property (assign, nonatomic) CGRect boardRect;
@property (assign, nonatomic) BOOL settingIsVisible;
@property (retain, nonatomic) BGView* bgView;
@property (retain, nonatomic) AVAudioPlayer* avSound;
- (void)addUIControlsForPhone;

- (void)rotate;
//motion
- (void)moveRightPressed;
- (void)moveRightUnPressed;
- (void)moveLeftPressed;
- (void)moveLeftUnPressed;
- (void)moveDownPressed;
- (void)moveDownUnPressed;
@end

@implementation GameViewController
@synthesize boardViewController;
@synthesize nextShapeView;
@synthesize playButton;
@synthesize rightButton;
@synthesize downButton;
@synthesize leftButton;
@synthesize resetButton;
@synthesize rotateButton;
@synthesize soundButton;
@synthesize playLabel;
@synthesize leftLabel;
@synthesize downLabel;
@synthesize rightLabel;
@synthesize rotateLabel;
@synthesize resetLabel;
@synthesize lineLabel;
@synthesize soundLabel;
@synthesize isStart;
@synthesize firstStart;
@synthesize buttonTimer;
@synthesize boardRect;
@synthesize settingButton;
@synthesize settingIsVisible;
@synthesize settingViewController;
@synthesize bgView;
@synthesize avSound;
- (void)dealloc
{
    self.boardViewController = nil;
    self.nextShapeView = nil;
    self.playButton = nil;
    self.rightButton = nil;
    self.downButton = nil;
    self.leftButton = nil;
    self.resetButton = nil;
    self.rotateButton = nil;
    self.settingButton = nil;
    self.soundButton = nil;
    self.playLabel = nil;
    self.leftLabel = nil;
    self.downLabel = nil;
    self.rightLabel = nil;
    self.rotateLabel = nil;
    self.soundLabel = nil;
    self.buttonTimer = nil;
    self.settingViewController = nil;
    self.lineLabel = nil;
    self.resetLabel = nil;
    self.bgView = nil;
    self.avSound = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.boardViewController showGrid: [SettingViewController loadSettingGrid]];
    [self.boardViewController.boardView setNeedsDisplay];
    [self.boardViewController.nextShapeView setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstStart = YES;
    self.settingIsVisible = NO;
  
    //board
    if(isiPhone) {
        self.bgView = [[[BGView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
        [self.view addSubview:self.bgView];
    
        self.boardRect = CGRectMake(15, 15, 230, 342);
        self.boardViewController = [[[BoardViewController alloc] initWithFrame:boardRect amountCellX:10 amountCellY:15] autorelease];
        [self.bgView addSubview:self.boardViewController.boardView];
        //next shape View
        [self.bgView addSubview:self.boardViewController.nextShapeView];
        [self addUIControlsForPhone];
    } else {
        self.bgView = [[[BGView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
        [self.view addSubview:self.bgView];
        
        self.boardRect = CGRectMake(215, 130, 230, 342);
        self.boardViewController = [[[BoardViewController alloc] initWithFrame:boardRect amountCellX:10 amountCellY:15] autorelease];
        
        [self.bgView addSubview:self.boardViewController.boardView];
        //next shape View
        [self.bgView addSubview:self.boardViewController.nextShapeView];
        [self addUIControlsForiPad];
    }
}


- (void)addUIControlsForiPad
{
    UIImage* imageButton = [UIImage imageNamed:@"SmallYellow.png"];
    UIImage* settingImage = [UIImage imageNamed:@"Setting.png"];
    //setting button
    [self addSettingButton:CGRectMake(self.boardRect.origin.x + self.boardRect.size.width + 70, self.bgView.frame.size.height - 130 , settingSizeButton, settingSizeButton) withImage:settingImage];
    //play button
    [self addPlayButton:CGRectMake(self.boardRect.origin.x + 20, self.boardRect.size.height + self.boardRect.origin.y + 70, manageSizeButton, manageSizeButton) withImage:imageButton];
    //reset button
    [self addResetButton:CGRectMake(self.boardRect.origin.x + 150, self.boardRect.size.height + self.boardRect.origin.y + 70 , manageSizeButton, manageSizeButton) withImage:imageButton];
    //sound button
    [self addSoundButton:CGRectMake(self.boardRect.origin.x + 280, self.boardRect.size.height + self.boardRect.origin.y + 70 , manageSizeButton, manageSizeButton) withImage:imageButton];
    //score label
    [self addScoreLabel:CGRectMake(boardRect.origin.x + boardRect.size.width + 30, boardRect.origin.y + boardRect.size.height - 70, labelScoreWidth , labelScoreHeigth)];
    
    CGRect rectMove = CGRectMake(self.boardRect.origin.x, self.boardRect.origin.y + self.boardRect.size.height + 200, moveSizeButton, moveSizeButton);
    //left button
    [self addLeftMoveButton:rectMove withImage:imageButton];
    //down button
    [self addDownMoveButton:CGRectMake(rectMove.origin.x + 50, rectMove.origin.y + 70, moveSizeButton, moveSizeButton) withImage:imageButton];
    //right button
    [self addRightMoveButton:CGRectMake(rectMove.origin.x + 100, rectMove.origin.y, moveSizeButton, moveSizeButton) withImage:imageButton];
    //rotate button
    [self addRotateButton:CGRectMake(rectMove.origin.x + 250, rectMove.origin.y, rotateSizeButton, rotateSizeButton) withImage:imageButton];
}

- (void)addUIControlsForPhone
{
    UIImage* imageButton = [UIImage imageNamed:@"SmallYellow.png"];
    UIImage* settingImage = [UIImage imageNamed:@"Setting.png"];
    //setting button
    [self addSettingButton:CGRectMake(self.boardRect.size.width + 30, self.boardRect.origin.y + 10, settingSizeButton, settingSizeButton) withImage:settingImage];
    //play button
    [self addPlayButton:CGRectMake(self.boardRect.size.width + 30, self.boardRect.origin.y + 70, manageSizeButton, manageSizeButton) withImage:imageButton];

    //score label
    [self addScoreLabel:CGRectMake(260, 150, scoreLabelWidth, scoreLabelHeigth)];

    //left button
    [self addLeftMoveButton:CGRectMake(self.boardRect.origin.x + 10, self.boardRect.size.height + 30, moveSizeButton, moveSizeButton) withImage:imageButton];

    //down button
    [self addDownMoveButton:CGRectMake(self.boardRect.origin.x + 85, self.boardRect.size.height + 30, moveSizeButton, moveSizeButton) withImage:imageButton];
    
    //rotate button
    [self addRotateButton:CGRectMake(self.boardRect.origin.x + 160, self.boardRect.size.height + 30, moveSizeButton, moveSizeButton) withImage:imageButton];
    
    //right button
    [self addRightMoveButton:CGRectMake(self.boardRect.origin.x + 235, self.boardRect.size.height + 30, moveSizeButton, moveSizeButton) withImage:imageButton];
}


#pragma mark - Init components

- (void)addPlayButton:(CGRect)rect withImage:(UIImage*)imageButton
{
    //play button
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.frame = rect;
    [self.playButton setImage:imageButton forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    
    //play label
    CGRect rectPlayLabel = CGRectMake(rect.origin.x , rect.origin.y + 25, labelPlayTextWidth , labelPlayTextHeigth);
    self.playLabel = [[[UILabel alloc] initWithFrame:rectPlayLabel] autorelease];
    self.playLabel.text = NSLocalizedString( @"PLAY/ PAUSE", @"");
    self.playLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.playLabel.numberOfLines = 2;
    [self.playLabel setFont:textButtonFont];
    self.playLabel.backgroundColor=[UIColor clearColor];
    self.playLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.playLabel];
}

- (void)addResetButton:(CGRect)rect withImage:(UIImage*)imageButton
{
    //reset button
  //  CGRect rectResetButton = CGRectMake(rectPlayButton.origin.x + 120, rectPlayButton.origin.y , manageSizeButton, manageSizeButton);
    self.resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resetButton.frame = rect;
    [self.resetButton setImage:imageButton forState:UIControlStateNormal];
    [self.resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resetButton];
    
    //reset label
    CGRect rectResetLabel = CGRectMake(rect.origin.x - 3 , rect.origin.y + rect.size.height + 5, labelMoveTextWidth, labelMoveTextHeigth);
    self.resetLabel = [[[UILabel alloc] initWithFrame:rectResetLabel] autorelease];
    self.resetLabel.text = NSLocalizedString(@"RESET", @"");
    self.resetLabel.textAlignment = UITextAlignmentCenter;
    [self.resetLabel setFont:textButtonFont];
    self.resetLabel.backgroundColor=[UIColor clearColor];
    self.resetLabel.textColor = [UIColor whiteColor];
    // self.playLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.resetLabel];
}

- (void)addSoundButton:(CGRect)rect withImage:(UIImage*)imageButton
{
    CGRect rectSoundButton = CGRectMake(rect.origin.x , rect.origin.y , manageSizeButton, manageSizeButton);
    self.soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.soundButton.frame = rectSoundButton;
    [self.soundButton setImage:imageButton forState:UIControlStateNormal];
    [self.soundButton addTarget:self action:@selector(sound) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.soundButton];
    
    //sound label
    CGRect rectSoundLabel = CGRectMake(rect.origin.x - 5, rect.origin.y + rect.size.height, 50, labelMoveTextHeigth);
    self.soundLabel = [[[UILabel alloc] initWithFrame:rectSoundLabel] autorelease];
    self.soundLabel.text = NSLocalizedString(@"SOUND", @"");
    self.soundLabel.textAlignment = UITextAlignmentCenter;
    [self.soundLabel setFont:textButtonFont];
    self.soundLabel.backgroundColor=[UIColor clearColor];
    self.soundLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.soundLabel];

}
- (void)addSettingButton:(CGRect)rect withImage:(UIImage*)imageButton
{
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingButton.frame = rect;
    UIImage* settingImage = [UIImage imageNamed:@"Setting.png"];
    [self.settingButton setImage:settingImage forState:UIControlStateNormal];
    [self.settingButton addTarget:self action:@selector(showSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingButton];
}

- (void)addScoreLabel:(CGRect)rect
{
    self.lineLabel = [[[UILabel alloc] initWithFrame:rect] autorelease];
    self.lineLabel.text = [NSString stringWithFormat:@"%d", self.boardViewController.lines];
    self.lineLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.lineLabel.numberOfLines = 2;
    [self.lineLabel setFont:scoreFont];
    self.lineLabel.backgroundColor=[UIColor clearColor];
    self.lineLabel.textColor = [UIColor whiteColor];
    self.lineLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.lineLabel];
}

- (void)addLeftMoveButton:(CGRect)rect withImage:(UIImage*)imageButton
{
    //left button
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = rect;
    [self.leftButton setImage:imageButton forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(moveLeftPressed) forControlEvents:UIControlEventTouchDown];
    [self.leftButton addTarget:self action:@selector(moveLeftUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    
    
    //left label
    CGRect rectLeftLabel = CGRectMake(rect.origin.x , rect.origin.y + rect.size.height , labelMoveTextWidth, labelMoveTextHeigth);
    self.leftLabel = [[[UILabel alloc] initWithFrame:rectLeftLabel] autorelease];
    self.leftLabel.text = NSLocalizedString(@"LEFT", @"");
    [self.leftLabel setFont:textButtonFont];
    self.leftLabel.backgroundColor=[UIColor clearColor];
    self.leftLabel.textColor = [UIColor whiteColor];
    self.leftLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.leftLabel];

}

- (void)addRightMoveButton:(CGRect)rect withImage:(UIImage*)imageButton
{
    //right button
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = rect;
    [self.rightButton setImage:imageButton forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(moveRightUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(moveRightPressed) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.rightButton];
    
    //right label
    CGRect rectRightLabel = CGRectMake(rect.origin.x, rect.size.height + rect.origin.y , labelMoveTextWidth, labelMoveTextHeigth);
    self.rightLabel = [[[UILabel alloc] initWithFrame:rectRightLabel] autorelease];
    self.rightLabel.text = NSLocalizedString(@"RIGHT", @"");
    [self.rightLabel setFont:textButtonFont];
    self.rightLabel.backgroundColor=[UIColor clearColor];
    self.rightLabel.textColor = [UIColor whiteColor];
    self.rightLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.rightLabel];

}

- (void)addDownMoveButton:(CGRect)rect withImage:(UIImage*)imageButton
{
    self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downButton.frame = rect;
    [self.downButton setImage:imageButton forState:UIControlStateNormal];
    [self.downButton addTarget:self action:@selector(moveDownPressed) forControlEvents:UIControlEventTouchDown];
    [self.downButton addTarget:self action:@selector(moveDownUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downButton];
    
    
    //down label
    CGRect rectDownLabel = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, labelMoveTextWidth, labelMoveTextHeigth);
    self.downLabel = [[[UILabel alloc] initWithFrame:rectDownLabel]autorelease];
    self.downLabel.text = NSLocalizedString(@"DOWN", @"");
    [self.downLabel setFont:textButtonFont];
    self.downLabel.backgroundColor = [UIColor clearColor];
    self.downLabel.textColor = [UIColor whiteColor];
    self.downLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.downLabel];
}

- (void)addRotateButton:(CGRect)rect withImage:(UIImage*)imageButton
{
    self.rotateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rotateButton.frame = rect;
    [self.rotateButton setImage:imageButton forState:UIControlStateNormal];
    [self.rotateButton addTarget:self action:@selector(rotate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rotateButton];
    
    //rotate label
    CGRect rectRotateLabel = CGRectMake(rect.origin.x + 5, rect.size.height + rect.origin.y , labelMoveTextWidth + 10, labelMoveTextHeigth);
    self.rotateLabel = [[[UILabel alloc] initWithFrame:rectRotateLabel] autorelease];
    self.rotateLabel.text = NSLocalizedString(@"ROTATE", @"");
    [self.rotateLabel setFont:textButtonFont];
    self.rotateLabel.backgroundColor=[UIColor clearColor];
    self.rotateLabel.textColor = [UIColor whiteColor];
    self.rotateLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.rotateLabel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSetting
{
   // self.settingIsVisible = YES;
    SettingViewController* settingViewController1 = [[[SettingViewController alloc] init] autorelease];
    [self deprecatedPresentModalViewController:settingViewController1 animated:YES];
    //presentModalViewController:settingViewController animated:YES];
}

- (void)play
{
    //timer start
    if(self.isStart) {
        self.isStart = NO;
        [self.boardViewController.gameTimer invalidate];
    } else {
        if(self.firstStart) {
           [self.boardViewController start];
            self.firstStart = NO;
            self.boardViewController.delegate = self;
            self.boardViewController.resetGameDelegate = self;
        } 
        self.isStart = YES;
        [self.boardViewController startGameTimer];
        DBLog(@"play!");
    }
}

- (void)reset
{
    [self.boardViewController resetBoard];
    self.firstStart = YES;
    self.isStart = NO;
    [self play];
}

- (void)sound
{
    if(self.isStart) {
        if ([self.avSound isPlaying]) {
            [self.avSound stop];
            self.avSound = nil;
        } else {
            NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"Tetris" withExtension:@"mp3"];
            NSError* err = nil;
            self.avSound = [[[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&err] autorelease];
            if(!err){
                [self.avSound play];
            }
        }
    }
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

#pragma mark - Timer 

- (void)resumptionGameTimer
{
    [self.boardViewController startGameTimer];
}

- (void)pauseGameTimer
{
    [self.boardViewController stopGameTimer];
}

#pragma mark - DeleteLineDelegate Methods

- (void)deleteLine:(NSInteger)amount
{
    self.lineLabel.text = [NSString stringWithFormat:@"%d", self.boardViewController.lines];
}

#pragma mark - GameOverDelegate Methods

- (void)newGame
{
    [self reset];
}
@end
