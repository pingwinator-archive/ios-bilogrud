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
#import "BGViewBorder.h"
#import "UIApplication+CheckVersion.h"
#import "UIPopoverManager.h"
#import "TutorialView.h"
#import <AVFoundation/AVFoundation.h>


typedef enum {
    TutorialStepStart = 0,
    TutorialStepLeft,
    TutorialStepRight,
    TutorialStepDown,
    TutorialStepRotate,
    TutorialStepCount
} TutorialSteps;

@interface GameViewController ()<AVAudioPlayerDelegate>
@property (retain, nonatomic) BoardViewController* boardViewController;
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
@property (retain, nonatomic) UILabel* settingLabel;
@property (retain, nonatomic) BGView* bgView;
@property (retain, nonatomic) AVAudioPlayer* avSound;

@property (assign, nonatomic) BOOL firstStart;
@property (assign, nonatomic) CGRect boardRect;
@property (assign, nonatomic) BOOL settingIsVisible;

@property (retain, nonatomic) UIImageView* pauseImageView;
@property (retain, nonatomic) UIImageView* soundImageView;
//for tutorial
@property (retain, nonatomic) NSArray* arrayTextforTutorial;
@property (retain, nonatomic) NSArray* arrayButtonsForTutorial;
@property (assign, nonatomic) BOOL showTutorial;
@property (assign, nonatomic) TutorialSteps currentTutorialStep;
@property (retain, nonatomic) TutorialView* tutorialView;

- (void)addGameHint;
- (void)addUIControlsForPhone;
- (void)addUIControlsForLargePhone;
- (void)rotateUnPressed;
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
@synthesize settingLabel;
@synthesize isStart;
@synthesize firstStart;
@synthesize boardRect;
@synthesize settingButton;
@synthesize settingIsVisible;

@synthesize bgView;
@synthesize avSound;

@synthesize pauseImageView;
@synthesize soundImageView;

@synthesize arrayTextforTutorial;
@synthesize arrayButtonsForTutorial;
@synthesize currentTutorialStep;
@synthesize showTutorial;
@synthesize tutorialView;

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
    self.settingLabel = nil;
    self.rightLabel = nil;
    self.rotateLabel = nil;
    self.soundLabel = nil;
    self.lineLabel = nil;
    self.resetLabel = nil;
    self.bgView = nil;
    self.avSound = nil;
    self.soundImageView = nil;
    self.pauseImageView = nil;
    self.arrayButtonsForTutorial = nil;
    self.arrayTextforTutorial = nil;
    self.tutorialView = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if(self.isStart) {
        [self continueGame];
    }
    [self.boardViewController showGrid: [SettingViewController loadSettingGrid]];
    [self.boardViewController showColor: [SettingViewController loadSettingColor]];
    [self.boardViewController.boardView setNeedsDisplay];
    [self.boardViewController.nextShapeView setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    BOOL res = NO;
    if (isiPad) {
        if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
            res = YES;
        }
    } else {
         if(toInterfaceOrientation == UIInterfaceOrientationPortrait) {
             res = YES;
         }
    }
    return res;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
     NSLog(@"%f %f",self.view.frame.size.width, self.view.frame.size.height);
}

