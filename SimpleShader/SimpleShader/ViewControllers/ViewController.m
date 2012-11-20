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
#import "ItemMenuView.h"
#define BUFFER_OFFSET(i) ((char *)NULL + (i))
#define buttonWidth 80
#define buttonHeight 40

#define menuItemWidth 50
#define menuItemHeight 50

#define cameraIndexButton 1
#define defImage [UIImage imageNamed:@"WID-small.jpg"]
#define secondImage [UIImage imageNamed:@"image.png"]

typedef enum
{   SepiaFilter = 0,
    EmbossFilter,
    OverlaBlendFilter
} FilterCollection;
@interface ViewController ()
@property (strong, nonatomic) UISlider* imageSlider;
@property (strong, nonatomic) UIImageView* imageView;
@property (assign, nonatomic) FilterCollection activeFilter;
@property (strong, nonatomic) GPUImageFilter* filter;
@property (strong, nonatomic) UIScrollView* horisontalScrollView;
//@property (strong, nonatomic) GPUImageView* imageView;
//@property (strong, nonatomic) GPUImagePicture* sourcePicture;
//@property (strong, nonatomic) GPUImageOutput<GPUImageInput> *shaderFilter;
@property (strong, nonatomic) UIButton* saveButton;
@property (assign, nonatomic) BOOL hasCamera;
@property (strong, nonatomic) UIImage* choosenImage;
@end

@implementation ViewController
//@synthesize shaderFilter;
//@synthesize sourcePicture;
@synthesize imageSlider;
@synthesize imageView;
@synthesize saveButton;
@synthesize hasCamera;
@synthesize choosenImage;
@synthesize activeFilter;
@synthesize filter;
@synthesize horisontalScrollView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hasCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera];
    self.choosenImage = [self currentImage];
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
	self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25.0, 20.0, mainScreenFrame.size.width - 50.0, mainScreenFrame.size.height - 150)];//mainScreenFrame];
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
    
//    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.saveButton.frame = CGRectMake(mainScreenFrame.size.width / 2 - buttonWidth / 2, mainScreenFrame.size.height - 50.0, buttonWidth, buttonHeight);
//    [self.saveButton setTitle:@"Test" forState:UIControlStateNormal];
//    [self.saveButton addTarget:self action:@selector(saveResult) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.saveButton];
    
  
    
    self.horisontalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 400, 300, 70)];
    self.horisontalScrollView.backgroundColor = [UIColor redColor];
    self.horisontalScrollView.pagingEnabled = YES;
  //  NSInteger numberOfViews = 5;

    [self.horisontalScrollView setShowsHorizontalScrollIndicator:YES];
   // self.horisontalScrollView.delegate = self;
    self.horisontalScrollView.contentSize = CGSizeMake(menuItemWidth * 10 , menuItemHeight);
    [self.view addSubview:self.horisontalScrollView];
    
    ItemMenuView* itemImage = [[ItemMenuView alloc]initWithFrame:CGRectMake(self.horisontalScrollView.frame.origin.x , self.horisontalScrollView.frame.origin.y, 50 , 50) andImage:defImage];
     itemImage.backgroundColor = [UIColor blueColor];
    [self.horisontalScrollView addSubview:itemImage];
    [self setupDisplayFiltering];
}

- (void)saveResult
{
    NSLog(@"test usinf filter");
    [self addLinearFilter];
}

- (UIImage*)currentImage
{
    return (self.choosenImage)?self.choosenImage:defImage;
}

