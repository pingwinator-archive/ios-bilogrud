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

#define menuItemWidth 80
#define menuItemHeight 80

#define imagePreViewWidth 80
#define imagePreViewHeight 80

#define cameraIndexButton 1
#define secondImage [UIImage imageNamed:@"WID-small.jpg"]
#define defImage [UIImage imageNamed:@"image.png"]

#define offsetControllX 20.0f
#define offsetControllY 20.0f
#define imageViewHeight 290.0f
#define sliderHeight 40.0f

typedef enum {
    GPUIMAGE_SEPIA = 0,
    GPUIMAGE_PIXELLATE,
    GPUIMAGE_POLARPIXELLATE,
    GPUIMAGE_POLKADOT,
    GPUIMAGE_HALFTONE,
    GPUIMAGE_CROSSHATCH,
//    GPUIMAGE_SOBELEDGEDETECTION,
//    GPUIMAGE_PREWITTEDGEDETECTION,
//    GPUIMAGE_THRESHOLDEDGEDETECTION,
//    
//    GPUIMAGE_XYGRADIENT,
//    GPUIMAGE_HARRISCORNERDETECTION,
//    GPUIMAGE_NOBLECORNERDETECTION,
//    GPUIMAGE_SHITOMASIFEATUREDETECTION,
//    GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR,
//    GPUIMAGE_BUFFER,
//    GPUIMAGE_LOWPASS,
//    GPUIMAGE_HIGHPASS,
//    GPUIMAGE_MOTIONDETECTOR,
    GPUIMAGE_SKETCH,
    
    GPUIMAGE_THRESHOLDSKETCH,
    GPUIMAGE_TOON,
//    GPUIMAGE_SMOOTHTOON,
//    GPUIMAGE_TILTSHIFT,
    GPUIMAGE_CGA,
    GPUIMAGE_POSTERIZE,
    GPUIMAGE_CONVOLUTION,
    GPUIMAGE_EMBOSS,
    GPUIMAGE_CHROMAKEYNONBLEND,
    GPUIMAGE_KUWAHARA,
    
    GPUIMAGE_VIGNETTE,
    GPUIMAGE_GAUSSIAN,
//    GPUIMAGE_GAUSSIAN_SELECTIVE,
    GPUIMAGE_FASTBLUR,
    GPUIMAGE_BOXBLUR,
    GPUIMAGE_MEDIAN,
    
    GPUIMAGE_BILATERAL,
    GPUIMAGE_SWIRL,
    GPUIMAGE_BULGE,
    GPUIMAGE_PINCH,
    
    GPUIMAGE_SPHEREREFRACTION,
    GPUIMAGE_GLASSSPHERE,
    GPUIMAGE_STRETCH,
    GPUIMAGE_DILATION,
    GPUIMAGE_EROSION,
//    GPUIMAGE_OPENING,
//    GPUIMAGE_CLOSING,
    GPUIMAGE_PERLINNOISE,
    GPUIMAGE_MOSAIC,
      /*
    GPUIMAGE_LOCALBINARYPATTERN,
//    GPUIMAGE_DISSOLVE,
//    GPUIMAGE_CHROMAKEY, // need for 2 image
//    GPUIMAGE_ADD,// need for 2 image
//    GPUIMAGE_DIVIDE,// need for 2 image
//    GPUIMAGE_MULTIPLY,// need for 2 image
//    GPUIMAGE_OVERLAY,// need for 2 image
//    GPUIMAGE_LIGHTEN,// need for 2 image
//    GPUIMAGE_DARKEN,// need for 2 image
//    GPUIMAGE_COLORBURN,// need for 2 image
//    GPUIMAGE_COLORDODGE,// need for 2 image
//    GPUIMAGE_SCREENBLEND,// need for 2 image
//    GPUIMAGE_DIFFERENCEBLEND,
//	GPUIMAGE_SUBTRACTBLEND,
//    GPUIMAGE_EXCLUSIONBLEND,
//    GPUIMAGE_HARDLIGHTBLEND,
//    GPUIMAGE_SOFTLIGHTBLEND,
//    GPUIMAGE_NORMALBLEND,
  GPUIMAGE_OPACITY,

    
    GPUIMAGE_UIELEMENT,
    
    GPUIMAGE_FILTERGROUP,
    GPUIMAGE_FACES,*/
    GPUIMAGE_NUMFILTERS 
    
    /*
    GPUIMAGE_SATURATION,
    GPUIMAGE_CONTRAST,
    GPUIMAGE_BRIGHTNESS,
    GPUIMAGE_LEVELS,
    GPUIMAGE_EXPOSURE,
    GPUIMAGE_RGB,
    GPUIMAGE_HUE,
    GPUIMAGE_WHITEBALANCE,
    GPUIMAGE_MONOCHROME,
    GPUIMAGE_FALSECOLOR,
    GPUIMAGE_SHARPEN,
    GPUIMAGE_UNSHARPMASK,
    GPUIMAGE_TRANSFORM,
    GPUIMAGE_TRANSFORM3D,
    GPUIMAGE_CROP,
	GPUIMAGE_MASK,
    GPUIMAGE_GAMMA,
    GPUIMAGE_TONECURVE,
    GPUIMAGE_HIGHLIGHTSHADOW,
    GPUIMAGE_HAZE,
    GPUIMAGE_SEPIA,
     
    GPUIMAGE_AMATORKA,
    GPUIMAGE_MISSETIKATE,
    GPUIMAGE_SOFTELEGANCE,
    GPUIMAGE_COLORINVERT,
    GPUIMAGE_GRAYSCALE,
    GPUIMAGE_HISTOGRAM,
    GPUIMAGE_AVERAGECOLOR,
    GPUIMAGE_LUMINOSITY,
    GPUIMAGE_THRESHOLD,
    GPUIMAGE_ADAPTIVETHRESHOLD,
    GPUIMAGE_AVERAGELUMINANCETHRESHOLD,
   
    */
} GPUImageollectionFilterType;

