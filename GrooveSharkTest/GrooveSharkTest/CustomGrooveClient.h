//
//  CustomGrooveClient.h
//  GrooveSharkTest
//
//  Created by Natasha on 18.07.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "AFHTTPClient.h"

#import <Foundation/Foundation.h>


typedef void (^ResultBlock)(NSDictionary*, NSError*);
typedef void (^OnReady)(BOOL);

@interface CustomGrooveClient : AFHTTPClient

@property (nonatomic, copy) OnReady onReady;

+ (CustomGrooveClient*)sharedClient;
- (void) end;

- (void) startSessionWithCallbackBlock:(ResultBlock)callbackBlock;
- (void) getArtistSearchResults:(NSString*)searchText withCallbackBlock:(ResultBlock)callbackBlock;

@end
