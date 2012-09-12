//
//  StatusViewController.m
//  FacebookSDKApp
//
//  Created by Natasha on 10.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "StatusViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface StatusViewController ()
//-(void)updateDisplay;
-(void)imageFromSource:(UIImagePickerControllerSourceType)type;
@end

@implementation StatusViewController
@synthesize statusInput;
@synthesize camera;
@synthesize photoButton;
@synthesize sendPhotoButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *sendButton = [[[UIBarButtonItem alloc] initWithTitle:@"send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendStatus)]autorelease];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.camera = YES;
    }
    else
    {
        self.camera = NO;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.statusInput = nil;
    self.photoButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//-(void)addConnectToDict: (Connect *)con
//{
//    [self.conDict setValue:con forKey:[con description]];
//}

//- (NSMutableDictionary*)baseDict
//{
//    NSMutableDictionary *dictparametrs = [NSMutableDictionary dictionary];
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    
//    [dictparametrs setValue:[def valueForKey:@"token"] forKey:@"access_token"];
//    return dictparametrs;
//}

#pragma mark - post status

-(void)sendStatus{
    NSLog(@"ура!");
     
    NSString *message = statusInput.text;
    
     NSMutableDictionary *dictparametrs = [self baseDict];
     [dictparametrs setValue:message forKey:@"message"];
     
     NSString *urlStr = [[NSString alloc]initWithFormat: @"https://graph.facebook.com/me/feed"];
     NSURL* url = [NSURL URLWithString:urlStr];
    [urlStr release];
     NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
     
     [request setHTTPMethod:@"POST"];
     
     NSString *postParam = [dictparametrs paramFromDict];
     
     NSData *postData = [postParam dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
     [request setHTTPBody:postData];
     
     void(^postBlock)(Connect *, NSError *) = ^(Connect *con, NSError *err){
         if(!err){
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message was send" message:message delegate:nil cancelButtonTitle:@"great!" otherButtonTitles: nil];
             [alert show];
             [alert release];
         }
     };
     
     Connect *post = [Connect urlRequest:request withBlock:postBlock];
   //  [ self addConnectToDict:post];
     
    
    
}

#pragma mark - post photo

-(NSMutableURLRequest*)requestWithImage: (NSURL*)url{
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60]autorelease];
    NSString *boundary = @"----BoundarycC4YiaUFwM44F6rT";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
    UIImage *image = [UIImage imageNamed:@"image.png"];
    NSData* imageData = UIImagePNGRepresentation(image);
    
    [body appendData:[@"Content-Disposition: form-data; name=\"source\";filename=\"picture.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    
    // and again the delimiting boundary
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // adding the body we've created to the request
    [request setHTTPBody:body];
    return request;
}

-(IBAction)sendPhoto
{
    NSLog(@"ура!");
    
    NSString *message = statusInput.text;
    
    NSMutableDictionary *dictparametrs = [self baseDict];
    [dictparametrs setValue:message forKey:@"message"];
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"http://a5.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/430702_274084829330398_269741610_n.jpg"];
    NSURL* url = [NSURL URLWithString:urlStr];
    [urlStr release];
    NSMutableURLRequest* request = [self requestWithImage:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *postParam = [dictparametrs paramFromDict];
    
    NSData *postData = [postParam dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    void(^postBlock)(Connect *, NSError *) = ^(Connect *con, NSError *err){
        if(!err){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message was send" message:message delegate:nil cancelButtonTitle:@"great!" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    };
    
    Connect *post = [Connect urlRequest:request withBlock:postBlock];
    //  [ self addConnectToDict:post];
    
    
}

-(IBAction)pressPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"select" otherButtonTitles:(self.camera)?@"camera":nil, nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
  //select button
    if(buttonIndex == [actionSheet destructiveButtonIndex]){
        [self imageFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
}
#pragma mark UIImagePickerController delegate methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   if( [[info objectForKey:UIImagePickerControllerMediaType] isEqual: (NSString*)kUTTypeImage])
   {
       UIImage *choosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
      //
       [self.photoButton setBackgroundImage:choosenImage forState: UIControlStateNormal ];//currentBackgroundImage:choosenImage];
       self.sendPhotoButton.enabled = YES;
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
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = type;
        [self presentModalViewController: picker animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"error" message:@"Device doesn’t support that media source." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil ];
        [alert show];
        [alert release];
    }
}
@end