@interface ViewController ()
@property (strong, nonatomic) UISlider* filterSettingsSlider;
@property (strong, nonatomic) UIImageView* imageView;
@property (assign, nonatomic) GPUImageollectionFilterType activeFilter;
@property (strong, nonatomic) GPUImageOutput <GPUImageInput>* filter;
@property (strong, nonatomic) UIScrollView* horisontalScrollView;
@property (strong, nonatomic) UIButton* saveButton;
@property (assign, nonatomic) BOOL hasCamera;
@property (strong, nonatomic) UIImage* choosenImage;
- (void)doTapImageView;
- (void)doTapFilterItem:(id)sender;
@end

@implementation ViewController
@synthesize filterSettingsSlider;
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
    
   
	self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(offsetControllX, offsetControllY, mainScreenFrame.size.width - offsetControllX * 2, imageViewHeight)];
    
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.image = defImage;
    self.view.userInteractionEnabled = YES;
    self.imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapImageView)];
    [tap setNumberOfTouchesRequired:1];
    [self.imageView addGestureRecognizer:tap];
   
    [self.view addSubview:self.imageView];
    
    NSLog(@" mainScreenFrame %f %f %f %f", mainScreenFrame.origin.x, mainScreenFrame.origin.y, mainScreenFrame.size.width, mainScreenFrame.size.height);
    
