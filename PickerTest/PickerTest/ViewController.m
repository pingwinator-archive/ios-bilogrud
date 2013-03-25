//
//  ViewController.m
//  PickerTest
//
//  Created by Natasha on 25.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "UIImage+Additions.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImagePickerController* picker;
@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UILabel* originalLabel;
@property (strong, nonatomic) UILabel* squareLabel;
@property (strong, nonatomic) UILabel* cropLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.originalLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 270, 30)];
    [self.originalLabel setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.1f]];
    [self.view addSubview:self.originalLabel];
    
    self.squareLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 140, 270, 30)];
    [self.squareLabel setBackgroundColor:[[UIColor brownColor] colorWithAlphaComponent:0.1f]];
    [self.view addSubview:self.squareLabel];
    
    self.cropLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 270, 30)];
    [self.cropLabel setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.1f]];
    [self.view addSubview:self.cropLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageFromCamera
{
    [self imageFromSource: UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)imageFromLibrary
{
    [self imageFromSource: UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)addPicker:(UIImagePickerControllerSourceType)type
{
    self.picker = [[UIImagePickerController alloc] init];
    [self.picker setMediaTypes: [NSArray arrayWithObject:(NSString *)kUTTypeImage]];
    self.picker.delegate = self;
    self.picker.sourceType = type;
    self.picker.allowsEditing = YES;
    if(type == UIImagePickerControllerSourceTypeCamera) {
        self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    }
  
}

#pragma mark - UIImagePickerController delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage* __block choosenImage;
    CGSize __block originalSize;
    CGSize __block smallSize;
    
        [self dismissViewControllerAnimated:YES completion:^{
            
            choosenImage = [UIImage processAlbumPhoto:info];
            UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
            originalSize = CGSizeMake(original.size.width, original.size.height);
            [self.originalLabel setText:[NSString stringWithFormat:@"original size: %i x %i", (int)roundf( original.size.width), (int)roundf( original.size.height)]];
            
            
            
            original = [original softScaleToSide:200];
            smallSize = original.size;
            NSLogS(original.size);
            
            UIImage* choosenSmall = [choosenImage softScaleToSide:200];
            smallSize = choosenSmall.size;
//            NSLogS(original.size);

            
            CGRect cropRect = [[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
            CGFloat aspectRatio = smallSize.height / originalSize.height;
            
            [self.cropLabel setText:[NSString stringWithFormat:@"crop rect: x %i y %i w %i h %i", (int)roundf( cropRect.origin.x), (int)roundf( cropRect.origin.y), (int)roundf( cropRect.size.width), (int)roundf( cropRect.size.height)]];
            
            cropRect = CGRectMake(cropRect.origin.x * aspectRatio, cropRect.origin.y * aspectRatio, cropRect.size.width * aspectRatio, cropRect.size.height * aspectRatio);
            
            
//            [self setImageFromPicker:choosenImage withCropRect:cropRect];
            [self setImageFromPicker:original withCropRect:cropRect];

            [self.squareLabel setText:[NSString stringWithFormat:@"square size: %i x %i", (int)roundf( choosenImage.size.width), (int)roundf( choosenImage.size.height)]];
        }];
    
    self.picker = nil;
}

- (void)setImageFromPicker:(UIImage*)image withCropRect:(CGRect)rect
{
    [self.imageView removeFromSuperview];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 250, image.size.width, image.size.height)];
    [self.imageView setBackgroundColor:[UIColor redColor]];
    [self.imageView setImage:image];
    [self.view addSubview:self.imageView];

    UIImageView* cropImageView = [[UIImageView alloc] initWithFrame:rect];
    [cropImageView setBackgroundColor:[[UIColor redColor]colorWithAlphaComponent:0.5f]];
    [self.imageView addSubview:cropImageView];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageFromSource:(UIImagePickerControllerSourceType)type
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:type];
   
    if([UIImagePickerController isSourceTypeAvailable:type] && [mediaTypes count] > 0) {
        [self addPicker:type];
        [self presentViewController:self.picker animated:YES completion:nil];
    } 
}
@end
