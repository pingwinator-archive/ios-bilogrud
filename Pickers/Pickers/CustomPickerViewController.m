//
//  CustomPickerViewController.m
//  Pickers
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "CustomPickerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CustomPickerViewController ()

@end

@implementation CustomPickerViewController
@synthesize column1;
@synthesize column2;
@synthesize column3;
@synthesize column4;
@synthesize column5;
@synthesize picker;
@synthesize winLabel;
@synthesize button;
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
    // Do any additional setup after loading the view from its nib.
    UIImage *seven = [UIImage imageNamed:@"seven.png"];
    UIImage *bar = [UIImage imageNamed:@"bar.png"];
    UIImage *crown = [UIImage imageNamed:@"crown.png"];
    UIImage *cherry = [UIImage imageNamed:@"cherry.png"];
    UIImage *lemon = [UIImage imageNamed:@"lemon.png"];
    UIImage *apple = [UIImage imageNamed:@"apple.png"];
    for (int i = 1; i <= 5; i++) {
        UIImageView *sevenView = [[[UIImageView alloc] initWithImage:seven]autorelease];
        UIImageView *barView = [[[UIImageView alloc] initWithImage:bar]autorelease];
        UIImageView *crownView = [[[UIImageView alloc] initWithImage:crown]autorelease];
        UIImageView *cherryView = [[[UIImageView alloc]initWithImage:cherry]autorelease];
        UIImageView *lemonView = [[[UIImageView alloc] initWithImage:lemon]autorelease];
        UIImageView *appleView = [[[UIImageView alloc] initWithImage:apple]autorelease];
        NSArray *imageViewArray = [[[NSArray alloc] initWithObjects: sevenView, barView, crownView, cherryView, lemonView, appleView, nil]autorelease];
    NSString *fieldName =
        [[[NSString alloc] initWithFormat:@"column%d", i]autorelease];
        [self setValue:imageViewArray forKey:fieldName];
    }
    srandom(time(NULL));
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.picker = nil;
    self.winLabel = nil;
    self.column1 = nil;
    self.column2 = nil;
    self.column3 = nil;
    self.column4 = nil;
    self.column5 = nil;
    self.button = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)spin{
    BOOL win = NO;
    int numInRow = 1;
    int lastVal = -1;
    for (int i = 0; i < 5; i++) {
        int newValue = random() % [self.column1 count];
        if (newValue == lastVal) numInRow++;
        else
            numInRow = 1;
        lastVal = newValue;
        [picker selectRow:newValue inComponent:i animated:YES];
        [picker reloadComponent:i];
        if (numInRow >= 3)
            win = YES;
    }
    self.button.hidden = YES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    AudioServicesPlaySystemSound (soundID);
    if (win)
        [self performSelector:@selector(playWinSound) withObject:nil afterDelay:.5];
    else
        [self performSelector:@selector(showButton) withObject:nil afterDelay:.5];
    winLabel.text = @"";
   
//    if(win)
//        winLabel.text = @"Win!!!";
//    else
//        winLabel.text = @"";
}
//????

-(void)showButton {
    self.button.hidden = NO;
}
-(void)playWinSound {
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"win" withExtension:@"wav"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundID);
    AudioServicesPlaySystemSound(soundID);
    winLabel.text = @"WINNING!";
    [self performSelector:@selector(showButton) withObject:nil  afterDelay:1.5];
}
   
    
#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5; }
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component { return [self.column1 count];
}
#pragma mark Picker Delegate Methods
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *arrayName = [NSString stringWithFormat:@"column%d", component+1];
    NSArray *array = [self valueForKey:arrayName];
    return [array objectAtIndex:row]; }
@end
