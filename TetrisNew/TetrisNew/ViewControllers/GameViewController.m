//
//  ViewController.m
//  TetrisNew
//
//  Created by Natasha on 07.10.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "GameViewController.h"
#import "BoardView.h"
#import "BGView.h"
@interface GameViewController ()
@property (retain, nonatomic) BoardView* boardView;
@property (retain, nonatomic) BGView* backgroundView;
@property (retain, nonatomic) BoardView* nextShapeView;
@property (retain, nonatomic) UIButton* playButton;
@property (retain, nonatomic) UIButton* leftButton;
@property (retain, nonatomic) UIButton* downButton;
@property (retain, nonatomic) UIButton* rightButton;
@property (retain, nonatomic) UILabel* playLabel;
@property (retain, nonatomic) UILabel* leftLabel;
@property (retain, nonatomic) UILabel* downLabel;
@property (retain, nonatomic) UILabel* rightLabel;
@end

@implementation GameViewController
@synthesize boardView;
@synthesize backgroundView;
@synthesize nextShapeView;
@synthesize playButton;
@synthesize rightButton;
@synthesize downButton;
@synthesize leftButton;
@synthesize playLabel;
@synthesize leftLabel;
@synthesize downLabel;
@synthesize rightLabel;
- (void)dealloc
{
    self.boardView = nil;
    self.backgroundView = nil;
    self.nextShapeView = nil;
    self.playButton = nil;
    self.rightButton = nil;
    self.downButton = nil;
    self.leftButton = nil;
    self.playLabel = nil;
    self.leftLabel = nil;
    self.downLabel = nil;
    self.rightLabel = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    self.backgroundView = [[[BGView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
    self.backgroundView.backgroundColor =[UIColor colorWithRed:39.0f/255.0f green:64.0f/255.0f blue:139.0f/255.0f alpha:1];  // [UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1];

    [self.view addSubview:self.backgroundView];
    
    //board
    CGRect boardRect;
    
    if(isiPhone) {
        boardRect = CGRectMake(15, 15, 230, 350);
    } else {
        boardRect = CGRectMake(15, 15, 650, 850);
    }
    self.boardView = [[[BoardView alloc] initWithFrame:boardRect amountCellX:10] autorelease];
    self.boardView.backgroundColor = [UIColor lightGrayColor];
    [self.backgroundView addSubview:self.boardView];
	
    //play button
    CGRect rectPlayButton = CGRectMake(boardRect.size.width + 30, boardRect.origin.y, playSizeButton, playSizeButton);
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.frame = rectPlayButton;
    UIImage* im = [UIImage imageNamed:@"SmallYellow.png"];
    [self.playButton setImage:im forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    [self.playButton release];
    
    //play label
    CGRect rectPlayLabel = CGRectMake(rectPlayButton.origin.x, rectPlayButton.size.height + 15, labelMoveTextWidth, labelMoveTextHeigth);
    self.playLabel = [[UILabel alloc] initWithFrame:rectPlayLabel];
    self.playLabel.text = @"PLAY";
    [self.playLabel setFont:textButtonFont];
    self.playLabel.backgroundColor=[UIColor clearColor];
    self.playLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.playLabel];
    [self.playLabel release];
    
    //next shape View
    self.nextShapeView = [[BoardView alloc] initWithFrame:CGRectMake(rectPlayLabel.origin.x - 8, rectPlayLabel.origin.y + rectPlayLabel.size.height + 5, 50, 50) amountCellX:4];
    self.nextShapeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.nextShapeView];
    [self.nextShapeView release];
    
    //left button
    CGRect moveButton = CGRectMake(boardRect.origin.x + 10, boardRect.size.height + 30, moveSizeButton, moveSizeButton);
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = moveButton;
    UIImage* image = [UIImage imageNamed:@"SmallYellow.png"];
    [self.leftButton setImage:image forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(moveLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    [self.leftButton release];
    
    //left label
    CGRect rectLeftLabel = CGRectMake(moveButton.origin.x , moveButton.origin.y + moveButton.size.height , labelMoveTextWidth, labelMoveTextHeigth);
    self.leftLabel = [[UILabel alloc] initWithFrame:rectLeftLabel];
    self.leftLabel.text = @"LEFT";
    [self.leftLabel setFont:textButtonFont];
    self.leftLabel.backgroundColor=[UIColor clearColor];
    self.leftLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.leftLabel];
    [self.leftLabel release];
    
    //down button
    moveButton.origin.x += 80;
    self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downButton.frame = moveButton;
    [self.downButton setImage:image forState:UIControlStateNormal];
    [self.downButton addTarget:self action:@selector(moveDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downButton];
    [self.downButton release];
    
    //down label
    CGRect rectDownLabel = CGRectMake(moveButton.origin.x, moveButton.origin.y + moveButton.size.height, labelMoveTextWidth, labelMoveTextHeigth);
    self.downLabel = [[UILabel alloc] initWithFrame:rectDownLabel];
    self.downLabel.text = @"DOWN";
    [self.downLabel setFont:textButtonFont];
    self.downLabel.backgroundColor=[UIColor clearColor];
    self.downLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.downLabel];
    [self.downLabel release];
    
    //right button
    moveButton.origin.x += 80;
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = moveButton;
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(moveRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    [self.rightButton release];
    
    //right label
    CGRect rectRightLabel = CGRectMake(moveButton.origin.x, moveButton.size.height + moveButton.origin.y , labelMoveTextWidth, labelMoveTextHeigth);
    self.rightLabel = [[UILabel alloc] initWithFrame:rectRightLabel];
    self.rightLabel.text = @"RIGHT";
    [self.rightLabel setFont:textButtonFont];
    self.rightLabel.backgroundColor=[UIColor clearColor];
    self.rightLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.rightLabel];
    [self.rightLabel release];
    
    //rotate button
//    CGRect rotateButton = CGRectMake(boardRect.origin.x + 10, boardRect.size.height + 30, moveSizeButton, moveSizeButton);
//    self.downButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.downButton.frame = moveButton;
//    [self.downButton setImage:image forState:UIControlStateNormal];
//    [self.downButton addTarget:self action:@selector(moveDown) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.downButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)play
{
    NSLog(@"play!");
}

- (void)moveLeft
{
    NSLog(@"left!");
}
- (void)moveDown
{
    NSLog(@"down!");
}

- (void)moveRight
{
    NSLog(@"right!");
}
@end