- (NSUInteger)supportedInterfaceOrientations
{
    NSUInteger iOr;
    if(isiPad) {
        iOr = UIInterfaceOrientationMaskAll;
    } else {
        iOr = UIInterfaceOrientationMaskPortrait;
    }
    return iOr;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    DBLog(@" preferred called");
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstStart = YES;
    self.settingIsVisible = NO;
    self.gameCount = 0;
    self.bgView = [[[BGView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)] autorelease];
    self.bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:self.bgView];
    
    if(isiPhone) {
        if([[UIApplication sharedApplication] has4inchDisplay]) {
            self.boardRect = CGRectMake(61, 22, 139, 270);
            self.boardViewController = [[[BoardViewController alloc] initWithFrame:boardRect amountCellX:10 amountCellY:18] autorelease];
           
            [self.bgView addSubview:self.boardViewController.boardView];
            [self.bgView addSubview:self.boardViewController.nextShapeView];
            [self addUIControlsForLargePhone];
        } else {
            self.boardRect = CGRectMake(61, 22, 139, 270);
            self.boardViewController = [[[BoardViewController alloc] initWithFrame:boardRect amountCellX:10 amountCellY:18] autorelease];
             
            [self.bgView addSubview:self.boardViewController.boardView];
            [self.bgView addSubview:self.boardViewController.nextShapeView];
            [self addUIControlsForPhone];
        }
    } else {
        //iPad
        self.boardRect = CGRectMake(146, 52, 333, 637);
        self.boardViewController = [[[BoardViewController alloc] initWithFrame:boardRect amountCellX:10 amountCellY:18 ] autorelease];
        self.boardViewController.boardView.backgroundColor = [UIColor clearColor];
        [self.bgView addSubview:self.boardViewController.boardView];
        [self.bgView addSubview:self.boardViewController.nextShapeView];
       
        [self addUIControlsForiPad];
    }
    self.showTutorial = [SettingViewController loadSettingTutorial];//from settings
    
    if (self.showTutorial) {
        self.arrayTextforTutorial = [NSArray arrayWithObjects:
                                     NSLocalizedString(@"Tap here to start game", @""),
                                     NSLocalizedString(@"Tap here to move left", @""),
                                     NSLocalizedString(@"Tap here to move right", @""),
                                     NSLocalizedString(@"Tap here to move down", @""),
                                     NSLocalizedString(@"Tap here to rotate shape", @""),
                                     nil];
        self.arrayButtonsForTutorial = [NSArray arrayWithObjects:
                                        self.playButton,
                                        self.leftButton,
                                        self.rightButton,
                                        self.downButton,
                                        self.rotateButton,
                                        nil];
        self.currentTutorialStep = TutorialStepStart;
    }
   
    [self performSelector:@selector(addGameHint) withObject:nil afterDelay:1.f];
}

#pragma mark - Tutorial Methods 

- (void)addGameHint
{
    if(self.showTutorial) {
        NSString* hintText = [self.arrayTextforTutorial objectAtIndex:self.currentTutorialStep];
        UIButton* hintButton = [self.arrayButtonsForTutorial objectAtIndex:self.currentTutorialStep];
        CGRect targetFrame = hintButton.frame;
        self.tutorialView = [[[TutorialView alloc] initWithFrame:self.view.bounds withText:hintText andTargetFrame:targetFrame] autorelease];
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideGameHint)];
        [self.tutorialView addGestureRecognizer:tapGesture];
        [tapGesture release];
        self.tutorialView.alpha = 0;
        [self.view addSubview:self.tutorialView];
        [UIView animateWithDuration:0.3f animations:^(void) {
            self.tutorialView.alpha = 1;
        }];
        [self.view bringSubviewToFront:self.tutorialView];
        [self.view bringSubviewToFront:hintButton];
        [self pauseGame];
    }
}

- (void)hideGameHint
{
    [UIView animateWithDuration:0.3f animations:^(void){
        self.tutorialView.alpha = 0.f;
    }
        completion:^(BOOL finished){
             [self.tutorialView removeFromSuperview];
             self.tutorialView = nil;
             self.currentTutorialStep++;
             if (self.currentTutorialStep < TutorialStepCount) {
                 [self performSelector:@selector(addGameHint) withObject:nil afterDelay:1.f];
             }
             if(self.isStart) {
                 [self continueGame];
             }
    }];    
}

#pragma mark - init UI

