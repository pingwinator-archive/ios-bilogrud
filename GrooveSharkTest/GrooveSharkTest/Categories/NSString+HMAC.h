//
//  NSString+HMAC.h
//  GrooveSharkTest
//
//  Created by Natasha on 18.07.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMAC)
- (NSString*) HMACWithSecret:(NSString*) secret;
@end
