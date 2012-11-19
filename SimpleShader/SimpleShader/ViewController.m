//
//  ViewController.m
//  SimpleShader
//
//  Created by Natasha on 16.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Resize.h"
#import <MobileCoreServices/UTCoreTypes.h>
#define BUFFER_OFFSET(i) ((char *)NULL + (i))
#define buttonWidth 80
#define buttonHeight 40
#define cameraIndexButton 1
#define defImage [UIImage imageNamed:@"WID-small.jpg"]
@interface ViewController ()
@property (retain, nonatomic) UISlider* imageSlider;
@property (retain, nonatomic) GPUImageView* imageView;
@property (retain, nonatomic) GPUImagePicture* sourcePicture;
@property (retain, nonatomic) GPUImageOutput<GPUImageInput> *shaderFilter;
@property (retain, nonatomic) UIButton* saveButton;
@property (assign, nonatomic) BOOL hasCamera;
@property (retain, nonatomic) UIImage* choosenImage;
@end

@implementation ViewController
@synthesize shaderFilter;
@synthesize sourcePicture;
@synthesize imageSlider;
@synthesize imageView;
@synthesize saveButton;
@synthesize hasCamera;
@synthesize choosenImage;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hasCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera];
    self.choosenImage = [self currentImage];
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
	self.imageView = [[GPUImageView alloc] initWithFrame:CGRectMake(25.0, 20.0, mainScreenFrame.size.width - 50.0, mainScreenFrame.size.height - 150)];//mainScreenFrame];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapImageView)];
    
    [self.imageView addGestureRecognizer:tap];
    self.imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView];
    
     self.imageSlider = [[UISlider alloc] initWithFrame:CGRectMake(25.0, mainScreenFrame.size.height - 30, mainScreenFrame.size.width - 50.0, 40.0)];
    [self.imageSlider addTarget:self action:@selector(updateSliderValue) forControlEvents:UIControlEventValueChanged];
	self.imageSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.imageSlider.minimumValue = 0.0;
    self.imageSlider.maximumValue = 1.0;
    self.imageSlider.value = 0.5;
    
    //[primaryView addSubview:imageSlider];
    [self.view addSubview:self.imageSlider];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.saveButton.frame = CGRectMake(mainScreenFrame.size.width / 2 - buttonWidth / 2, mainScreenFrame.size.height - 50.0, buttonWidth, buttonHeight);
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.view addSubview:self.saveButton];
    
    [self setupDisplayFiltering];
}

- (UIImage*)currentImage
{
    return (self.choosenImage)?self.choosenImage:defImage;
}

- (void)updateSliderValue
{
    CGFloat midpoint = self.imageSlider.value;//[(UISlider *)sender value];    
   // (GPUImageAddBlendFilter *)self.shaderFilter.textureForOutput = midpoint;
//    GPUImageDarkenBlendFilter
//     GPUImageSepiaFilter
    //[(GPUImageOverlayBlendFilter *)self.shaderFilter setupFilterForSize:CGSizeMake(100, 100) ];
    [(GPUImageSepiaFilter*)self.shaderFilter setIntensity:midpoint];
    //setIntensity:midpoint];
//  [(GPUImageAlphaBlendFilter*)self.shaderFilter setMix:0.5f];
    [sourcePicture processImage];
}


- (void)doTapImageView
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Choose existing", @""), (self.hasCamera) ? NSLocalizedString(@"Take photo", @""):nil,  nil];
    [actionSheet showInView:self.view];
    NSLog(@"tap!");
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.firstOtherButtonIndex == buttonIndex ){
        [self imageFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    if(buttonIndex == cameraIndexButton){
        [self imageFromSource:UIImagePickerControllerSourceTypeCamera];
    }
}

#pragma mark - UIImagePickerController delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if( [[info objectForKey:UIImagePickerControllerMediaType] isEqual: (NSString*)kUTTypeImage])
    {
        self.choosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
        [self setupDisplayFiltering];
    }
    
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imageFromSource:(UIImagePickerControllerSourceType)type{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:type];
    
    if([UIImagePickerController isSourceTypeAvailable:type] && [mediaTypes count] > 0)
    {
        NSArray *mediaTypes = [ UIImagePickerController availableMediaTypesForSourceType:type];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = type;
        [self presentModalViewController: picker animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:NSLocalizedString(@"Device doesn’t support that media source", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil, nil ];
        [alert show];
    }
}
- (UIImage *)crop:(CGRect)rect {
    if (self.choosenImage.scale > 1.0f) {
        rect = CGRectMake(rect.origin.x * self.choosenImage.scale,
                          rect.origin.y * self.choosenImage.scale,
                          rect.size.width * self.choosenImage.scale,
                          rect.size.height * self.choosenImage.scale);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.choosenImage.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.choosenImage.scale orientation:self.choosenImage.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}
#pragma mark -
#pragma mark Image filtering

- (void)setupDisplayFiltering;
{
    NSLog(@"size %f %f", self.choosenImage.size.height, self.choosenImage.size.width);
    CGRect testRect = CGRectMake(100, 100, 150, 150);
    UIImage *inputImage = [self.choosenImage croppedImage:testRect];//[self crop:CGRectMake(20, 20, 100, 100)];//[self currentImage]; //  The WID.jpg example is greater than 2048 pixels tall, so it fails on older device
  
    sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
    
    self.shaderFilter  = [[GPUImageSepiaFilter alloc] init];
    
    //custom
   // self.shaderFilter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"Shader"];
    
//    self.shaderFilter = [[ GPUImageAlphaBlendFilter alloc] init];
    
    //GPUImageTiltShiftFilter
    //GPUImageAddBlendFilter  GPUImageSepiaFilter
    
    //[self.shaderFilter forceProcessingAtSize:CGSizeMake(100, 100)];//InputSize:CGSizeMake(100, 100) atIndex:0];
    
    GPUImageView *tempImageView = (GPUImageView *)self.imageView;//self.view;
    [self.shaderFilter forceProcessingAtSize:tempImageView.sizeInPixels]; // This is now needed to make the filter run at the smaller output size
    
    [sourcePicture addTarget:self.shaderFilter];
    [self.shaderFilter addTarget:tempImageView];
    
    
    
    [sourcePicture processImage];
    
    
    CGContextRef contextOriginalImage = UIGraphicsGetCurrentContext();
    CGContextDrawImage(contextOriginalImage, CGRectMake(0, 0, self.choosenImage.size.width, self.choosenImage.size.height), self.choosenImage.CGImage);
//      CGContextDrawTiledImage(contextOriginalImage, testRect, sourcePicture.newCGImageFromCurrentlyProcessedOutput);
//
    UIImage* res = UIGraphicsGetImageFromCurrentImageContext();
    self.choosenImage = res;

}

//add linear effect
//- (void)addBorder {
//    if (currentBorder != kBorderInitialValue) {
//        GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
//        GPUImagePicture *imageToProcess = [[GPUImagePicture alloc] initWithImage:self.imageToWorkWithView.image];
//        GPUImagePicture *border = [[GPUImagePicture alloc] initWithImage:self.imageBorder];
//        
//        blendFilter.mix = 1.0f;
//        [imageToProcess addTarget:blendFilter];
//        [border addTarget:blendFilter];
//        
//        [imageToProcess processImage];
//        [border processImage];
//        self.imageToWorkWithView.image = [blendFilter imageFromCurrentlyProcessedOutput];
//        
//        [blendFilter release];
//        [imageToProcess release];
//        [border release];
//    }
//}

@end