- (void)addUIControlsForLargePhone
{
    UIImage* imageButton = [UIImage imageNamed:@"button_up.png"];
    UIImage* highlightedImage = [UIImage imageNamed:@"button.png"];
    UIImage* rotateButtonImage = [UIImage imageNamed:@"rotatebutton_up.png"];
    UIImage* highlightedImageRotate = [UIImage imageNamed:@"rotatebutton.png"];
    //pauseImage
    self.pauseImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.boardRect.origin.x + self.boardRect.size.width + imageOffsetHeight, 250, 40, 40)] autorelease];
    [self.pauseImageView setImage:[UIImage imageNamed:@"pause.png"]];
    self.pauseImageView.hidden = YES;
    [self.view addSubview:self.pauseImageView];
    
    //soundImage
    self.soundImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.boardRect.origin.x + self.boardRect.size.width + imageOffsetHeight, 200, 25, 25)] autorelease];
    [self.soundImageView setImage:[UIImage imageNamed:@"music.png"]];
    self.soundImageView.hidden = YES;
    [self.view addSubview:self.soundImageView];

    CGRect rectManage = CGRectMake(50, self.boardRect.size.height + 60, 100, 20);
    
    //play button
    [self addPlayButton:CGRectMake(rectManage.origin.x , rectManage.origin.y, manageSizeButton, manageSizeButton) withImage:imageButton andHighlighted:highlightedImage onView:self.view];
    
    //reset button
    [self addResetButton:CGRectMake(rectManage.origin.x + 60, rectManage.origin.y , manageSizeButton, manageSizeButton) withImage:imageButton onView:self.view];
    
    //sound button
    [self addSoundButton:CGRectMake(rectManage.origin.x + 120, rectManage.origin.y , manageSizeButton, manageSizeButton) withImage:imageButton onView:self.view];
    
    //setting button
    [self addSettingButton:CGRectMake(rectManage.origin.x + 180, rectManage.origin.y , manageSizeButton, manageSizeButton) withImage:imageButton onView:self.view];
    
    //rotate button
    [self addRotateButton:CGRectMake(rectManage.origin.x + 170, rectManage.origin.y + 90, rotateSizeButton, rotateSizeButton) withImage:rotateButtonImage andHighlighted:highlightedImageRotate onView:self.view];
    
    CGRect rectMove = CGRectMake(30, self.boardRect.size.height + 150, 100, 20);
    
    //left button
    [self addLeftMoveButton:CGRectMake(rectMove.origin.x, rectMove.origin.y, moveSizeButton, moveSizeButton) withImage:imageButton onView:self.view];
    
    //down button
    [self addDownMoveButton:CGRectMake(rectMove.origin.x + 40, rectMove.origin.y + 40, moveSizeButton, moveSizeButton) withImage:imageButton onView:self.view];
    
    //right button
    [self addRightMoveButton:CGRectMake(rectMove.origin.x + 80, rectMove.origin.y, moveSizeButton, moveSizeButton) withImage:imageButton onView:self.view];
}

- (void)addUIControlsForPhone
{ 
    UIImage* imageButton = [UIImage imageNamed:@"button_up.png"];
    UIImage* highlightedImage = [UIImage imageNamed:@"button.png"];
    UIImage* rotateButtonImage = [UIImage imageNamed:@"rotatebutton_up.png"];
    UIImage* highlightedImageRotate = [UIImage imageNamed:@"rotatebutton.png"];
    
    //pauseImage
    self.pauseImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.boardRect.origin.x + self.boardRect.size.width + imageOffsetHeight, 250, 40, 40)] autorelease];
    [self.pauseImageView setImage:[UIImage imageNamed:@"pause.png"]];
    self.pauseImageView.hidden = YES;
    [self.view addSubview:self.pauseImageView];
    
    //soundImage
    self.soundImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.boardRect.origin.x + self.boardRect.size.width + imageOffsetHeight, 200, 25, 25)] autorelease];
    [self.soundImageView setImage:[UIImage imageNamed:@"music.png"]];
    self.soundImageView.hidden = YES;
    [self.view addSubview:self.soundImageView];
 
    CGRect rectManage = CGRectMake(50, self.boardRect.size.height + 40, 100, 20);
    //play button
    [self addPlayButton:CGRectMake(rectManage.origin.x , rectManage.origin.y, manageSizeButton, manageSizeButton) withImage:imageButton andHighlighted:highlightedImage onView:self.view];
    
    //reset button
    [self addResetButton:CGRectMake(rectManage.origin.x + 60, rectManage.origin.y , manageSizeButton, manageSizeButton) withImage:imageButton onView:self.view];
    
    //sound button
    [self addSoundButton:CGRectMake(rectManage.origin.x + 120, rectManage.origin.y , manageSizeButton, manageSizeButton) withImage:imageButton onView:self.view];

    //setting button
    [self addSettingButton:CGRectMake(rectManage.origin.x + 180, rectManage.origin.y , manageSizeButton, manageSizeButton) withImage:imageButton onView:self.view];
    
    //rotate button
    [self addRotateButton:CGRectMake(rectManage.origin.x + 170, rectManage.origin.y + 65, rotateSizeButton, rotateSizeButton) withImage:rotateButtonImage andHighlighted:highlightedImageRotate onView:self.view];
  
    CGRect rectMove = CGRectMake(30, self.boardRect.size.height + 103, 100, 20);
    
    //left button
    [self addLeftMoveButton:CGRectMake(rectMove.origin.x, rectMove.origin.y, moveSizeButton, moveSizeButton) withImage:imageButton onView:self.view];

    //down button
    [self addDownMoveButton:CGRectMake(rectMove.origin.x + 40, rectMove.origin.y + 40, moveSizeButton, moveSizeButton) withImage:imageButton onView:self.view];
    
    //right button
    [self addRightMoveButton:CGRectMake(rectMove.origin.x + 80, rectMove.origin.y, moveSizeButton, moveSizeButton) withImage:imageButton onView:self.view];
}

