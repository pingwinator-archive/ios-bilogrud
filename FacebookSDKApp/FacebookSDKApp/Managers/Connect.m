//
//  Connect.m
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Connect.h"
#import "SBJson.h"
@interface Connect ()

@property(nonatomic, retain)NSData *data;
@property(nonatomic, retain)NSURLRequest *urlRequest;
@property(nonatomic, retain) NSURLResponse *responce;
@end

@implementation Connect
@synthesize data;
@synthesize urlRequest;
@synthesize responce;
@synthesize block;

-(void)dealloc{

    self.urlRequest = nil;
    self.data = nil;
    self.block = nil;
    self.responce = nil;
    [super dealloc];
}

-(void)callDelegateWithError:(NSError*) error{
    if (self.block) {
GCD_MAIN_BEGIN
        self.block(self, error);
GCD_END
    }
}
- (void)stopConnect{
    self.block = nil;
}

-(Connect *)initRequest: (NSURLRequest *)request withBlock: (ConnectBlock) _block
{
    self = [super init];
   
    if (self) {
        self.block = _block;
GCD_BACKGROUND_BEGIN
        NSURLResponse *resp = nil;
        NSError *err = nil;
        NSData* _data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
        self.data = _data;
        self.responce = resp;
        if ([(NSHTTPURLResponse*)resp statusCode] >= 400) {
            err = [NSError errorWithDomain:@"Http error" code:[(NSHTTPURLResponse*)resp statusCode] userInfo:nil];
        }
        [self callDelegateWithError:err];
GCD_END
    }
    return self;
}

+ (Connect *)urlRequest: (NSURLRequest *)request withBlock: (ConnectBlock) _block{
    return [[[Connect alloc] initRequest:request  withBlock:_block] autorelease];
}


- (id)objectFromResponce{
  //  SBJsonParser* parser = [[SBJsonParser alloc] init];
//    NSURLResponse *resp = nil;
//    NSError *err = nil;

//    self.data = [NSURLConnection sendSynchronousRequest:self.urlRequest returningResponse:&resp error:&err];
    id __block parseObj = nil;
//GCD_BACKGROUND_BEGIN
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    
    parseObj = [parser objectWithData: self.data];
    [parser release];
//GCD_END
    return parseObj;

}

@end
