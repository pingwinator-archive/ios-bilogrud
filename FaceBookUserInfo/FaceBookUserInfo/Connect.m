//
//  Connect.m
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Connect.h"

@interface Connect ()

@property(nonatomic, retain)NSURLConnection *connection;
@property(nonatomic, retain)NSMutableData *data;
@property(nonatomic, assign)ResponceType responceType;

@end

@implementation Connect
@synthesize connection;
@synthesize data;
@synthesize responceType;

- (NSString*)description
{
    return [NSString stringWithFormat:@"connection id %@", self.connection];
}

+(Connect *)connect: (NSURLConnection *)c responce: (ResponceType) resp
{
    return [[[Connect alloc] initConnect:c responce:resp] autorelease];
}

-(Connect *)initConnect: (NSURLConnection *)c responce: (ResponceType) resp{
    self = [super init];
    if (self) {
        self.connection = c;
        self.responceType = resp;
    }
    return self;
}

-(void)dealloc{
    if (self.connection) {
        [self.connection cancel];
    }
    self.connection = nil;

    self.data = nil;
    [super dealloc];
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

@end
