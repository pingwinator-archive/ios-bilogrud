//
//  ViewController.m
//  PhotoMultipleExposure
//
//  Created by Natasha on 14.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "UIImage+RoundedCorner.h"
#import "PhotoView.h"
#include <QuartzCore/QuartzCore.h>
@interface ViewController ()
@property (retain, nonatomic) PhotoView* commonPhotoView;
@property (retain, nonatomic) UIImageView* firstLayerImageView;
@property (retain, nonatomic) UIImageView* secondLayerImageView;
@property (retain, nonatomic) UIButton* preViewFirst;
@property (retain, nonatomic) UIButton* preViewSecond;
@property (retain, nonatomic) UISlider* firstImageSlider;
@property (retain, nonatomic) UISlider* secondImageSlider;
@property (retain, nonatomic) UIImage* firstImage;
@property (retain, nonatomic) UIImage* secondImage;
@property (retain, nonatomic) UIImage* choosenImage;
@property (retain, nonatomic) UIButton* saveResult;
@property (assign, nonatomic) PhotoSliderNumber activeSlider;
@property (assign, nonatomic) BOOL hasCamera;
@end

@implementation ViewController
@synthesize firstLayerImageView;
@synthesize secondLayerImageView;
@synthesize preViewFirst;
@synthesize preViewSecond;
@synthesize firstImageSlider;
@synthesize secondImageSlider;
@synthesize hasCamera;
@synthesize firstImage;
@synthesize secondImage;
@synthesize resultImage;
@synthesize commonPhotoView;
@synthesize choosenImage;
@synthesize activeSlider;
@synthesize saveResult;
- (void)dealloc
{
    self.firstImageSlider = nil;
    self.secondImageSlider = nil;
    self.preViewFirst = nil;
    self.preViewSecond = nil;
    self.firstLayerImageView = nil;
    self.secondLayerImageView = nil;
    self.firstImage = nil;
    self.secondImage = nil;
    self.resultImage = nil;
    self.commonPhotoView = nil;
    self.choosenImage = nil;
    self.saveResult = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.hasCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera];
    
    if(isiPhone) {
        [self addControllsForIPhone];
    } else {
        //...
    }
}

