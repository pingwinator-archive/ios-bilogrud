//
//  TableViewController.m
//  TableTest
//
//  Created by Natasha on 30.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "TableViewController.h"
#import "StatusCell.h"

#define SHOW_MULTIPLE_SECTIONS		1		// If commented out, multiple sections with header and footer views are not shown

#define PORTRAIT_WIDTH				768
#define LANDSCAPE_HEIGHT			(1024-20)
#define HORIZONTAL_TABLEVIEW_HEIGHT	140
#define VERTICAL_TABLEVIEW_WIDTH	180
#define TABLE_BACKGROUND_COLOR		[UIColor clearColor]

#define BORDER_VIEW_TAG				10

#ifdef SHOW_MULTIPLE_SECTIONS
#define NUM_OF_CELLS			10
#define NUM_OF_SECTIONS			2
#else
#define NUM_OF_CELLS			21
#endif
@interface TableViewController ()
@property (strong, nonatomic) NSMutableArray* allCells;
@end

@implementation TableViewController



- (id)init
{
    self = [super init];
    if (self) {

    
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setuphorizontalView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setuphorizontalView {
	CGRect frameRect	= CGRectMake(0, LANDSCAPE_HEIGHT - HORIZONTAL_TABLEVIEW_HEIGHT, PORTRAIT_WIDTH, HORIZONTAL_TABLEVIEW_HEIGHT);
	EasyTableView *view	= [[EasyTableView alloc] initWithFrame:frameRect numberOfColumns:NUM_OF_CELLS ofWidth:VERTICAL_TABLEVIEW_WIDTH];
	self.self.horizontalView = view;
	
	self.horizontalView.delegate						= self;
	self.horizontalView.tableView.backgroundColor	= TABLE_BACKGROUND_COLOR;
	self.horizontalView.tableView.allowsSelection	= YES;
	self.horizontalView.tableView.separatorColor		= [UIColor darkGrayColor];
	self.horizontalView.cellBackgroundColor			= [UIColor darkGrayColor];
	self.horizontalView.autoresizingMask				= UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
	
	[self.view addSubview:self.horizontalView];
}


#pragma mark -
#pragma mark Utility Methods

- (void)borderIsSelected:(BOOL)selected forView:(UIView *)view {
	UIImageView *borderView		= (UIImageView *)[view viewWithTag:BORDER_VIEW_TAG];
	NSString *borderImageName	= (selected) ? @"selected_border.png" : @"image_border.png";
	borderView.image			= [UIImage imageNamed:borderImageName];
}


#pragma mark -
#pragma mark EasyTableViewDelegate

// These delegate methods support both example views - first delegate method creates the necessary views

- (UIView *)easyTableView:(EasyTableView *)easyTableView viewForRect:(CGRect)rect {
	CGRect labelRect		= CGRectMake(10, 10, rect.size.width-20, rect.size.height-20);
	UILabel *label			= [[UILabel alloc] initWithFrame:labelRect];
	label.textAlignment		= UITextAlignmentCenter;
	label.textColor			= [UIColor whiteColor];
	label.font				= [UIFont boldSystemFontOfSize:60];
	
	// Use a different color for the two different examples
	if (easyTableView == self.horizontalView)
		label.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
	else
		label.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
	
	UIImageView *borderView		= [[UIImageView alloc] initWithFrame:label.bounds];
	borderView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	borderView.tag				= BORDER_VIEW_TAG;
	
	[label addSubview:borderView];
    
	return label;
}

// Second delegate populates the views with data from a data source

- (void)easyTableView:(EasyTableView *)easyTableView setDataForView:(UIView *)view forIndexPath:(NSIndexPath *)indexPath {
	UILabel *label	= (UILabel *)view;
	label.text		= [NSString stringWithFormat:@"%i", indexPath.row];
	
	// selectedIndexPath can be nil so we need to test for that condition
	BOOL isSelected = (easyTableView.selectedIndexPath) ? ([easyTableView.selectedIndexPath compare:indexPath] == NSOrderedSame) : NO;
    [self borderIsSelected:isSelected forView:view];
}

@end
