//
//  Connect.m
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Connect.h"
#import "SBJSON/SBJson.h"
@interface Connect ()

@property(nonatomic, retain)NSURLConnection *connection;
@property(nonatomic, retain)NSMutableData *data;
//@property(nonatomic, assign)ResponceType responceType;
@property(nonatomic, retain)NSURLRequest *urlRequest;
@end

@implementation Connect
@synthesize connection;
@synthesize data;
@synthesize responceType;
@synthesize urlRequest;
//@synthesize delegate;
//@synthesize tag;
@synthesize block;

-(void)dealloc{
    if (self.connection) {
        [self.connection cancel];
    }
    self.urlRequest = nil;
    self.data = nil;
    self.block = nil;
    [super dealloc];
}

-(void)callDelegateWithError:(NSError*) error{
//    if ([self.delegate respondsToSelector:@selector(didLoadingData:error:)]) {
//         [self.delegate didLoadingData:self error:error];
//    }
    if (self.block) {
        self.block(self, error);
    }
}
- (NSString*)description
{
    return [NSString stringWithFormat:@"connection id %@", self.connection];
}

-(Connect *)initRequest: (NSURLRequest *)request withBlock: (ConnectBlock) _block
{
    self = [super init];
    //self = [super init];
    //self.urlRequest = request;
   // self = [self initRequest:request];
    if (self) {
        self.block = _block;
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
        [self startConnect];
    }
    return self;
}

/*
-(Connect *)initRequest: (NSURLRequest *)request  responce: (ResponceType) resp{
    self = [super init];
    if (self) {
        self.urlRequest = request;
        self.responceType = resp;
        self.connection = [NSURLConnection connectionWithRequest:self.urlRequest delegate:self];
        self.tag = 0;
        [self startConnect];
    }
    return self;
}

+(Connect *)urlRequest: (NSURLRequest *)request responce: (ResponceType) resp{
    return [[[Connect alloc] initRequest:request responce:resp]autorelease];
} */
+(Connect *)urlRequest: (NSURLRequest *)request withBlock: (ConnectBlock) _block{
    return [[[Connect alloc] initRequest:request  withBlock:_block]autorelease];
}
-(void)appendConnectData: (NSData*) appendedData{
    self.data = (NSMutableData*)appendedData;
}

-(void)resetConnectData{
    self.data = [NSMutableData data];
}

-(void)startConnect{
    [self.connection start];
}
-(id)objectFromResponce{
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    id parseObj = [parser objectWithData:self.data];
    [parser release];
    return parseObj;
}

#pragma mark - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [self resetConnectData];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)_data{
    [self appendConnectData: _data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self callDelegateWithError:nil];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
     NSLog(@" error %@",error);
    [self callDelegateWithError:error];
}
@end
