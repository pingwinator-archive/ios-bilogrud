//
//  SettingManager.h
//  FacebookSDKApp
//
//  Created by Natasha on 12.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingManager : NSObject
@property (retain, nonatomic, readonly) NSString *accessToken;
- (void)saveAccessToken:(NSString*)token;
- (BOOL)isAccessToken;
- (NSMutableDictionary*)baseDict;
- (void) resetToken;
+ (id) sharedInstance;
@end