//    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.saveButton.frame = CGRectMake(mainScreenFrame.size.width / 2 - buttonWidth / 2, mainScreenFrame.size.height - 50.0, buttonWidth, buttonHeight);
//    [self.saveButton setTitle:@"Test" forState:UIControlStateNormal];
//    [self.saveButton addTarget:self action:@selector(saveResult) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.saveButton];
    
    self.horisontalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 320, 300, 110)];
    self.horisontalScrollView.backgroundColor = [UIColor redColor];
    self.horisontalScrollView.pagingEnabled = YES;
 
    [self.horisontalScrollView setShowsHorizontalScrollIndicator:YES];
   // self.horisontalScrollView.delegate = self;
    self.horisontalScrollView.contentSize = CGSizeMake(menuItemWidth * (GPUIMAGE_NUMFILTERS - 1) , menuItemHeight);
    
      NSLog(@"horisontalScrollView %f %f", horisontalScrollView.contentSize.width, horisontalScrollView.contentSize.height);
    
    [self.view addSubview:self.horisontalScrollView];
     UIImage* preView =  [self.choosenImage resizedImage:CGSizeMake(imagePreViewWidth, imagePreViewWidth) interpolationQuality:kCGInterpolationLow];
    for (NSInteger i = 0; i < GPUIMAGE_NUMFILTERS - 1; i++) {
        NSLog(@"%d from GPUIMAGE_NUMFILTERS  %d",i, GPUIMAGE_NUMFILTERS);
        
        //second - EmbossFilter
      //  [self setupDisplayFiltering];
       
        self.activeFilter = (GPUImageollectionFilterType)i;
        [self initFilter];
        ItemMenuView* itemImage_ = [[ItemMenuView alloc]initWithFrame:CGRectMake(i * imagePreViewWidth, 0, imagePreViewWidth , imagePreViewWidth) andImage:[self imageWithFilter:preView] withName: [self nameFilter:i]];//[self.choosenImage processInRect:testRect filter:(GPUImageFilter*)self.filter];
       // itemImage_.backgroundColor = [UIColor blueColor];
        NSLog(@"%f %f", itemImage_.frame.origin.x, itemImage_.frame.origin.y);
        UITapGestureRecognizer* tapFilter_ = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapFilterItem:)];
        [itemImage_ addGestureRecognizer:tapFilter_];
        [self.horisontalScrollView addSubview:itemImage_];
        
       
    }
    
    NSLog(@" mainScreenFrame %f %f %f %f", mainScreenFrame.origin.x, mainScreenFrame.origin.y, mainScreenFrame.size.width, mainScreenFrame.size.height);
      
    self.filterSettingsSlider = [[UISlider alloc] initWithFrame:CGRectMake(offsetControllX, mainScreenFrame.size.height + 40, mainScreenFrame.size.width - offsetControllX * 2, sliderHeight)];
    [self.filterSettingsSlider addTarget:self action:@selector(updateSliderValue) forControlEvents:UIControlEventValueChanged];
	self.filterSettingsSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.filterSettingsSlider.minimumValue = 0.0;
    self.filterSettingsSlider.maximumValue = 1.0;
    self.filterSettingsSlider.value = 0.5;
    
    //[primaryView addSubview:filterSettingsSlider];
    [self.view addSubview:self.filterSettingsSlider];
    
   // [self setupDisplayFiltering];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSString*)nameFilter:(NSInteger)index
{
    NSString* name;
    switch (index)
	{
        case GPUIMAGE_SEPIA: name = @"Sepia tone"; break;
        case GPUIMAGE_PIXELLATE: name = @"Pixellate"; break;
		case GPUIMAGE_POLARPIXELLATE: name = @"Polar pixellate"; break;
		case GPUIMAGE_POLKADOT: name = @"Polka dot"; break;
        case GPUIMAGE_HALFTONE: name = @"Halftone"; break;
		case GPUIMAGE_CROSSHATCH: name = @"Crosshatch"; break;
//		case GPUIMAGE_SOBELEDGEDETECTION: name = @"Sobel edge detection"; break;
//		case GPUIMAGE_PREWITTEDGEDETECTION: name = @"Prewitt edge detection"; break;
//		case GPUIMAGE_THRESHOLDEDGEDETECTION: name = @"Threshold edge detection"; break;
//		case GPUIMAGE_XYGRADIENT: name = @"XY derivative"; break;
//		case GPUIMAGE_HARRISCORNERDETECTION: name = @"Harris corner detection"; break;
//		case GPUIMAGE_NOBLECORNERDETECTION: name = @"Noble corner detection"; break;
//		case GPUIMAGE_SHITOMASIFEATUREDETECTION: name = @"Shi-Tomasi feature detection"; break;
//		case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR: name = @"Hough transform line detection"; break;
//		case GPUIMAGE_BUFFER: name = @"Image buffer"; break;
//        case GPUIMAGE_LOWPASS: name = @"Low pass"; break;
//		case GPUIMAGE_HIGHPASS: name = @"High pass"; break;
//        case GPUIMAGE_MOTIONDETECTOR: name = @"Motion detector"; break;

		case GPUIMAGE_SKETCH: name = @"Sketch"; break;
		case GPUIMAGE_THRESHOLDSKETCH: name = @"Threshold Sketch"; break;
		case GPUIMAGE_TOON: name = @"Toon"; break;
//		case GPUIMAGE_SMOOTHTOON: name = @"Smooth toon"; break;
//		case GPUIMAGE_TILTSHIFT: name = @"Tilt shift"; break;
		case GPUIMAGE_CGA: name = @"CGA colorspace"; break;
       
      
        case GPUIMAGE_POSTERIZE: name = @"Posterize"; break;
		case GPUIMAGE_CONVOLUTION: name = @"3x3 convolution"; break;
		case GPUIMAGE_EMBOSS: name = @"Emboss"; break;
//		case GPUIMAGE_CHROMAKEYNONBLEND: name = @"Chroma key"; break;
        case GPUIMAGE_KUWAHARA: name = @"Kuwahara"; break;
       
        case GPUIMAGE_VIGNETTE: name = @"Vignette"; break;
        case GPUIMAGE_GAUSSIAN: name = @"Gaussian blur"; break;
            //        case GPUIMAGE_GAUSSIAN_SELECTIVE: name = @"Gaussian selective blur"; break;
        case GPUIMAGE_FASTBLUR: name = @"Fast blur"; break;
        case GPUIMAGE_BOXBLUR: name = @"Box blur"; break;
        case GPUIMAGE_MEDIAN: name = @"Median (3x3)"; break;
        case GPUIMAGE_BILATERAL: name = @"Bilateral blur"; break;
            

		case GPUIMAGE_SWIRL: name = @"Swirl"; break;
		case GPUIMAGE_BULGE: name = @"Bulge"; break;
        case GPUIMAGE_PINCH: name = @"Pinch"; break;
		case GPUIMAGE_SPHEREREFRACTION: name = @"Sphere refraction"; break;
		case GPUIMAGE_GLASSSPHERE: name = @"Glass sphere"; break;
		
		case GPUIMAGE_STRETCH: name = @"Stretch"; break;
		case GPUIMAGE_DILATION: name = @"Dilation"; break;
		case GPUIMAGE_EROSION: name = @"Erosion"; break;
//		case GPUIMAGE_OPENING: name = @"Opening"; break;
//		case GPUIMAGE_CLOSING: name = @"Closing"; break;
        case GPUIMAGE_PERLINNOISE: name = @"Perlin noise"; break;
        case GPUIMAGE_MOSAIC: name = @"Mosaic"; break;
 //!!       case GPUIMAGE_LOCALBINARYPATTERN: name = @"Local binary pattern"; break;
       
       
//		case GPUIMAGE_DISSOLVE: name = @"Dissolve blend"; break;
//      case GPUIMAGE_CHROMAKEY: name = @"Chroma key blend (green)"; break;
//		case GPUIMAGE_ADD: name = @"Add blend"; break;
//		case GPUIMAGE_DIVIDE: name = @"Divide blend"; break;
//		case GPUIMAGE_MULTIPLY: name = @"Multiply blend"; break;
//	    case GPUIMAGE_OVERLAY: name = @"Overlay blend"; break;
//	    case GPUIMAGE_LIGHTEN: name = @"Lighten blend"; break;
//	    case GPUIMAGE_DARKEN: name = @"Darken blend"; break;
//	   	case GPUIMAGE_COLORBURN: name = @"Color burn blend"; break;
//		case GPUIMAGE_COLORDODGE: name = @"Color dodge blend"; break;
//        case GPUIMAGE_SCREENBLEND: name = @"Screen blend"; break;
//        case GPUIMAGE_DIFFERENCEBLEND: name = @"Difference blend"; break;
//        case GPUIMAGE_SUBTRACTBLEND: name = @"Subtract blend"; break;
//        case GPUIMAGE_EXCLUSIONBLEND: name = @"Exclusion blend"; break;
//	    case GPUIMAGE_HARDLIGHTBLEND: name = @"Hard light blend"; break;
//	    case GPUIMAGE_SOFTLIGHTBLEND: name = @"Soft light blend"; break;
//	    case GPUIMAGE_NORMALBLEND: name = @"Normal blend"; break;
            
            

// !!
//	    case GPUIMAGE_OPACITY: name = @"Opacity adjustment"; break;
//        case GPUIMAGE_UIELEMENT: name = @"UI element"; break;
//        case GPUIMAGE_FILTERGROUP: name = @"Filter Group"; break;
       
 
//        case GPUIMAGE_FACES: name = @"Face Detection"; break;
 /*
		case GPUIMAGE_SATURATION: name = @"Saturation"; break;
		case GPUIMAGE_CONTRAST: name = @"Contrast"; break;
		case GPUIMAGE_BRIGHTNESS: name = @"Brightness"; break;
		case GPUIMAGE_LEVELS: name = @"Levels"; break;
		case GPUIMAGE_EXPOSURE: name = @"Exposure"; break;
        case GPUIMAGE_RGB: name = @"RGB"; break;
        case GPUIMAGE_HUE: name = @"Hue"; break;
        case GPUIMAGE_WHITEBALANCE: name = @"White balance"; break;
        case GPUIMAGE_MONOCHROME: name = @"Monochrome"; break;
        case GPUIMAGE_FALSECOLOR: name = @"False color"; break;
		case GPUIMAGE_SHARPEN: name = @"Sharpen"; break;
		case GPUIMAGE_UNSHARPMASK: name = @"Unsharp mask"; break;
		case GPUIMAGE_GAMMA: name = @"Gamma"; break;
		case GPUIMAGE_TONECURVE: name = @"Tone curve"; break;
		case GPUIMAGE_HIGHLIGHTSHADOW: name = @"Highlights and shadows"; break;
		case GPUIMAGE_HAZE: name = @"Haze"; break;
        
        case GPUIMAGE_HISTOGRAM: name = @"Histogram"; break;
        case GPUIMAGE_AVERAGECOLOR: name = @"Average color"; break;
        case GPUIMAGE_LUMINOSITY: name = @"Luminosity"; break;
		case GPUIMAGE_THRESHOLD: name = @"Threshold"; break;
		case GPUIMAGE_ADAPTIVETHRESHOLD: name = @"Adaptive threshold"; break;
		case GPUIMAGE_AVERAGELUMINANCETHRESHOLD: name = @"Average luminance threshold"; break;
        case GPUIMAGE_CROP: name = @"Crop"; break;
        case GPUIMAGE_TRANSFORM: name = @"Transform (2-D)"; break;
        case GPUIMAGE_TRANSFORM3D: name = @"Transform (3-D)"; break;
		case GPUIMAGE_MASK: name = @"Mask"; break;
        case GPUIMAGE_COLORINVERT: name = @"Color invert"; break;
        case GPUIMAGE_GRAYSCALE: name = @"Grayscale"; break;
				case GPUIMAGE_MISSETIKATE: name = @"Miss Etikate (Lookup)"; break;
		case GPUIMAGE_SOFTELEGANCE: name = @"Soft elegance (Lookup)"; break;
		case GPUIMAGE_AMATORKA: name = @"Amatorka (Lookup)"; break;
		
		 */
	}
    return name;
}



