//
//  AddPersonViewController.m
//  PersonDBApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "AddPersonViewController.h"
#import "Person.h"
#import "AppDelegate.h"
@interface AddPersonViewController ()

@end

@implementation AddPersonViewController
@synthesize textFieldAge;
@synthesize textFieldFirstName;
@synthesize textFieldLastName;

- (void)dealloc
{
    self.textFieldFirstName = nil;
    self.textFieldLastName = nil;
    self.textFieldAge = nil;
    [super dealloc];
}

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
	// Do any additional setup after loading the view.
    
    self.title = @"New person";
    //first name
    CGRect rect = CGRectMake(20.0f, 20.0f, self.view.bounds.size.width - 40.0f, 31.0f);
    self.textFieldFirstName = [[[UITextField alloc] initWithFrame:rect] autorelease];
    self.textFieldFirstName.placeholder = @"first name";
    self.textFieldFirstName.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldFirstName.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textFieldFirstName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:self.textFieldFirstName];
    
    //lastName
    rect.origin.y += 37.0f;
    self.textFieldLastName = [[[UITextField alloc] initWithFrame:rect] autorelease];
    self.textFieldLastName.placeholder = @"Last Name";
    self.textFieldLastName.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldLastName.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textFieldLastName.contentVerticalAlignment =
    UIControlContentVerticalAlignmentCenter; [self.view addSubview:self.textFieldLastName];
 
    //age
    rect.origin.y += 37.0f;
    self.textFieldAge = [[[UITextField alloc] initWithFrame:rect] autorelease];
    self.textFieldAge.placeholder = @"Age";
    self.textFieldAge.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldAge.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textFieldAge.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldAge.contentVerticalAlignment =
    UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:self.textFieldAge];

    
    UIBarButtonItem *addbutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self action:@selector(createPerson)];
    [self.navigationItem setRightBarButtonItem:addbutton animated:YES];
    [addbutton release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textFieldFirstName becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)createPerson
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    Person* newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    if(newPerson){
        newPerson.firstName = self.textFieldFirstName.text;
        newPerson.lastName = self.textFieldLastName.text;
        newPerson.age = [NSNumber numberWithInteger:[self.textFieldAge.text integerValue]];
        
        NSError* err = nil;
        if([context save:&err]){
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"error with saving");
        }
    } else {
        NSLog(@"error with object");
    }

}
@end
