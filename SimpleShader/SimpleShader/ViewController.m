//
//  ViewController.m
//  SimpleShader
//
//  Created by Natasha on 16.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface ViewController ()

@end

@implementation ViewController
@synthesize shaderFilter;
@synthesize sourcePicture;
@synthesize imageSlider;
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
	GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:mainScreenFrame];
	self.view = primaryView;
    
    imageSlider = [[UISlider alloc] initWithFrame:CGRectMake(25.0, mainScreenFrame.size.height - 50.0, mainScreenFrame.size.width - 50.0, 40.0)];
    [imageSlider addTarget:self action:@selector(updateSliderValue) forControlEvents:UIControlEventValueChanged];
	imageSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    imageSlider.minimumValue = 0.0;
    imageSlider.maximumValue = 1.0;
    imageSlider.value = 0.5;
    
    [primaryView addSubview:imageSlider];
    [self setupDisplayFiltering];
}

- (void)updateSliderValue
{
//...
}


#pragma mark -
#pragma mark Image filtering

- (void)setupDisplayFiltering;
{
    UIImage *inputImage = [UIImage imageNamed:@"WID-small.jpg"]; // The WID.jpg example is greater than 2048 pixels tall, so it fails on older devices
    
    sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
    //    sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    self.shaderFilter = [[GPUImageAddBlendFilter alloc] init];//GPUImageTiltShiftFilter
    
    GPUImageView *imageView = (GPUImageView *)self.view;
    [self.shaderFilter forceProcessingAtSize:imageView.sizeInPixels]; // This is now needed to make the filter run at the smaller output size
    
    [sourcePicture addTarget:self.shaderFilter];
    [self.shaderFilter addTarget:imageView];
    
    [sourcePicture processImage];
}

@end
