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
@interface ViewController ()
@property (retain, nonatomic) PhotoView* commonPhotoView;
@property (retain, nonatomic) UIImageView* firstLayerImageView;
@property (retain, nonatomic) UIImageView* secondLayerImageView;
@property (retain, nonatomic) UIButton* preViewFirst;
@property (retain, nonatomic) UIButton* preViewSecond;
@property (retain, nonatomic) UISlider* firstImageSlider;
@property (retain, nonatomic) UISlider* secondImageSlider;
@property (assign, nonatomic) BOOL hasCamera;
@property (retain, nonatomic) UIImage* firstImage;
@property (retain, nonatomic) UIImage* secondImage;
@property (retain, nonatomic) UIImage* choosenImage;
@property (assign, nonatomic) PhotoSliderNumber activeSlider;
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
    
    CGRect buttonRect = CGRectMake(20, 20, 70, 70);
    CGRect sliderRect = CGRectMake(110, 20, 170, 70);
    self.preViewFirst = [[[UIButton alloc] initWithFrame:buttonRect] autorelease];
    self.preViewFirst.contentMode = UIViewContentModeScaleAspectFill;
    [self.preViewFirst setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [self.preViewFirst addTarget:self action:@selector(firstPreViewPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(doLongPress:)];
    [self.preViewFirst addGestureRecognizer:longPress];
    [longPress release];
    [self.view addSubview:self.preViewFirst];
    
    self.firstImageSlider = [[[UISlider alloc] initWithFrame:sliderRect] autorelease];
    [self.firstImageSlider addTarget:self action:@selector(firstSliderMove) forControlEvents:UIControlEventValueChanged];
   //self.firstImageSlider.userInteractionEnabled = NO;
    self.firstImageSlider.maximumValue = 100.0f;
    self.firstImageSlider.minimumValue = 0.0f;
    self.firstImageSlider.value = 100.0f;
    [self.view addSubview:self.firstImageSlider];
    
    buttonRect.origin.y += 80;
    self.preViewSecond = [[[UIButton alloc] initWithFrame:buttonRect] autorelease];
    self.preViewSecond.contentMode = UIViewContentModeScaleAspectFill;
    [self.preViewSecond setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [self.preViewSecond addTarget:self action:@selector(secondPreViewPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(doLongPress:)];
    [self.preViewSecond addGestureRecognizer:longPressGesture];
    [longPressGesture release];
    [self.view addSubview:self.preViewSecond];
    
    sliderRect.origin.y += 80;
    self.secondImageSlider = [[[UISlider alloc] initWithFrame:sliderRect] autorelease];
    [self.secondImageSlider addTarget:self action:@selector(secondSliderMove) forControlEvents:UIControlEventValueChanged];
   // self.secondImageSlider.userInteractionEnabled = NO;
    self.secondImageSlider.maximumValue = 100.0f;
    self.secondImageSlider.minimumValue = 0.0f;
    self.secondImageSlider.value = 100.0f;

    [self.view addSubview:self.secondImageSlider];

    CGRect rect = CGRectMake(20, 190, 280, 250);
    self.commonPhotoView = [[PhotoView alloc] initWithFrame:rect];
    self.commonPhotoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.commonPhotoView];
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
    NSLog(@"ddd");
    self.preViewFirst.alpha = self.firstImageSlider.value/100;
}

- (void)secondSliderMove
{
    NSLog(@"rrr");
    self.preViewSecond.alpha = self.secondImageSlider.value/100;
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
    [self reloadInputViews];
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.firstOtherButtonIndex == buttonIndex ){
        [self imageFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
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
@end