-(void)doTapFilterItem:(UITapGestureRecognizer*)sender
{
    NSLog(@"tap filter %@", sender);
    
    
    self.activeFilter = GPUIMAGE_SEPIA;
    [self setupDisplayFiltering];
//    self.horisontalScrollView.co
}

- (UIImage*)currentImage
{
    return (self.choosenImage)?self.choosenImage:defImage;
}

- (void)updateSliderValue
{
    CGFloat midpoint = self.filterSettingsSlider.value;
    
  //!!
            //[(GPUImageAlphaBlendFilter*)self.filter setMix:0.5f];
}

- (void)updateImage
{
    self.imageView.image = self.choosenImage;
}
- (void)doTapImageView//:(UILongPressGestureRecognizer*)recognizer
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
        [self updateImage];
       // [self setupDisplayFiltering];
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

#pragma mark -
#pragma mark Image filtering


- (void)setupDisplayFiltering
{
    NSLog(@"size %f %f", self.choosenImage.size.height, self.choosenImage.size.width);
    CGFloat middleX = self.choosenImage.size.width / 2;
    //CGFloat middleY = self.choosenImage.size.height / 2;
    
    CGRect testRect = CGRectMake(0, 0, middleX, self.choosenImage.size.height);
  
  
    NSLog(@"scale %f", self.choosenImage.scale);
   
    [self initFilter];
  
//    GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
//    embossFilter.intensity = 2.0;
    
    self.imageView.image = [self.choosenImage processInRect:testRect filter:(GPUImageFilter*)self.filter];
//    UIImageView* tt = [[UIImageView alloc] initWithFrame:self.imageView.frame];
//    tt.image = [self.choosenImage processInRect:testRect filter:embossFilter];
//    [self.view addSubview:tt];
}

- (UIImage*)imageWithFilter:(UIImage*)image
{
    NSLog(@"size %f %f", image.size.height, image.size.width);
    
    CGRect testRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    
    NSLog(@"scale %f", image.scale);
    
    [self initFilter];
    
    //    GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
    //    embossFilter.intensity = 2.0;
    
    return [image processInRect:testRect filter:(GPUImageFilter*)self.filter];
    //    UIImageView* tt = [[UIImageView alloc] initWithFrame:self.imageView.frame];
    //    tt.image = [self.choosenImage processInRect:testRect filter:embossFilter];
    //    [self.view addSubview:tt];
}


