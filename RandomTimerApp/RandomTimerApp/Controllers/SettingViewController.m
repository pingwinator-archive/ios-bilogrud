//
//  SettingViewController.m
//  RandomTimerApp
//
//  Created by Natasha on 19.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize cleanCD;
@synthesize switchTypeGenerator;
@synthesize textSwitchLabel;
- (void)dealloc
{
    self.cleanCD = nil;
    self.switchTypeGenerator = nil;
    self.textSwitchLabel = nil;
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
    [self refreshFields];
    //UI
    self.textSwitchLabel.text = NSLocalizedString(@"Generate Number Local", @"");
   // self.cleanCD.titleLabel.text = NSLocalizedString(@"Clean CoreData", @"");
    [self.cleanCD setTitle:NSLocalizedString(@"Clean CoreData", @"") forState:UIControlStateNormal];
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:app];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)cleanCoreData
{
    NSFetchRequest* allGener = [[NSFetchRequest alloc] init];
    [allGener setEntity:[NSEntityDescription entityForName:@"GeneratedData" inManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext ]]];
    [allGener setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * gens = [[[CoreDataManager sharedInstance] managedObjectContext ] executeFetchRequest:allGener error:&error];
    [allGener release];
    
    //error handling goes here
    for (NSManagedObject* gen in gens) {
        [[[CoreDataManager sharedInstance] managedObjectContext ] deleteObject:gen];
    }
    NSError *saveError = nil;
    [[[CoreDataManager sharedInstance] managedObjectContext ] save:&saveError];
}


- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}

- (void)refreshFields {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.switchTypeGenerator.on = [defaults boolForKey:@"kRandom"];
    
}
- (IBAction)engineSwitchTapped {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"--------%@",self.switchTypeGenerator.on?@"yes":@"no");
    [defaults setBool:self.switchTypeGenerator.on forKey:@"kRandom"];
     [defaults synchronize];
}
@end