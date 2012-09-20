//
//  CommonConst.h
//  RandomTimerApp
//
//  Created by Natasha on 19.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#ifndef RandomTimerApp_CommonConst_h
#define RandomTimerApp_CommonConst_h

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject;


#define GCD_BACKGROUND_BEGIN  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
#define GCD_MAIN_BEGIN dispatch_async(dispatch_get_main_queue(), ^{
#define GCD_END });

#ifdef DEBUGGING
# define DBLog(fmt,...) NSLog(@"%@",[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);
#else
# define DBLog(...)
#endif

#ifdef DEBUG
#   define DLog(desc, ...) NSLog((@"%s [Line %d] " desc), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...) while(0)
#endif

#define VLog(v) DLog(@#v @"=%@",v)

#endif
