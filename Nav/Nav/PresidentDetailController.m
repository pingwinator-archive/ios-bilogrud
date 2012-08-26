//
//  PresidentDetailController.m
//  Nav
//
//  Created by Natasha on 26.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "PresidentDetailController.h"
#import "President.h"
@interface PresidentDetailController ()

@end

@implementation PresidentDetailController
@synthesize president;
@synthesize fieldLabels;
@synthesize currentTextField;
@synthesize tempValues;


-(IBAction)cansel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)save:(id)sender{
    if (currentTextField != nil) {
        NSNumber *tagAsNum = [NSNumber numberWithInt:currentTextField.tag];
        [tempValues setObject:currentTextField.text forKey:tagAsNum];
    }
    for (NSNumber *key in [tempValues allKeys]) {
        switch ([key intValue]) {
            case kNameRowIndex:
            president.name = [tempValues objectForKey:key];
                break;
            case kFromYearRowIndex:
            president.fromYear = [tempValues objectForKey:key];
                break;
            case kToYearRowIndex:
            president.toYear = [tempValues objectForKey:key];
                break;
            case kPartyIndex:
            president.party = [tempValues objectForKey:key];
        default:
            break;
        }
    }
        [self.navigationController popViewControllerAnimated:YES];
        //?
        NSArray *array = self.navigationController.viewControllers;
        UITableViewController *parent = [array lastObject];
        [parent.tableView reloadData];

}
-(IBAction)textFieldDone:(id)sender{
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array = [[NSArray alloc] initWithObjects:@"Name:", @"From:",
                      @"To:", @"Party:", nil];
    self.fieldLabels = array;
    UIBarButtonItem *canselButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cansel:)];
    self.navigationItem.leftBarButtonItem = canselButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    self.tempValues = dict;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tempValues = nil;
    self.fieldLabels = nil;
    self.currentTextField = nil;
    self.president = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfEditableRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PresidentCellIdentifier = @"PresidentCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PresidentCellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PresidentCellIdentifier];
        
        UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, 75, 25)];
        label.textAlignment = UITextAlignmentRight;
        label.tag = kLabelTag;
        label.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame: CGRectMake(90, 12, 200, 25)];
        textField.clearsOnBeginEditing = NO;
        [textField setDelegate:self];
        //!
        textField.returnKeyType = UIReturnKeyDone;
        //connect with action
        [textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview:textField];
    }
    NSUInteger row = [indexPath row];
    UILabel *label = (UILabel *)[cell viewWithTag:kLabelTag];
    UITextField *textField = nil;
    for (UIView *oneView in cell.contentView.subviews) {
        if ([oneView isMemberOfClass:[UITextField class]])
            textField = (UITextField *)oneView;
    }
    
    label.text = [fieldLabels objectAtIndex:row];
    NSNumber *rowAsNum = [NSNumber numberWithInt:row];
    switch (row) {
        case kNameRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum])
                textField.text = [tempValues objectForKey:rowAsNum];
            else
                textField.text = president.name;
            break;
        case kFromYearRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum])
                textField.text = [tempValues objectForKey:rowAsNum];
            else
                textField.text = president.fromYear;
            break;
        case kToYearRowIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum])
                textField.text = [tempValues objectForKey:rowAsNum];
            else
                textField.text = president.toYear;
            break;
        case kPartyIndex:
            if ([[tempValues allKeys] containsObject:rowAsNum])
                textField.text = [tempValues objectForKey:rowAsNum];
            else
                textField.text = president.party;
        default:
            break;
    }
    if (currentTextField == textField) {
        currentTextField = nil;
    }
    textField.tag = row;
    return cell;
}
//??????
#pragma mark - Table Delegate Methods
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return  nil;
}
#pragma mark - Text Field Delegate Methods
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.currentTextField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSNumber *tagAsNum = [NSNumber numberWithInt:textField.tag];
    [self.tempValues setObject:textField forKey:tagAsNum];
}

@end