- (void)initFilter
{
    switch (self.activeFilter)
    {
        case GPUIMAGE_SEPIA:
        {
            self.title = @"Sepia Tone";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            self.filter = [[GPUImageSepiaFilter alloc] init];
        }; break;
        case GPUIMAGE_PIXELLATE:
        {
            self.title = @"Pixellate";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.15];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.3];
            
            self.filter = [[GPUImagePixellateFilter alloc] init];
        }; break;
        case GPUIMAGE_POLARPIXELLATE:
        {
            self.title = @"Polar Pixellate";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:-0.1];
            [self.filterSettingsSlider setMaximumValue:0.1];
            
            self.filter = [[GPUImagePolarPixellateFilter alloc] init];
        }; break;
        case GPUIMAGE_POLKADOT:
        {
            self.title = @"Polka Dot";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.3];
            
            self.filter = [[GPUImagePolkaDotFilter alloc] init];
        }; break;
        case GPUIMAGE_HALFTONE:
        {
            self.title = @"Halftone";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.01];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.05];
            
            self.filter = [[GPUImageHalftoneFilter alloc] init];
        }; break;
        case GPUIMAGE_CROSSHATCH:
        {
            self.title = @"Crosshatch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.03];
            [self.filterSettingsSlider setMinimumValue:0.01];
            [self.filterSettingsSlider setMaximumValue:0.06];
            
            self.filter = [[GPUImageCrosshatchFilter alloc] init];
        }; break;
            
            
            //            case GPUIMAGE_SOBELEDGEDETECTION:
            //            {
            //            self.title = @"Sobel Edge Detection";
            //            self.filterSettingsSlider.hidden = YES;
            //
            //            filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
            //            }; break;
            //        case GPUIMAGE_PREWITTEDGEDETECTION:
            //        {
            //            self.title = @"Prewitt Edge Detection";
            //            self.filterSettingsSlider.hidden = YES;
            //
            //            filter = [[GPUImagePrewittEdgeDetectionFilter alloc] init];
            //        }; break;
            //
            //        case GPUIMAGE_THRESHOLDEDGEDETECTION:
            //        {
            //            self.title = @"Threshold Edge Detection";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:1.0];
            //            [self.filterSettingsSlider setValue:0.5];
            //
            //            filter = [[GPUImageThresholdEdgeDetectionFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_XYGRADIENT:
            //        {
            //            self.title = @"XY Derivative";
            //            self.filterSettingsSlider.hidden = YES;
            //
            //            filter = [[GPUImageXYDerivativeFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_HARRISCORNERDETECTION:
            //        {
            //            self.title = @"Harris Corner Detection";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.01];
            //            [self.filterSettingsSlider setMaximumValue:0.70];
            //            [self.filterSettingsSlider setValue:0.20];
            //
            //            filter = [[GPUImageHarrisCornerDetectionFilter alloc] init];
            //            [(GPUImageHarrisCornerDetectionFilter *)filter setThreshold:0.20];
            //        }; break;
            //        case GPUIMAGE_NOBLECORNERDETECTION:
            //        {
            //            self.title = @"Noble Corner Detection";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.01];
            //            [self.filterSettingsSlider setMaximumValue:0.70];
            //            [self.filterSettingsSlider setValue:0.20];
            //
            //            filter = [[GPUImageNobleCornerDetectionFilter alloc] init];
            //            [(GPUImageNobleCornerDetectionFilter *)filter setThreshold:0.20];
            //        }; break;
            //        case GPUIMAGE_SHITOMASIFEATUREDETECTION:
            //        {
            //            self.title = @"Shi-Tomasi Feature Detection";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.01];
            //            [self.filterSettingsSlider setMaximumValue:0.70];
            //            [self.filterSettingsSlider setValue:0.20];
            //
            //            filter = [[GPUImageShiTomasiFeatureDetectionFilter alloc] init];
            //            [(GPUImageShiTomasiFeatureDetectionFilter *)filter setThreshold:0.20];
            //        }; break;
            //        case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR:
            //        {
            //            self.title = @"Line Detection";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.2];
            //            [self.filterSettingsSlider setMaximumValue:1.0];
            //            [self.filterSettingsSlider setValue:0.6];
            //
            //            filter = [[GPUImageHoughTransformLineDetector alloc] init];
            //            [(GPUImageHoughTransformLineDetector *)filter setLineDetectionThreshold:0.60];
            //        }; break;
            //        case GPUIMAGE_BUFFER:
            //        {
            //            self.title = @"Image Buffer";
            //            self.filterSettingsSlider.hidden = YES;
            //
            //            filter = [[GPUImageBuffer alloc] init];
            //        }; break;
            
            //group
            //        case GPUIMAGE_LOWPASS:
            //        {
            //            self.title = @"Low Pass";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:1.0];
            //            [self.filterSettingsSlider setValue:0.5];
            //
            //            filter = [[GPUImageLowPassFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_HIGHPASS:
            //        {
            //            self.title = @"High Pass";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:1.0];
            //            [self.filterSettingsSlider setValue:0.5];
            //
            //            filter = [[GPUImageHighPassFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_MOTIONDETECTOR:
            //        {
            //            [videoCamera rotateCamera];
            //
            //            self.title = @"Motion Detector";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:1.0];
            //            [self.filterSettingsSlider setValue:0.5];
            //
            //            filter = [[GPUImageMotionDetector alloc] init];
            //        }; break;
        case GPUIMAGE_SKETCH:
        {
            self.title = @"Sketch";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageSketchFilter alloc] init];
        }; break;
        case GPUIMAGE_THRESHOLDSKETCH:
        {
            self.title = @"Threshold Sketch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.9];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.9];
            
            filter = [[GPUImageThresholdSketchFilter alloc] init];
        }; break;
        case GPUIMAGE_TOON:
        {
            self.title = @"Toon";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageToonFilter alloc] init];
        }; break;
            //        case GPUIMAGE_SMOOTHTOON:
            //        {
            //            self.title = @"Smooth Toon";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:1.0];
            //            [self.filterSettingsSlider setValue:0.5];
            //
            //            filter = [[GPUImageSmoothToonFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_TILTSHIFT:
            //        {
            //            self.title = @"Tilt Shift";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.2];
            //            [self.filterSettingsSlider setMaximumValue:0.8];
            //            [self.filterSettingsSlider setValue:0.5];
            //
            //            filter = [[GPUImageTiltShiftFilter alloc] init];
            //            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.4];
            //            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.6];
            //            [(GPUImageTiltShiftFilter *)filter setFocusFallOffRate:0.2];
            //        }; break;
        case GPUIMAGE_CGA:
        {
            self.title = @"CGA Colorspace";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageCGAColorspaceFilter alloc] init];
        }; break;

        case GPUIMAGE_POSTERIZE:
        {
            self.title = @"Posterize";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:20.0];
            [self.filterSettingsSlider setValue:10.0];
            
            filter = [[GPUImagePosterizeFilter alloc] init];
        }; break;
        case GPUIMAGE_CONVOLUTION:
        {
            self.title = @"3x3 Convolution";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImage3x3ConvolutionFilter alloc] init];
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                {-2.0f, -1.0f, 0.0f},
            //                {-1.0f,  1.0f, 1.0f},
            //                { 0.0f,  1.0f, 2.0f}
            //            }];
            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
                {-1.0f,  0.0f, 1.0f},
                {-2.0f, 0.0f, 2.0f},
                {-1.0f,  0.0f, 1.0f}
            }];
            
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                {1.0f,  1.0f, 1.0f},
            //                {1.0f, -8.0f, 1.0f},
            //                {1.0f,  1.0f, 1.0f}
            //            }];
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                { 0.11f,  0.11f, 0.11f},
            //                { 0.11f,  0.11f, 0.11f},
            //                { 0.11f,  0.11f, 0.11f}
            //            }];
        }; break;
        case GPUIMAGE_EMBOSS:
        {
            self.title = @"Emboss";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:5.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageEmbossFilter alloc] init];
        }; break;
        case GPUIMAGE_CHROMAKEYNONBLEND:
        {
            self.title = @"Chroma Key (Green)";
            self.filterSettingsSlider.hidden = NO;
            //  needsSecondImage = YES;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.4];
            
            filter = [[GPUImageChromaKeyFilter alloc] init];
            [(GPUImageChromaKeyFilter *)filter setColorToReplaceRed:0.0 green:1.0 blue:0.0];
        }; break;
            
        case GPUIMAGE_KUWAHARA:
        {
            self.title = @"Kuwahara";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:3.0];
            [self.filterSettingsSlider setMaximumValue:8.0];
            [self.filterSettingsSlider setValue:3.0];
            
            filter = [[GPUImageKuwaharaFilter alloc] init];
        }; break;
        case GPUIMAGE_VIGNETTE:
        {
            self.title = @"Vignette";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.5];
            [self.filterSettingsSlider setMaximumValue:0.9];
            [self.filterSettingsSlider setValue:0.75];
            
            filter = [[GPUImageVignetteFilter alloc] init];
        }; break;
        case GPUIMAGE_GAUSSIAN:
        {
            self.title = @"Gaussian Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:10.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageGaussianBlurFilter alloc] init];
        }; break;
            //        case GPUIMAGE_GAUSSIAN_SELECTIVE:
            //        {
            //            self.title = @"Selective Blur";
            //            self.filterSettingsSlider.hidden = NO;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:.75f];
            //            [self.filterSettingsSlider setValue:40.0/320.0];
            //
            //            filter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
            //            [(GPUImageGaussianSelectiveBlurFilter*)filter setExcludeCircleRadius:40.0/320.0];
            //        }; break;
        case GPUIMAGE_FASTBLUR:
        {
            self.title = @"Fast Blur";
            self.filterSettingsSlider.hidden = NO;
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:10.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageFastBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_BOXBLUR:
        {
            self.title = @"Box Blur";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageBoxBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_MEDIAN:
        {
            self.title = @"Median";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageMedianFilter alloc] init];
        }; break;
        case GPUIMAGE_BILATERAL:
        {
            self.title = @"Bilateral Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:10.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageBilateralFilter alloc] init];
        }; break;
            
            
        case GPUIMAGE_SWIRL:
        {
            self.title = @"Swirl";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageSwirlFilter alloc] init];
        }; break;
        case GPUIMAGE_BULGE:
        {
            self.title = @"Bulge";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-1.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImageBulgeDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_PINCH:
        {
            self.title = @"Pinch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-2.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImagePinchDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_SPHEREREFRACTION:
        {
            self.title = @"Sphere Refraction";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.15];
            
            filter = [[GPUImageSphereRefractionFilter alloc] init];
            [(GPUImageSphereRefractionFilter *)filter setRadius:0.15];
        }; break;
        case GPUIMAGE_GLASSSPHERE:
        {
            self.title = @"Glass Sphere";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.15];
            
            filter = [[GPUImageGlassSphereFilter alloc] init];
            [(GPUImageGlassSphereFilter *)filter setRadius:0.15];
        }; break;
        case GPUIMAGE_STRETCH:
        {
            self.title = @"Stretch";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageStretchDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_DILATION:
        {
            self.title = @"Dilation";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageRGBDilationFilter alloc] initWithRadius:4];
        }; break;
        case GPUIMAGE_EROSION:
        {
            self.title = @"Erosion";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageRGBErosionFilter alloc] initWithRadius:4];
        }; break;
            //        case GPUIMAGE_OPENING:
            //        {
            //            self.title = @"Opening";
            //            self.filterSettingsSlider.hidden = YES;
            //
            //            filter = [[GPUImageRGBOpeningFilter alloc] initWithRadius:4];
            //        }; break;
            //        case GPUIMAGE_CLOSING:
            //        {
            //            self.title = @"Closing";
            //            self.filterSettingsSlider.hidden = YES;
            //
            //            filter = [[GPUImageRGBClosingFilter alloc] initWithRadius:4];
            //        }; break;
            
        case GPUIMAGE_PERLINNOISE:
        {
            self.title = @"Perlin Noise";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:30.0];
            [self.filterSettingsSlider setValue:8.0];
            
            filter = [[GPUImagePerlinNoiseFilter alloc] init];
        }; break;
        case GPUIMAGE_MOSAIC:
        {
            self.title = @"Mosaic";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.002];
            [self.filterSettingsSlider setMaximumValue:0.05];
            [self.filterSettingsSlider setValue:0.025];
            
            filter = [[GPUImageMosaicFilter alloc] init];
            [(GPUImageMosaicFilter *)filter setTileSet:@"squares.png"];
            [(GPUImageMosaicFilter *)filter setColorOn:NO];
            //[(GPUImageMosaicFilter *)filter setTileSet:@"dotletterstiles.png"];
            //[(GPUImageMosaicFilter *)filter setTileSet:@"curvies.png"];
            
            [filter setInputRotation:kGPUImageRotateRight atIndex:0];
            
        }; break;
  //!!
            /*
        case GPUIMAGE_LOCALBINARYPATTERN:
        {
            self.title = @"Local Binary Pattern";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:5.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageLocalBinaryPatternFilter alloc] init];
        }; break;
             */
            //        case GPUIMAGE_DISSOLVE:
            //        {
            //            self.title = @"Dissolve Blend";
            //            self.filterSettingsSlider.hidden = NO;
            //            needsSecondImage = YES;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:1.0];
            //            [self.filterSettingsSlider setValue:0.5];
            //
            //            filter = [[GPUImageDissolveBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_CHROMAKEY:
            //        {
            //            self.title = @"Chroma Key (Green)";
            //            self.filterSettingsSlider.hidden = NO;
            //            needsSecondImage = YES;
            //
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:1.0];
            //            [self.filterSettingsSlider setValue:0.4];
            //
            //            filter = [[GPUImageChromaKeyBlendFilter alloc] init];
            //            [(GPUImageChromaKeyBlendFilter *)filter setColorToReplaceRed:0.0 green:1.0 blue:0.0];
            //        }; break;
            //
            //        case GPUIMAGE_ADD:
            //        {
            //            self.title = @"Add Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageAddBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_DIVIDE:
            //        {
            //            self.title = @"Divide Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageDivideBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_MULTIPLY:
            //        {
            //            self.title = @"Multiply Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageMultiplyBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_OVERLAY:
            //        {
            //            self.title = @"Overlay Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageOverlayBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_LIGHTEN:
            //        {
            //            self.title = @"Lighten Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageLightenBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_DARKEN:
            //        {
            //            self.title = @"Darken Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //
            //            needsSecondImage = YES;
            //            filter = [[GPUImageDarkenBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_COLORBURN:
            //        {
            //            self.title = @"Color Burn Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageColorBurnBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_COLORDODGE:
            //        {
            //            self.title = @"Color Dodge Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageColorDodgeBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_SCREENBLEND:
            //        {
            //            self.title = @"Screen Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageScreenBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_DIFFERENCEBLEND:
            //        {
            //            self.title = @"Difference Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageDifferenceBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_SUBTRACTBLEND:
            //        {
            //            self.title = @"Subtract Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageSubtractBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_EXCLUSIONBLEND:
            //        {
            //            self.title = @"Exclusion Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageExclusionBlendFilter alloc] init];
            //        }; break;
            //
            //        case GPUIMAGE_HARDLIGHTBLEND:
            //        {
            //            self.title = @"Hard Light Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageHardLightBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_SOFTLIGHTBLEND:
            //        {
            //            self.title = @"Soft Light Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageSoftLightBlendFilter alloc] init];
            //        }; break;
            //        case GPUIMAGE_NORMALBLEND:
            //        {
            //            self.title = @"Normal Blend";
            //            self.filterSettingsSlider.hidden = YES;
            //            needsSecondImage = YES;
            //
            //            filter = [[GPUImageNormalBlendFilter alloc] init];
            //        }; break;
  /*
        case GPUIMAGE_OPACITY:
        {
            self.title = @"Opacity Adjustment";
            self.filterSettingsSlider.hidden = NO;
            //needsSecondImage = YES;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            filter = [[GPUImageOpacityFilter alloc] init];
        }; break;
        case GPUIMAGE_UIELEMENT:
        {
            self.title = @"UI Element";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageSepiaFilter alloc] init];
        }; break;
            
            
        case GPUIMAGE_FILTERGROUP:
        {
            self.title = @"Filter Group";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.3];
            
            self.filter = [[GPUImageFilterGroup alloc] init];
            
            GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
            [(GPUImageFilterGroup *)filter addFilter:sepiaFilter];
            
            GPUImagePixellateFilter *pixellateFilter = [[GPUImagePixellateFilter alloc] init];
            [(GPUImageFilterGroup *)filter addFilter:pixellateFilter];
            
            [sepiaFilter addTarget:pixellateFilter];
            [(GPUImageFilterGroup *)filter setInitialFilters:[NSArray arrayWithObject:sepiaFilter]];
            [(GPUImageFilterGroup *)filter setTerminalFilter:pixellateFilter];
        }; break;
        */
            //        case GPUIMAGE_FACES:
            //        {
            //            facesSwitch.hidden = NO;
            //            facesLabel.hidden = NO;
            //
            //            [videoCamera rotateCamera];
            //            self.title = @"Face Detection";
            //            self.filterSettingsSlider.hidden = YES;
            //
            //            [self.filterSettingsSlider setValue:1.0];
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:2.0];
            //
            //            filter = [[GPUImageSaturationFilter alloc] init];
            //            [videoCamera setDelegate:self];
            //            break;
            //        }

            

            /*    case GPUIMAGE_COLORINVERT:
             {
             self.title = @"Color Invert";
             self.filterSettingsSlider.hidden = YES;
             
             filter = [[GPUImageColorInvertFilter alloc] init];
             }; break;
             case GPUIMAGE_GRAYSCALE:
             {
             self.title = @"Grayscale";
             self.filterSettingsSlider.hidden = YES;
             
             filter = [[GPUImageGrayscaleFilter alloc] init];
             }; break;
             case GPUIMAGE_MONOCHROME:
             {
             self.title = @"Monochrome";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setValue:1.0];
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:1.0];
             
             filter = [[GPUImageMonochromeFilter alloc] init];
             [(GPUImageMonochromeFilter *)filter setColor:(GPUVector4){0.0f, 0.0f, 1.0f, 1.f}];
             }; break;
             case GPUIMAGE_FALSECOLOR:
             {
             self.title = @"False Color";
             self.filterSettingsSlider.hidden = YES;
             
             filter = [[GPUImageFalseColorFilter alloc] init];
             }; break;
             case GPUIMAGE_SOFTELEGANCE:
             {
             self.title = @"Soft Elegance (Lookup)";
             self.filterSettingsSlider.hidden = YES;
             
             filter = [[GPUImageSoftEleganceFilter alloc] init];
             }; break;
             case GPUIMAGE_MISSETIKATE:
             {
             self.title = @"Miss Etikate (Lookup)";
             self.filterSettingsSlider.hidden = YES;
             
             filter = [[GPUImageMissEtikateFilter alloc] init];
             }; break;
             case GPUIMAGE_AMATORKA:
             {
             self.title = @"Amatorka (Lookup)";
             self.filterSettingsSlider.hidden = YES;
             
             filter = [[GPUImageAmatorkaFilter alloc] init];
             }; break;
             
             case GPUIMAGE_SATURATION:
             {
             self.title = @"Saturation";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setValue:1.0];
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:2.0];
             
             filter = [[GPUImageSaturationFilter alloc] init];
             }; break;
             case GPUIMAGE_CONTRAST:
             {
             self.title = @"Contrast";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:4.0];
             [self.filterSettingsSlider setValue:1.0];
             
             filter = [[GPUImageContrastFilter alloc] init];
             }; break;
             case GPUIMAGE_BRIGHTNESS:
             {
             self.title = @"Brightness";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:-1.0];
             [self.filterSettingsSlider setMaximumValue:1.0];
             [self.filterSettingsSlider setValue:0.0];
             
             filter = [[GPUImageBrightnessFilter alloc] init];
             }; break;
             case GPUIMAGE_LEVELS:
             {
             self.title = @"Levels";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:1.0];
             [self.filterSettingsSlider setValue:0.0];
             
             filter = [[GPUImageLevelsFilter alloc] init];
             }; break;
             case GPUIMAGE_RGB:
             {
             self.title = @"RGB";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:2.0];
             [self.filterSettingsSlider setValue:1.0];
             
             filter = [[GPUImageRGBFilter alloc] init];
             }; break;
             case GPUIMAGE_HUE:
             {
             self.title = @"Hue";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:360.0];
             [self.filterSettingsSlider setValue:90.0];
             
             filter = [[GPUImageHueFilter alloc] init];
             }; break;
             case GPUIMAGE_WHITEBALANCE:
             {
             self.title = @"White Balance";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:2500.0];
             [self.filterSettingsSlider setMaximumValue:7500.0];
             [self.filterSettingsSlider setValue:5000.0];
             
             filter = [[GPUImageWhiteBalanceFilter alloc] init];
             }; break;
             case GPUIMAGE_EXPOSURE:
             {
             self.title = @"Exposure";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:-4.0];
             [self.filterSettingsSlider setMaximumValue:4.0];
             [self.filterSettingsSlider setValue:0.0];
             
             filter = [[GPUImageExposureFilter alloc] init];
             }; break;
             case GPUIMAGE_SHARPEN:
             {
             self.title = @"Sharpen";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:-1.0];
             [self.filterSettingsSlider setMaximumValue:4.0];
             [self.filterSettingsSlider setValue:0.0];
             
             filter = [[GPUImageSharpenFilter alloc] init];
             }; break;
             case GPUIMAGE_UNSHARPMASK:
             {
             self.title = @"Unsharp Mask";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:5.0];
             [self.filterSettingsSlider setValue:1.0];
             
             filter = [[GPUImageUnsharpMaskFilter alloc] init];
             
             //            [(GPUImageUnsharpMaskFilter *)filter setIntensity:3.0];
             }; break;
             case GPUIMAGE_GAMMA:
             {
             self.title = @"Gamma";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:3.0];
             [self.filterSettingsSlider setValue:1.0];
             
             filter = [[GPUImageGammaFilter alloc] init];
             }; break;
             case GPUIMAGE_TONECURVE:
             {
             self.title = @"Tone curve";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:1.0];
             [self.filterSettingsSlider setValue:0.5];
             
             filter = [[GPUImageToneCurveFilter alloc] init];
             [(GPUImageToneCurveFilter *)filter setBlueControlPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)], nil]];
             }; break;
             case GPUIMAGE_HIGHLIGHTSHADOW:
             {
             self.title = @"Highlights and Shadows";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setValue:1.0];
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:1.0];
             
             filter = [[GPUImageHighlightShadowFilter alloc] init];
             }; break;
             case GPUIMAGE_HAZE:
             {
             self.title = @"Haze / UV";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:-0.2];
             [self.filterSettingsSlider setMaximumValue:0.2];
             [self.filterSettingsSlider setValue:0.2];
             
             filter = [[GPUImageHazeFilter alloc] init];
             }; break;
             case GPUIMAGE_AVERAGECOLOR:
             {
             self.title = @"Average Color";
             self.filterSettingsSlider.hidden = YES;
             
             filter = [[GPUImageAverageColor alloc] init];
             }; break;
             case GPUIMAGE_LUMINOSITY:
             {
             self.title = @"Luminosity";
             self.filterSettingsSlider.hidden = YES;
             
             filter = [[GPUImageLuminosity alloc] init];
             }; break;
             case GPUIMAGE_HISTOGRAM:
             {
             self.title = @"Histogram";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:4.0];
             [self.filterSettingsSlider setMaximumValue:32.0];
             [self.filterSettingsSlider setValue:16.0];
             
             filter = [[GPUImageHistogramFilter alloc] initWithHistogramType:kGPUImageHistogramRGB];
             }; break;
             case GPUIMAGE_THRESHOLD:
             {
             self.title = @"Luminance Threshold";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:1.0];
             [self.filterSettingsSlider setValue:0.5];
             
             filter = [[GPUImageLuminanceThresholdFilter alloc] init];
             }; break;
             case GPUIMAGE_ADAPTIVETHRESHOLD:
             {
             self.title = @"Adaptive Threshold";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:1.0];
             [self.filterSettingsSlider setMaximumValue:20.0];
             [self.filterSettingsSlider setValue:1.0];
             
             filter = [[GPUImageAdaptiveThresholdFilter alloc] init];
             }; break;
             case GPUIMAGE_AVERAGELUMINANCETHRESHOLD:
             {
             self.title = @"Avg. Lum. Threshold";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:2.0];
             [self.filterSettingsSlider setValue:1.0];
             
             filter = [[GPUImageAverageLuminanceThresholdFilter alloc] init];
             }; break;
             case GPUIMAGE_CROP:
             {
             self.title = @"Crop";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.2];
             [self.filterSettingsSlider setMaximumValue:1.0];
             [self.filterSettingsSlider setValue:0.5];
             
             filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.25)];
             }; break;
             case GPUIMAGE_MASK:
             {
             self.title = @"Mask";
             self.filterSettingsSlider.hidden = YES;
             needsSecondImage = YES;
             
             filter = [[GPUImageMaskFilter alloc] init];
             
             [(GPUImageFilter*)filter setBackgroundColorRed:0.0 green:1.0 blue:0.0 alpha:1.0];
             }; break;
             case GPUIMAGE_TRANSFORM:
             {
             self.title = @"Transform (2-D)";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:6.28];
             [self.filterSettingsSlider setValue:2.0];
             
             filter = [[GPUImageTransformFilter alloc] init];
             [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(2.0)];
             //            [(GPUImageTransformFilter *)filter setIgnoreAspectRatio:YES];
             }; break;
             case GPUIMAGE_TRANSFORM3D:
             {
             self.title = @"Transform (3-D)";
             self.filterSettingsSlider.hidden = NO;
             
             [self.filterSettingsSlider setMinimumValue:0.0];
             [self.filterSettingsSlider setMaximumValue:6.28];
             [self.filterSettingsSlider setValue:0.75];
             
             filter = [[GPUImageTransformFilter alloc] init];
             CATransform3D perspectiveTransform = CATransform3DIdentity;
             perspectiveTransform.m34 = 0.4;
             perspectiveTransform.m33 = 0.4;
             perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
             perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.75, 0.0, 1.0, 0.0);
             
             [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
             }; break;
             
             
             
             
             */
        default: filter = [[GPUImageSepiaFilter alloc] init]; break;
    }
 

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
