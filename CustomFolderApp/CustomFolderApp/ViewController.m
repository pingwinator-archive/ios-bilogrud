//
//  ViewController.m
//  CustomFolderApp
//
//  Created by Natasha on 13.02.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImagePickerController* picker;
@property (strong, nonatomic) UIImage* image;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPhoto
{
    [self imageFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)savePhoto
{
    [self save];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if([[info objectForKey:UIImagePickerControllerMediaType] isEqual: (NSString*)kUTTypeImage])
    {
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
         [self dismissModalViewControllerAnimated:YES];
    }
    self.picker = nil;
}

- (void)imageFromSource:(UIImagePickerControllerSourceType)type
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:type];
    
    if([UIImagePickerController isSourceTypeAvailable:type] && [mediaTypes count] > 0) {
        self.picker = [[UIImagePickerController alloc] init];
        [self.picker setMediaTypes: [NSArray arrayWithObject:(NSString *)kUTTypeImage]];
        self.picker.delegate = self;
        self.picker.sourceType = type;
       
        [self presentViewController:self.picker animated:YES completion:nil];
      
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:NSLocalizedString(@"Device doesn’t support that media source", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil, nil ];
        [alert show];
    }
}

- (NSString *)getPathToSettingsFile
{
    NSString *path = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
    return path;
}

- (void)save
{
    NSString *path = [self getPathToSettingsFile];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
//    BOOL result = [NSKeyedArchiver archiveRootObject:self.settings toFile:path];
//    if (!result) {
//        NSLog(@"keywords not saved");
//    }
}

@end
