//
//  ViewController.m
//  Control Fun
//
//  Created by Natasha on 21.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize doSomethingButton;
@synthesize rightSwitch;
@synthesize sliderLabel;
@synthesize numberField;
@synthesize nameField;
@synthesize leftSwitch;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNameField:nil];
    [self setNumberField:nil];
    [self setSliderLabel:nil];
    [self setLeftSwitch:nil];
    [self setRightSwitch:nil];
    [self setDoSomethingButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}
-(IBAction)backgroundTap:(id)sender
{
    [nameField resignFirstResponder];
    [numberField resignFirstResponder];
}
- (void)dealloc {
    [nameField release];
    [numberField release];
    [sliderLabel release];
    [leftSwitch release];
    [rightSwitch release];
    [doSomethingButton release];
    [super dealloc];
}
- (IBAction)sliderChanged:(id)sender {
    //?
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)roundf(slider.value);
    
    
    sliderLabel.text = [NSString stringWithFormat:@"%d", progressAsInt];
    
}
- (IBAction)switchChanged:(id)sender{
    UISwitch *whichSwitch = (UISwitch *)sender;
    BOOL setting = whichSwitch.isOn;
    [leftSwitch setOn:setting animated:YES];
    [rightSwitch setOn:setting animated:YES];
}
- (IBAction)toggleControls:(id)sender{
    // 0 == switches index
    if ([sender selectedSegmentIndex] == 0) {
        leftSwitch.hidden = NO;
        rightSwitch.hidden = NO;
        doSomethingButton.hidden = YES;
    }
    else {
        leftSwitch.hidden = YES;
        rightSwitch.hidden = YES;
        doSomethingButton.hidden = NO;
    }
}

- (IBAction)buttonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                            initWithTitle:@"Are you sure?"
                            delegate:self
                            cancelButtonTitle:@"No Way!"
                            destructiveButtonTitle:@"Yes, I’m Sure!"
                            otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        NSString *msg = nil;
        if (nameField.text.length > 0)
            msg = [[NSString alloc] initWithFormat: @"You can breathe easy, %@, everything went OK.", nameField.text];
        else
            msg = @"You can breathe easy, everything went OK.";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Something was done"
                              message:msg
                              delegate:self
                              cancelButtonTitle:@"Phew!"
                              otherButtonTitles:@"Foo", @"Bar", nil];
       
        [alert show];
        }
      }
@end