- (void)addControllsForIPhone
{
 
    CGRect buttonRect = CGRectMake(20, 20, 40, 40);
    CGRect sliderRect = CGRectMake(110, 20, 170, 50);
    self.preViewFirst = [[[UIButton alloc] initWithFrame:buttonRect] autorelease];
    self.preViewFirst.contentMode = UIViewContentModeScaleToFill;
    [self.preViewFirst setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [self.preViewFirst addTarget:self action:@selector(firstPreViewPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(doLongPress:)];
    [self.preViewFirst addGestureRecognizer:longPress];
    [longPress release];
    [self.view addSubview:self.preViewFirst];
    
    self.firstImageSlider = [[[UISlider alloc] initWithFrame:sliderRect] autorelease];
    [self.firstImageSlider addTarget:self action:@selector(firstSliderMove) forControlEvents:UIControlEventValueChanged];
    self.firstImageSlider.maximumValue = 100.0f;
    self.firstImageSlider.minimumValue = 0.0f;
  //  self.firstImageSlider.enabled = NO;
    self.firstImageSlider.value = 100.0f;
    [self.view addSubview:self.firstImageSlider];
    
    buttonRect.origin.y += 50;
    self.preViewSecond = [[[UIButton alloc] initWithFrame:buttonRect] autorelease];
    self.preViewSecond.contentMode = UIViewContentModeScaleToFill;
    [self.preViewSecond setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [self.preViewSecond addTarget:self action:@selector(secondPreViewPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(doLongPressGesture:)];
    [self.preViewSecond addGestureRecognizer:longPressGesture];
    [longPressGesture release];
    [self.view addSubview:self.preViewSecond];
    
    sliderRect.origin.y += 50;
    self.secondImageSlider = [[[UISlider alloc] initWithFrame:sliderRect] autorelease];
    [self.secondImageSlider addTarget:self action:@selector(secondSliderMove) forControlEvents:UIControlEventValueChanged];
   // self.secondImageSlider.enabled = NO;
    self.secondImageSlider.maximumValue = 100.0f;
    self.secondImageSlider.minimumValue = 0.0f;
    self.secondImageSlider.value = 100.0f;

    [self.view addSubview:self.secondImageSlider];

    CGRect saveRect = CGRectMake(110, 120, 100, 40);
    self.saveResult = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.saveResult.frame = saveRect;
    [self.saveResult setTitle: @"Save" forState:UIControlStateNormal];
    [self.saveResult addTarget:self action:@selector(saveResultImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveResult];
    
    CGRect rect = CGRectMake(20, 190, 280, 250);
    self.commonPhotoView = [[[PhotoView alloc] initWithFrame:rect] autorelease];
    self.commonPhotoView.backgroundColor = [UIColor clearColor];
    [self checkForPhoto];
    [self.view addSubview:self.commonPhotoView];
    
}


- (void)resetByDefault
{
    self.secondImageSlider.enabled = NO;
    self.firstImageSlider.enabled = NO;
    
    [self.preViewFirst setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [self.preViewSecond setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    self.firstImageSlider.value = 100;
    [self performSelector:@selector(firstSliderMove)];
    self.secondImageSlider.value = 100;
    [self performSelector:@selector(secondImageSlider)];
    [self checkForPhoto];
    [self.commonPhotoView reset];
}


- (void)saveResultImage
{
    UIGraphicsBeginImageContext(commonPhotoView.bounds.size);
	[commonPhotoView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage* res = UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageWriteToSavedPhotosAlbum(res, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
   // [imageData writeToFile:basePath atomically:YES];
	UIGraphicsEndImageContext();
    
    NSLog(@"save");
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString* message;
    if(error) {
        message = NSLocalizedString(@"Image wasn't save", @"");
    } else {
       message = NSLocalizedString(@"Image was save", @"");
    }
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil, nil];
    [alert show];
    
    NSLog(@"finish");
}
- (void)firstPreViewPressed
{
    self.activeSlider = firstPhotoSlider;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Choose existing", @""), (self.hasCamera) ? NSLocalizedString(@"Take photo", @""):nil,  nil];
    [actionSheet showInView:self.view];
    [actionSheet release];

    NSLog(@"first preView clicked!");
}

- (void)secondPreViewPressed
{
    self.activeSlider = secondPhotoSlider;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Choose existing", @""), (self.hasCamera) ? NSLocalizedString(@"Take photo", @""):nil,  nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
    NSLog(@"second preView clicked!");
}



- (void)firstSliderMove
{
    self.preViewFirst.alpha = self.firstImageSlider.value/100;
    self.commonPhotoView.firstLayerImageView.alpha = self.firstImageSlider.value/100;
}

- (void)secondSliderMove
{
    self.preViewSecond.alpha = self.secondImageSlider.value/100;
    self.commonPhotoView.secondLayerImageView.alpha = self.secondImageSlider.value/100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Long Press Guester

- (void)doLongPress: (UILongPressGestureRecognizer *) recognizer{
    [self.view bringSubviewToFront:[recognizer view]];
    [self.preViewFirst setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    self.firstImageSlider.enabled = NO;
    self.commonPhotoView.firstLayerImageView.image = nil;
    
    self.firstImageSlider.value = 100;
    [self performSelector:@selector(firstSliderMove)];
    [self checkForPhoto];
    [self reloadInputViews];
}

- (void)doLongPressGesture: (UILongPressGestureRecognizer *) recognizer{
    [self.view bringSubviewToFront:[recognizer view]];
    [self.preViewSecond setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    self.secondImageSlider.enabled = NO;
    self.commonPhotoView.secondLayerImageView.image = nil;
    self.secondImageSlider.value = 100;
    [self performSelector:@selector(secondSliderMove)];
    [self checkForPhoto];
    [self reloadInputViews];
}

- (void)checkForPhoto
{
    if (!(self.commonPhotoView.firstLayerImageView.image || self.commonPhotoView.secondLayerImageView.image)) {
        [self.commonPhotoView defPhoto];
    }
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
       
        switch (self.activeSlider) {
            case firstPhotoSlider: {
                self.firstImage = [self.choosenImage roundedCornerImage:kRoundedCornerImageSize borderSize:kBorderSize];
                self.firstImageSlider.enabled = YES;
                [self.preViewFirst setImage:self.firstImage forState:UIControlStateNormal];
                [self.commonPhotoView.firstLayerImageView setImage:self.firstImage];
            }
                break;
            case secondPhotoSlider: {
                self.secondImage = [self.choosenImage roundedCornerImage:kRoundedCornerImageSize borderSize:kBorderSize];
                self.secondImageSlider.enabled = YES;
                [self.preViewSecond setImage:self.secondImage forState:UIControlStateNormal];
                [self.commonPhotoView.secondLayerImageView setImage:self.secondImage];
            }
                break;
            default:
                break;
        }
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
        [alert release];
    }
}

#pragma mark - UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        [self resetByDefault];
    }
}
@end