- (void)addUIControlsForiPad
{
    UIImage* imageButton = [UIImage imageNamed:@"button_up.png"];
    UIImage* highlightedImage = [UIImage imageNamed:@"button.png"];
    UIImage* rotateButtonImage = [UIImage imageNamed:@"rotatebutton_up.png"];
    UIImage* highlightedImageRotate = [UIImage imageNamed:@"rotatebutton.png"];
    //pauseImage
    self.pauseImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.boardRect.origin.x + self.boardRect.size.width + imageOffsetHeightiPad, 600, 100, 100)] autorelease];
    [self.pauseImageView setImage:[UIImage imageNamed:@"pause.png"]];
    self.pauseImageView.hidden = YES;
    [self.view addSubview:self.pauseImageView];
    
    //soundImage
    self.soundImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.boardRect.origin.x + self.boardRect.size.width + imageOffsetHeightiPad*2, 550, 50, 50)] autorelease];
    [self.soundImageView setImage:[UIImage imageNamed:@"music.png"]];
    self.soundImageView.hidden = YES;
    [self.view addSubview:self.soundImageView];

    CGRect rectManage = CGRectMake(205, self.boardRect.size.height + 120, 100, 20);
    //play button
    [self addPlayButton:CGRectMake(rectManage.origin.x , rectManage.origin.y, manageSizeButtoniPad, manageSizeButtoniPad) withImage:imageButton andHighlighted:highlightedImage onView:self.view];
    
    //reset button
    [self addResetButton:CGRectMake(rectManage.origin.x + 100, rectManage.origin.y , manageSizeButtoniPad, manageSizeButtoniPad) withImage:imageButton onView:self.view];
    
    //sound button
    [self addSoundButton:CGRectMake(rectManage.origin.x + 200, rectManage.origin.y , manageSizeButtoniPad, manageSizeButtoniPad) withImage:imageButton onView:self.view];
    
    //setting button
    [self addSettingButton:CGRectMake(rectManage.origin.x + 300, rectManage.origin.y , manageSizeButtoniPad, manageSizeButtoniPad) withImage:imageButton onView:self.view];
    
    //rotate button
    [self addRotateButton:CGRectMake(rectManage.origin.x + 300, rectManage.origin.y + 100, rotateSizeButtoniPad, rotateSizeButtoniPad) withImage:rotateButtonImage andHighlighted:highlightedImageRotate onView:self.view];

    CGRect rectMove = CGRectMake(150, self.boardRect.size.height + 220, 100, 20);
    
    //left button
    [self addLeftMoveButton:CGRectMake(rectMove.origin.x, rectMove.origin.y, moveSizeButtoniPad, moveSizeButtoniPad) withImage:imageButton onView:self.view];
    
    //down button
    [self addDownMoveButton:CGRectMake(rectMove.origin.x + 60, rectMove.origin.y + 50, moveSizeButtoniPad, moveSizeButtoniPad) withImage:imageButton onView:self.view];
    
    //right button
    [self addRightMoveButton:CGRectMake(rectMove.origin.x + 120, rectMove.origin.y, moveSizeButtoniPad, moveSizeButtoniPad) withImage:imageButton onView:self.view];
}

