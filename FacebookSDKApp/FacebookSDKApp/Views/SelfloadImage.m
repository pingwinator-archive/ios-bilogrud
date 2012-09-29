//
//  SelfloadImage.m
//  FaceBookUserInfo
//
//  Created by Natasha on 06.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SelfloadImage.h"
#import "SharedCache.h"
#import "UIImage+RoundedCorner.h"
@interface SelfloadImage()

@property (retain, nonatomic) Connect *connect;
@property (retain, nonatomic) UIActivityIndicatorView *activity;

@end

@implementation SelfloadImage
@synthesize activity;
@synthesize connect;
@synthesize cache;

- (void)dealloc {
    self.activity = nil;
    self.connect = nil;
    self.cache = nil;
    [super dealloc];
}
- (SelfloadImage *)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.activity = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    self.activity.hidesWhenStopped = YES;
    [self addSubview:self.activity];
}

- (void)loadImage: (NSURL *)url
{
    self.cache = [SharedCache sharedInstance];
     
    [self.activity startAnimating];
    void(^imageBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
            if(!err){
                //!
                UIImage *testImage = [[UIImage imageWithData: connect.data] roundedCornerImage:5 borderSize:0];
                if (testImage)
                {
                    self.image = testImage ;
                    [self.cache setObject:self.image forKey:url];
                }
                  [self.activity stopAnimating];
            }
    };
    if([self.cache objectForKey:url] ){
        self.image =  [self.cache objectForKey:url];
        [self.activity stopAnimating];
    }  else {
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
        self.connect = [Connect urlRequest:imageRequest withBlock: imageBlock];
    }
}

- (void)loadImage: (NSURL *)url cashImages: (NSCache*)_cache
{
    [self.activity startAnimating];
        void(^imageBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
            if (con == self.connect) {
                if(!err){
                    UIImage *testImage = [UIImage imageWithData: connect.data];
                    if (testImage) {
                        self.image = testImage;
                        [_cache setObject:self.image forKey:url];
                        [self.activity stopAnimating];
                    }
                }
            }
        };
    if([_cache objectForKey:url] ){
        self.image = [_cache objectForKey:url];
        [self.activity stopAnimating];

    }
    else{
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
        self.connect = [Connect urlRequest:imageRequest withBlock: imageBlock];
    }
}

-(void)stopLoading
{
    [self.connect stopConnect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGPoint centerView = self.center ;
    centerView = CGPointMake( self.frame.size.width/2, self.frame.size.height/2);
    self.activity.center = centerView;
}
@end
