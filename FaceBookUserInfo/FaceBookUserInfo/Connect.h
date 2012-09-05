//
//  Connect.h
//  FaceBookUserInfo
//
//  Created by Natasha on 31.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Connect;

typedef void (^ConnectBlock)(Connect* con, NSError* er);

@interface Connect : NSObject
@property(readonly, nonatomic, retain)NSURLRequest *urlRequest;
@property(readonly, nonatomic, retain) NSData *data;
@property(readonly, nonatomic, retain) NSURLResponse *responce;
@property(nonatomic, copy) ConnectBlock block;
-(Connect *)initRequest: (NSURLRequest *)request  withBlock: (ConnectBlock) _block;
+(Connect *)urlRequest: (NSURLRequest *)request withBlock: (ConnectBlock) _block;
-(id)objectFromResponce;
@end
