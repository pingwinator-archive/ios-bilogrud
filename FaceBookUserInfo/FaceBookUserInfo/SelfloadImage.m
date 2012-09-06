//
//  SelfloadImage.m
//  FaceBookUserInfo
//
//  Created by Natasha on 06.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SelfloadImage.h"

@interface SelfloadImage()

@property (retain, nonatomic) Connect *connect;
@property (retain, nonatomic) UIActivityIndicatorView *activity;
@end

@implementation SelfloadImage

@synthesize activity;
@synthesize connect;
-(SelfloadImage *)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.hidesWhenStopped = YES;
    [self addSubview:self.activity];
}
-(void)loadImage: (NSURL *)url{
  NSCache *cash = [[NSCache alloc]init];
    [self.activity startAnimating];
        void(^imageBlock)(Connect*, NSError *) = ^(Connect *con, NSError *err){
            if (con == self.connect) {
            if(!err){
                UIImage *testImage = [UIImage imageWithData: connect.data];
                if (testImage) {
                    self.image = testImage;
                    [cash setObject:self.image forKey:url];
                    [self.activity stopAnimating];
                }
            } }
        };
    if([cash objectForKey:url] ){
        [cash objectForKey:url];
    }  else{
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
        self.connect = [Connect urlRequest:imageRequest withBlock: imageBlock];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGPoint centerView = self.center ;
    centerView = CGPointMake(centerView.x - self.activity.frame.size.width, centerView.y - self.activity.frame.size.height);
    self.activity.center = centerView;
}


@end
