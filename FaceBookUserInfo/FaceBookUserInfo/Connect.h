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

@class Connect;

typedef void (^ConnectBlock)(Connect* con, NSError* er);

@protocol ConnectDelegate;

@interface Connect : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property(readonly, nonatomic, retain)NSURLRequest *urlRequest;
@property(readonly, nonatomic, retain)NSURLConnection *connection;
@property(readonly, nonatomic, retain)NSMutableData *data;
@property(readonly, nonatomic, assign)ResponceType responceType;
@property(nonatomic, assign) id <ConnectDelegate> delegate;
@property (nonatomic, assign) NSUInteger tag;
@property(nonatomic, copy) ConnectBlock block;
-(Connect *)initRequest: (NSURLRequest *)request responce: (ResponceType) resp;
+(Connect *)urlRequest: (NSURLRequest *)request responce: (ResponceType) resp;
//+(Connect *)
-(void)appendConnectData: (NSData*) appendedData;
-(void)resetConnectData;
-(void)startConnect;
-(id)objectFromResponce;
@end

@protocol ConnectDelegate <NSObject>

@required
-(void)didLoadingData: (Connect*)connect error: (NSError*)err;

@end
