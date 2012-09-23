//
//  SettingViewController.m
//  RandomTimerApp
//
//  Created by Natasha on 19.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingViewController.h"
#import "RandomTableViewController.h"

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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object: [UIApplication sharedApplication]];
    [super dealloc];
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
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)cleanCoreData
{
    RandomTableViewController* mainCV = [[self.navigationController viewControllers] objectAtIndex:0] ;
    if(mainCV) {
        [mainCV.generator stopGenerator];
    }
        
   
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
    if(mainCV) {
        [mainCV.generator startGenerator];
    }
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