//
//  NSDictionary+HTTPParametrs.m
//  ConnectionTest
//
//  Created by Natasha on 30.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "NSDictionary+HTTPParametrs.h"

@implementation NSDictionary (HTTPParametrs)

-(NSString *)paramFromDict{
    NSString *str = @"";
    for(NSString* key in [self allKeys]){
        NSString* value = [self valueForKey:key];
         value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        str = [NSString stringWithFormat:@"%@%@%@%@%@", str, ([str length] == 0) ? @"" : @"&",key, @"=", value];
    }
    return str;
}

@end
