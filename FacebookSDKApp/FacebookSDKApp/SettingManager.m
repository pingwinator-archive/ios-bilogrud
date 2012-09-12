//
//  SettingManager.m
//  FacebookSDKApp
//
//  Created by Natasha on 12.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "SettingManager.h"

@interface SettingManager ()

@property (retain, nonatomic) NSString *accessToken;

- (NSString *)dataFilePath;

@end


@implementation SettingManager

//@synthesize accessToken;

- (void)dealloc
{
   // self.accessToken = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        NSError* err = nil;
        NSString* token = [[NSString alloc]initWithContentsOfFile:[self dataFilePath] encoding:NSUTF8StringEncoding error:&err];
        self.accessToken = token;
        [token release];
    }
    return self;
}

- (void)saveAccessToken:(NSString *)token
{
    self.accessToken = token;
    //save implement
    NSError* error = nil;
    if(![token writeToFile:[self dataFilePath] atomically:YES encoding: NSUTF8StringEncoding error:&error]){
        NSLog(@"%@", error);
    }
}

- (NSString *)dataFilePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:fileName];
}

+ (id)sharedInstance
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (BOOL)isAccessToken{
    return (self.accessToken) ? YES : NO;
}

- (void) resetToken
{
    self.accessToken = nil;
}

- (NSMutableDictionary*)baseDict
{
    NSMutableDictionary *dictparametrs = [NSMutableDictionary dictionary];
    [dictparametrs setValue:self.accessToken forKey:@"access_token"];
    return dictparametrs;
}
@end