#pragma mark - Init components

- (void)addPlayButton:(CGRect)rect withImage:(UIImage*)imageButton andHighlighted:(UIImage*)highlightedImage onView:(UIView*)view
{
    //play button
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.frame = rect;
    [self.playButton setImage:imageButton forState:UIControlStateNormal];
    [self.playButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.playButton];
    
    //play label
    CGRect rectPlayLabel = CGRectMake(CGRectGetMidX(rect) - labelPlayTextWidth/2 , rect.origin.y + rect.size.height - labelOffsetHeight, labelPlayTextWidth , labelPlayTextHeigth);
    self.playLabel = [[[UILabel alloc] initWithFrame:rectPlayLabel] autorelease];
    self.playLabel.text = NSLocalizedString( @"PLAY/ PAUSE", @"");
    self.playLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.playLabel.numberOfLines = 2;
    [self.playLabel setFont:textButtonFont];
    self.playLabel.backgroundColor=[UIColor clearColor];
    self.playLabel.textColor = [UIColor blackColor];
    [view addSubview:self.playLabel];
}

- (void)addResetButton:(CGRect)rect withImage:(UIImage*)imageButton onView:(UIView*)view
{
    //reset button
    self.resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resetButton.frame = rect;
    [self.resetButton setImage:imageButton forState:UIControlStateNormal];
    [self.resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.resetButton];
    
    //reset label
    CGRect rectResetLabel = CGRectMake(CGRectGetMidX(rect) - labelManageTextWidth/2 , rect.origin.y + rect.size.height - labelOffsetHeight, labelManageTextWidth, labelTextHeigth);
    self.resetLabel = [[[UILabel alloc] initWithFrame:rectResetLabel] autorelease];
    self.resetLabel.text = NSLocalizedString(@"RESET", @"");
    self.resetLabel.textAlignment = UITextAlignmentCenter;
    [self.resetLabel setFont:textButtonFont];
    self.resetLabel.backgroundColor=[UIColor clearColor];
    self.resetLabel.textColor = [UIColor blackColor];
    [view addSubview:self.resetLabel];
}

- (void)addSoundButton:(CGRect)rect withImage:(UIImage*)imageButton onView:(UIView*)view
{
    self.soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.soundButton.frame = rect;
    [self.soundButton setImage:imageButton forState:UIControlStateNormal];
    [self.soundButton addTarget:self action:@selector(sound) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.soundButton];
    
    //sound label
    CGRect rectSoundLabel = CGRectMake(CGRectGetMidX(rect) - labelManageTextWidth/2, rect.origin.y + rect.size.height - labelOffsetHeight, labelManageTextWidth, labelTextHeigth);
    self.soundLabel = [[[UILabel alloc] initWithFrame:rectSoundLabel] autorelease];
    self.soundLabel.text = NSLocalizedString(@"SOUND", @"");
    self.soundLabel.textAlignment = NSTextAlignmentCenter;
    [self.soundLabel setFont:textButtonFont];
    self.soundLabel.backgroundColor = [UIColor clearColor];
    self.soundLabel.textColor = [UIColor blackColor];
    [view addSubview:self.soundLabel];

}
- (void)addSettingButton:(CGRect)rect withImage:(UIImage*)imageButton onView:(UIView*)view
{
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingButton.frame = rect;
    [self.settingButton setImage:imageButton forState:UIControlStateNormal];
    [self.settingButton addTarget:self action:@selector(showSetting) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.settingButton];
    
    //ssetting label 
    CGRect rectSetLabel = CGRectMake(CGRectGetMidX(rect) - labelManageTextWidth/2, rect.origin.y + rect.size.height - labelOffsetHeight, labelManageTextWidth, labelTextHeigth);
    self.settingLabel = [[[UILabel alloc] initWithFrame:rectSetLabel] autorelease];
    self.settingLabel.text = NSLocalizedString(@"SETTINGS", @"");
    self.settingLabel.textAlignment = UITextAlignmentCenter;
    [self.settingLabel setFont:textButtonFont];
    self.settingLabel.backgroundColor = [UIColor clearColor];
    self.settingLabel.textColor = [UIColor blackColor];
    [view addSubview:self.settingLabel];
}

