//
//  StatusViewController.m
//  FacebookSDKApp
//
//  Created by Natasha on 10.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "StatusViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "NSDictionary+HTTPParametrs.h"
#import "UIImage+RoundedCorner.h"
#import <QuartzCore/QuartzCore.h>
@interface StatusViewController ()

-(void)imageFromSource:(UIImagePickerControllerSourceType)type;
-(NSMutableURLRequest*)requestWithURL:(NSURL*)url withImage:(UIImage*)sendImage andText:(NSString*)message;

@end

@implementation StatusViewController
@synthesize statusInput;
@synthesize camera;
@synthesize photoButton;
@synthesize postingImage;
@synthesize prePostingImage;
@synthesize baseView;
@synthesize activityView;
-(void)dealloc
{
    self.statusInput = nil;
    self.photoButton = nil;
    self.postingImage = nil;
    self.prePostingImage = nil;
    self.baseView = nil;
    self.activityView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *sendButton = [[[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"send", @"")  style:UIBarButtonItemStyleBordered target:self action:@selector(sendMessageWithPhoto)] autorelease];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    self.camera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera];
    
    self.postingImage = [self.postingImage roundedCornerImage:10 borderSize:1];
    
    self.baseView.image =  [self.baseView.image roundedCornerImage:10 borderSize:1];
       
    self.statusInput.editable = YES;
   
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(doLongPress:)];
    [self.prePostingImage addGestureRecognizer:longPress];
    [longPress release];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.statusInput = nil;
    self.photoButton = nil;
    self.postingImage = nil;
    self.prePostingImage = nil;
    self.baseView = nil;
    self.activityView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark - Long Press Guester 

- (void)doLongPress: (UILongPressGestureRecognizer *) recognizer{
    [self.view bringSubviewToFront:[recognizer view]];
    self.prePostingImage.image = nil;
    CGRect rect = CGRectMake(32, 15, 254, 148);
    self.statusInput.frame = rect;
    [self reloadInputViews];
}

#pragma mark - Post photo and status

- (NSMutableURLRequest*)requestWithURL:(NSURL*)url withImage:(UIImage*)sendImage andText:(NSString*)message
{
    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
 
    NSString* boundary = @"----BoundarycC4YiaUFwM44F6rT";
    
    NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData* body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
    NSMutableDictionary* dict =  [[SettingManager sharedInstance] baseDict];
    [dict setValue:message forKey:@"message"];
    
    for (NSString* key in [dict allKeys]) {
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@", [dict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    UIImage* image = self.postingImage;
    NSData* imageData = UIImagePNGRepresentation(image);
    
    [body appendData:[@"Content-Disposition: form-data; name=\"source\";filename=\"picture.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    
    // and again the delimiting boundary
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSASCIIStringEncoding]];
    
    // adding the body we've created to the request
    [request setHTTPBody:body];
    return request;
}

- (void)sendPhotoByURL
{
    NSMutableDictionary *dictparametrs = [[SettingManager sharedInstance] baseDict];
    [dictparametrs setValue:@"http://a5.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/430702_274084829330398_269741610_n.jpg" forKey:@"url"];
    
    NSString* urlStr = [NSString stringWithFormat:@"%@/me/photos/", basePathUrl];
    NSURL* url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [request setHTTPMethod:@"POST"];
    
    NSString* postParam = [dictparametrs paramFromDict];
    
    NSData* postData = [postParam dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    void(^postBlock)(Connect *, NSError *) = ^(Connect* con, NSError* err){
        if(!err){
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString (@"image was post", @"") message:urlStr delegate:nil cancelButtonTitle:NSLocalizedString(@"great!", @"") otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    };
    
    [Connect urlRequest:request withBlock:postBlock];
}

- (void)sendMessageWithPhoto
{
    self.activityView.hidden = NO;
    NSString* urlStr = [NSString stringWithFormat:@"%@/me/photos", basePathUrl];
    NSURL* url = [NSURL URLWithString:urlStr];
     
    NSMutableURLRequest* request = [self requestWithURL:url withImage:self.postingImage andText:self.statusInput.text];
    
    [request setHTTPMethod:@"POST"];
    
    void(^postBlock)(Connect *, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"image was post", @"") message:urlStr delegate:nil cancelButtonTitle:NSLocalizedString(@"great!", @"") otherButtonTitles: nil];
            [alert show];
            [alert release];
        } else {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"image didn't post", @"") message:@"error" delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil, nil ];
            [alert show];
            [alert release];
        }
        self.activityView.hidden = YES;
    };
    [Connect urlRequest:(NSURLRequest*)request withBlock:postBlock];
}

- (IBAction)pressPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Choose existing", @""), (self.camera)?NSLocalizedString(@"Take photo", @""):nil,  nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.firstOtherButtonIndex == buttonIndex ){
            [self imageFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

#pragma mark - UIImagePickerController delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   if( [[info objectForKey:UIImagePickerControllerMediaType] isEqual: (NSString*)kUTTypeImage])
   {
       UIImage *choosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
      //
       self.postingImage = choosenImage;
       self.prePostingImage.image = [choosenImage roundedCornerImage:10 borderSize:1];
       CGRect rect = CGRectMake(32, 120, 254, 46);
       self.statusInput.frame = rect;
       [self.statusInput becomeFirstResponder];
              
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", @"") message:NSLocalizedString(@"Device doesn’t support that media source", @"") delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil ];
        [alert show];
        [alert release];
    }
}

- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType {
    NSArray *mediaTypes = [UIImagePickerController
                           availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:
         sourceType] && [mediaTypes count] > 0) {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"Error accessing media", @"")
                              message:NSLocalizedString(@"Device doesn’t support that media source", @"")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                              otherButtonTitles:nil];
        [alert show];
    }
}
@end
