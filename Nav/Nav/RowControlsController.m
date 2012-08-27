//
//  RowControlsController.m
//  Nav
//
//  Created by Natasha on 25.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "RowControlsController.h"

@interface RowControlsController ()
@property (retain, nonatomic) NSNumber *i;
@end

@implementation RowControlsController
@synthesize list;
@synthesize i;

-(void)dealloc{
    [list release];
    [super dealloc];
}
-(IBAction)buttonTapped:(id)sender{
    UIButton *senderButton = (UIButton*) sender;
    UITableViewCell *cell = (UITableViewCell *)[senderButton superview];
    NSUInteger buttonRow = [[self.tableView indexPathForCell:cell ] row];
    NSString *buttonTitle = [list objectAtIndex:buttonRow];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You tapped the button" message:[NSString stringWithFormat:@"%@", buttonTitle] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSArray *array = [[NSArray alloc] initWithObjects: @"R2-D2", @"C3PO", @"Tik-Tok", @"Robby", @"Rosie", @"Uniblab", @"Bender", @"Marvin", @"Lt. Commander Data", @"Evil Brother Lore", @"Optimus Prime", @"Tobor", @"HAL",@"Orgasmatron", nil];
    self.list = array;
    self.i = [NSNumber numberWithInteger:0];
    [array release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.list = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.list count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ControlRowIdentifier = @"ControlRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ControlRowIdentifier];
  //  UITableViewCell *cell = nil;
    if (cell == nil) {
        NSNumber *bNumber = [NSNumber numberWithInteger:[self.i integerValue] + 1];
        self.i = bNumber;
        NSLog(@"%@", i);
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:ControlRowIdentifier]autorelease];
        UIImage *buttonUpImage = [UIImage imageNamed:@"button_up.png"];
        UIImage *buttonDownImage = [UIImage imageNamed:@"button_down.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0, 0.0, buttonUpImage.size.width, buttonUpImage.size.height);
        [button setBackgroundImage:buttonUpImage forState:UIControlStateNormal];
        [button setBackgroundImage:buttonDownImage forState:UIControlStateHighlighted];
        [button setTitle:@"Tap" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
    }
    NSUInteger row = [indexPath row];
    NSString *rowTitle = [list objectAtIndex:row];
    cell.textLabel.text = rowTitle;
    return cell;
}
#pragma mark -Table View Delegate Mathods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    NSString *title = [list objectAtIndex:row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You tapped the button" message:[NSString stringWithFormat:@"%@", title] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