- (void)updateSliderValue
{
    CGFloat midpoint = self.imageSlider.value;
    
    
    switch (self.activeFilter) {
        case SepiaFilter:
        {
             [(GPUImageSepiaFilter*)self.filter setIntensity:midpoint];
        }
            break;
        case EmbossFilter:
        {
            
        }
            break;
        case OverlaBlendFilter:
        {
            
        }
            break;
        default:
            break;
    }
//!!
            //[(GPUImageAlphaBlendFilter*)self.filter setMix:0.5f];
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


- (void)setupDisplayFiltering
{
    NSLog(@"size %f %f", self.choosenImage.size.height, self.choosenImage.size.width);
    CGRect testRect = CGRectMake(500, 500, 500, 500);
    UIImage *inputImage =[self.choosenImage croppedImage:testRect];// [self currentImage];////[self crop:CGRectMake(20, 20, 100, 100)];// //  The WID.jpg example is greater than 2048 pixels tall, so it fails on older device
  
    NSLog(@"scale %f", self.choosenImage.scale);
   // self.sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
    
   // self.shaderFilter  = [[GPUImageSepiaFilter alloc] init];
    
    //custom
   // self.shaderFilter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"Shader"];
    
  //  self.shaderFilter = [[GPUImageSepiaFilter  alloc] init];
    
    //GPUImageTiltShiftFilter
    //GPUImageAddBlendFilter  GPUImageSepiaFilter  GPUImageAlphaBlendFilter
    
    //[self.shaderFilter forceProcessingAtSize:CGSizeMake(100, 100)];//InputSize:CGSizeMake(100, 100) atIndex:0];
    
  /*   GPUImageView *tempImageView = (GPUImageView *)self.imageView;//self.view;
   [self.shaderFilter forceProcessingAtSize:tempImageView.sizeInPixels]; // This is now needed to make the filter run at the smaller output size
    
    [self.sourcePicture addTarget:self.shaderFilter];
    [self.shaderFilter addTarget:tempImageView];
    
    [self.sourcePicture processImage];

    */
    GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
    embossFilter.intensity = 2.0;
  //  self.choosenImage = [self.choosenImage processInRect:testRect filter:embossFilter];
   // inputImage = [embossFilter imageByFilteringImage:inputImage];
    
   // inputImage  = [self.sourcePicture imageByFilteringImage:inputImage];
    
//    CGContextRef contextOriginalImage = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(contextOriginalImage, CGRectMake(0, 0, self.choosenImage.size.width, self.choosenImage.size.height), self.choosenImage.CGImage);
//    CGContextDrawTiledImage(contextOriginalImage, testRect, sourcePicture.newCGImageFromCurrentlyProcessedOutput);
//
//    UIImage* res = UIGraphicsGetImageFromCurrentImageContext();
   // self.choosenImage = [self.choosenImage combineImage:inputImage inRect:testRect];
           
    UIImageView* tt = [[UIImageView alloc] initWithFrame:self.imageView.frame];
    tt.image = [self.choosenImage processInRect:testRect filter:embossFilter];
    [self.view addSubview:tt];
}


- (void)addEmbossFilter
{
    GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
    embossFilter.intensity = 2.0;
    UIImage *embossedImage = [embossFilter imageByFilteringImage:self.choosenImage];
    
    UIImageView* tt = [[UIImageView alloc] initWithFrame:self.imageView.frame];
    tt.image = embossedImage;
    [self.view addSubview:tt];
}

- (void)addSepiaFilter
{

}
//add linear effect
- (void)addLinearFilter
{
    GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    GPUImagePicture *imageToProcess = [[GPUImagePicture alloc] initWithImage:self.choosenImage];
    GPUImagePicture *second = [[GPUImagePicture alloc] initWithImage:secondImage];
    
    blendFilter.mix = 0.5f;
    [imageToProcess addTarget:blendFilter];
    [second addTarget:blendFilter];
    
    [imageToProcess processImage];
    [second processImage];
    self.choosenImage = [blendFilter imageFromCurrentlyProcessedOutput];
//    [self.sourcePicture addTarget:blendFilter];
//    [self.sourcePicture processImage];

    
    GPUImageView *tempImageView = (GPUImageView *)self.imageView;//self.view;
    [blendFilter forceProcessingAtSize:tempImageView.sizeInPixels]; // This is now needed to make the filter run at the smaller output size
    
   // [self.sourcePicture addTarget:blendFilter];
    [blendFilter addTarget:tempImageView];

    //[self updateLinearFilter];
}




@end