- (void)addScoreLabel:(CGRect)rect onView:(UIView*)view
{
    [self.lineLabel removeFromSuperview];
    UILabel* labelText = [[[UILabel alloc] initWithFrame:rect] autorelease];
    labelText.text = NSLocalizedString(@"SCORE", @"");
    if(isiPhone) {
        labelText.font = scoreFont;
    } else {
        labelText.font = scoreFontLarge;
    }
    labelText.backgroundColor = [UIColor clearColor];
    [view addSubview:labelText];
    
        if(isiPhone) {
            self.lineLabel = [[[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y + 20, rect.size.width, rect.size.height)] autorelease];
            self.lineLabel.font = scoreFontLarge;
        } else {
            self.lineLabel = [[[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x +35, rect.origin.y, rect.size.width,     rect.size.height)] autorelease];
            self.lineLabel.font = scoreFontiPad;
    }
   
    self.lineLabel.text = [NSString stringWithFormat:@"%d", self.boardViewController.lines];
   
    self.lineLabel.backgroundColor = [UIColor clearColor];
    self.lineLabel.textColor = [UIColor blackColor];
    self.lineLabel.textAlignment = UITextAlignmentCenter;
    [view addSubview:self.lineLabel];
}

- (void)addLeftMoveButton:(CGRect)rect withImage:(UIImage*)imageButton onView:(UIView*)view
{
    //left button
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = rect;
    [self.leftButton setImage:imageButton forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(moveLeftPressed) forControlEvents:UIControlEventTouchDown];
    [self.leftButton addTarget:self action:@selector(moveLeftUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton addTarget:self action:@selector(moveLeftUnPressed) forControlEvents:UIControlEventTouchDragOutside];
    [view addSubview:self.leftButton];
    
    //left label
    CGRect rectLeftLabel = CGRectMake(CGRectGetMidX(rect) - labelMoveTextWidth/2, rect.origin.y + rect.size.height - labelOffsetHeight , labelMoveTextWidth , labelTextHeigth);
    self.leftLabel = [[[UILabel alloc] initWithFrame:rectLeftLabel] autorelease];
    self.leftLabel.text = NSLocalizedString(@"LEFT", @"");
    [self.leftLabel setFont:textButtonFont];
    self.leftLabel.backgroundColor=[UIColor clearColor];
    self.leftLabel.textColor = [UIColor blackColor];
    self.leftLabel.textAlignment = UITextAlignmentCenter;
    [view addSubview:self.leftLabel];
}

- (void)addRightMoveButton:(CGRect)rect withImage:(UIImage*)imageButton onView:(UIView*)view
{
    //right button
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = rect;
    [self.rightButton setImage:imageButton forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(moveRightUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(moveRightUnPressed) forControlEvents:UIControlEventTouchDragOutside];
    [self.rightButton addTarget:self action:@selector(moveRightPressed) forControlEvents:UIControlEventTouchDown];
    [view addSubview:self.rightButton];
    
    //right label
    CGRect rectRightLabel = CGRectMake(CGRectGetMidX(rect) - labelMoveTextWidth/2 , rect.size.height + rect.origin.y - labelOffsetHeight, labelMoveTextWidth, labelTextHeigth);
    self.rightLabel = [[[UILabel alloc] initWithFrame:rectRightLabel] autorelease];
    self.rightLabel.text = NSLocalizedString(@"RIGHT", @"");
    [self.rightLabel setFont:textButtonFont];
    self.rightLabel.backgroundColor = [UIColor clearColor];
    self.rightLabel.textColor = [UIColor blackColor];
    self.rightLabel.textAlignment = UITextAlignmentCenter;
    [view addSubview:self.rightLabel];
}

- (void)addDownMoveButton:(CGRect)rect withImage:(UIImage*)imageButton onView:(UIView*)view
{
    self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downButton.frame = rect;
    [self.downButton setImage:imageButton forState:UIControlStateNormal];
    [self.downButton addTarget:self action:@selector(moveDownPressed) forControlEvents:UIControlEventTouchDown];
    [self.downButton addTarget:self action:@selector(moveDownUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.downButton addTarget:self action:@selector(moveDownUnPressed) forControlEvents:UIControlEventTouchDragOutside];
    [view addSubview:self.downButton];
    
    //down label
    CGRect rectDownLabel = CGRectMake(CGRectGetMidX(rect) - labelMoveTextWidth/2, rect.origin.y + rect.size.height - labelOffsetHeight, labelMoveTextWidth, labelTextHeigth);
    self.downLabel = [[[UILabel alloc] initWithFrame:rectDownLabel]autorelease];
    [self.downLabel setTextAlignment:NSTextAlignmentCenter];
    self.downLabel.text = NSLocalizedString(@"DOWN", @"");
    [self.downLabel setFont:textButtonFont];
    self.downLabel.backgroundColor = [UIColor clearColor];
    self.downLabel.textColor = [UIColor blackColor];
    self.downLabel.textAlignment = UITextAlignmentCenter;
    [view addSubview:self.downLabel];
}

- (void)addRotateButton:(CGRect)rect withImage:(UIImage*)imageButton andHighlighted:(UIImage*)highlightedImage  onView:(UIView*)view
{
    self.rotateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rotateButton.frame = rect;
    [self.rotateButton setImage:imageButton forState:UIControlStateNormal];
    [self.rotateButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.rotateButton addTarget:self action:@selector(rotateUnPressed) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.rotateButton];
    
    //rotate label
    CGRect rectRotateLabel = CGRectMake(CGRectGetMidX(rect) - labelRotateTextWidth/2, rect.size.height + rect.origin.y -10 , labelRotateTextWidth , labelTextHeigth);
    self.rotateLabel = [[[UILabel alloc] initWithFrame:rectRotateLabel] autorelease];
    self.rotateLabel.text = NSLocalizedString(@"ROTATE", @"");
    [self.rotateLabel setFont:textButtonFont];
    self.rotateLabel.backgroundColor=[UIColor clearColor];
    self.rotateLabel.textColor = [UIColor blackColor];
    self.rotateLabel.textAlignment = UITextAlignmentCenter;
    
    [view addSubview:self.rotateLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSetting
{
    SettingViewController* settingViewController = [[[SettingViewController alloc] init] autorelease];
    if(isStart) {
        [self pauseGame];
    }
    if(isiPhone) {
        self.showTutorial = [SettingViewController loadSettingTutorial];
        [self deprecatedPresentModalViewController:settingViewController animated:YES];
       
        
    } else {
        settingViewController.competitionBlock = ^(void) {
            [self.boardViewController showGrid: [SettingViewController loadSettingGrid]];
            [self.boardViewController showColor: [SettingViewController loadSettingColor]];
            self.showTutorial = [SettingViewController loadSettingTutorial];
            [self addGameHint];
//            ??
            
            [self.boardViewController.boardView setNeedsDisplay];
            [self.boardViewController.nextShapeView setNeedsDisplay];
        };
        settingViewController.contentSizeForViewInPopover = CGSizeMake(290, 180);
        [UIPopoverManager showControllerInPopover:settingViewController inView:self.view forTarget:self.settingButton dismissTarget:self dismissSelector:@selector(popoverControllerDidDismissPopover:)];
    }
}

- (void)pauseGame
{
    [self pauseGameTimer];
    [self.boardViewController.gameTimer invalidate];
     self.pauseImageView.hidden = NO;
    if(self.avSound.isPlaying) {
        [self.avSound pause];
    }
    self.boardViewController.gameTimer = nil;
}

- (void)continueGame
{
    [self.boardViewController startGameTimer];
     self.pauseImageView.hidden = YES;
    if (self.avSound) {
        [self.avSound play];
        self.soundImageView.hidden = NO;
    }
}

- (void)play
{
    if (self.tutorialView) {
        [self hideGameHint];
    }
    //timer start
    if(self.isStart) {
        self.isStart = NO;
        self.pauseImageView.hidden = NO;
        [self pauseGame];
    } else {
        if(self.firstStart && self.boardViewController) {
            self.gameCount++;
           
            if (isiPad) {
                //score label
                [self addScoreLabel:CGRectMake(self.boardRect.size.width + self.boardRect.origin.x + 5, 50, 150, scoreLabelHeigth) onView:self.view];
            } else {
                //score label
                [self addScoreLabel:CGRectMake(self.boardRect.size.width + self.boardRect.origin.x + 10, 20, scoreLabelWidth, scoreLabelHeigth) onView:self.view];
            }
           [Flurry logEvent:@"StartGame"];
           
            [self.boardViewController start];
            self.firstStart = NO;
            self.boardViewController.delegate = self;
            self.boardViewController.resetGameDelegate = self;
        }
        self.isStart = YES;
        
        [self continueGame];
        DBLog(@"play!");
    }
}

- (void)reset
{
    if (isStart) {
        
        [self.boardViewController resetBoard];
        [self.boardViewController stopGameTimer];
        [self.boardViewController startGameTimer];
        self.firstStart = YES;
        self.isStart = NO;
        [self play];
    }
}

- (void)sound
{
    if(self.isStart) {
        if ([self.avSound isPlaying]) {
            self.soundImageView.hidden = YES;
            [self.avSound stop];
            self.avSound = nil;
        } else {
            NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"Tetris" withExtension:@"caf"];
            NSError* err = nil;
            self.avSound = [[[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&err] autorelease];
            self.avSound.delegate = self;
            if(!err){
                [self.avSound play];
                self.soundImageView.hidden = NO;
            }
        }
    }
}

#pragma mark - AVAudioPlayerDelegate Methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.avSound play];
}


#pragma mark - Methods for TouchDown Timer

- (void)moveRightPressed
{
    if(isStart) {
        [self.boardViewController moveShape:rightDirectionMove];
        [self performSelector:@selector(moveRightPressed) withObject:nil afterDelay:delayForButtonPressed];
        [self reDrawBoard];
    }
}

- (void)moveRightUnPressed
{
    if (self.tutorialView) {
        [self hideGameHint];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveRightPressed) object:nil];
}

- (void)moveLeftPressed
{
    if(isStart){
        [self.boardViewController moveShape:leftDirectionMove];
        [self performSelector:@selector(moveLeftPressed) withObject:nil afterDelay:delayForButtonPressed];
        [self reDrawBoard];
    }
}

- (void)moveLeftUnPressed
{
    if (self.tutorialView) {
        [self hideGameHint];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveLeftPressed) object:nil];
}

- (void)moveDownPressed
{
    if(isStart) {
        [self.boardViewController moveShape:downDirectionMove];
        [self performSelector:@selector(moveDownPressed) withObject:nil afterDelay:delayForButtonPressed];
        [self reDrawBoard];
    }
}

- (void)moveDownUnPressed
{
    if (self.tutorialView) {
        [self hideGameHint];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveDownPressed) object:nil];
}

- (void)reDrawBoard
{
   [self.boardViewController.boardView setNeedsDisplay];
}

#pragma mark - Rotate shape

- (void)rotateUnPressed
{
    if (self.tutorialView) {
        [self hideGameHint];
    }
    if (isStart) {
        [self.boardViewController rotateShape:rightDirectionRotate];
        [self reDrawBoard];
    }
}

#pragma mark - Timer 

- (void)pauseGameTimer
{
    [self.boardViewController stopGameTimer];
}

#pragma mark - DeleteLineDelegate Methods

- (void)deleteLine:(NSInteger)amount
{
    self.lineLabel.text = [NSString stringWithFormat:@"%d", amount];
    NSLog(@"amount  %d", amount);
}

#pragma mark - GameOverDelegate Methods

- (void)newGame
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self reset];
}

#pragma mark - UIPopoverControllerDelegate Methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [UIImageView animateWithDuration:delayForSubView animations:^{
        [self continueGame];
    }];
}
@end
