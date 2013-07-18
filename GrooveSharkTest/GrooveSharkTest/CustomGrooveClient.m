//
//  CustomGrooveClient.m
//  GrooveSharkTest
//
//  Created by Natasha on 18.07.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "CustomGrooveClient.h"
#import "AFJSONRequestOperation.h"
#import "NSString+HMAC.h"

#import "SBJson.h"

#define key @"postindustria"
#define secret @"add0e90de3658b8f132724607d841ae5"

#define kSessionID      @"kSessionID"
#define kExpirationDate @"kExpirationDate"
#define kSession        @"kSession"

static CustomGrooveClient* _sharedClient = nil;

@interface CustomGrooveClient()

@property (nonatomic, strong) NSDictionary* session;

@end

@implementation CustomGrooveClient

BOOL isStringWithAnyText(NSString* str) {
	return nil!=str && [str length] > 0;
}

NSString* safeString(NSString* str) {
	return isStringWithAnyText(str) ? str : @"";
}



- (id) initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        self.parameterEncoding = AFJSONParameterEncoding;
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        
        self.session = [[NSUserDefaults standardUserDefaults] objectForKey:kSession];
        
        if (!self.session || [self.session[kExpirationDate] laterDate:[NSDate date]]) {
            [self startSession];
        } else {
            if (self.onReady) {
                self.onReady(YES);
            }
        }
    }
    return self;
}

- (void) end
{
    _sharedClient = nil;
}

+ (CustomGrooveClient*) sharedClient
{
    @synchronized(self) {
        NSString* domain = @"https://api.grooveshark.com";
        if (nil == _sharedClient) {
            _sharedClient = [[CustomGrooveClient alloc] initWithBaseURL:[NSURL URLWithString:domain]];
        }
    }
    return _sharedClient;
}

- (void) postMethod:(NSString*)method parameters:(NSDictionary*)params withCallbackBlock:(ResultBlock)callbackBlock
{
    NSDictionary* allParams = @{@"method": method, @"parameters": params, @"header": @{@"wsKey": key,  @"sessionID": safeString(self.session[kSessionID])}};

    [self postPath:[self generatePath:allParams] parameters:allParams success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        NSLog(@"responseObject %@", responseObject);
        if (callbackBlock) callbackBlock(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@", error);
        if (callbackBlock) callbackBlock(nil, error);
    }];
}

- (NSString*) generatePath:(NSDictionary*)params
{
    NSString* pathString = nil;
    NSData *jsonData =  [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    pathString = [jsonString HMACWithSecret:secret];
    pathString = [NSString stringWithFormat:@"/ws3.php?sig=%@", pathString];
    return pathString;
}

- (void) startSession
{
    [self postMethod:@"startSession" parameters:@{} withCallbackBlock:^(NSDictionary *dict, NSError * err) {
        if (self.onReady) {
            self.onReady(nil == err);
        }
        if (!err) {
            NSLog(@"responseObject %@", dict);
            self.session = @{kSessionID: dict [@"result"][@"sessionID"], kExpirationDate: [NSDate date]};
            [[NSUserDefaults standardUserDefaults] setObject:self.session forKey:kSession];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}

- (void) getArtistSearchResults:(NSString*)searchText withCallbackBlock:(ResultBlock)callbackBlock
{    
    [self postMethod:@"getArtistSearchResults" parameters:@{@"query": searchText} withCallbackBlock:callbackBlock];
}

@end
