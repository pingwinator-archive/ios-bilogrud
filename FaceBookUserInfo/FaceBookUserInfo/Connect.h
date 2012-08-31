//
//  Connect.h
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    eResponceTypeJson = 0,
    eResponceTypeImage
} ResponceType;

@interface Connect : NSObject
@property(readonly, nonatomic, retain)NSURLConnection *connection;
@property(readonly, nonatomic, retain)NSMutableData *data;
@property(readonly, nonatomic, assign)ResponceType responceType;
-(Connect *)initConnect: (NSURLConnection *)c responce: (ResponceType) resp;
+(Connect *)connect: (NSURLConnection *)c responce: (ResponceType) resp;
-(void)appendConnectData: (NSData*) appendedData;
-(void)resetConnectData;
-(void)startConnect;
@end
