//
//  InfoViewController_DefineConst.h
//  FaceBookUserInfo
//
//  Created by Natasha on 05.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#define kToken @"AAACEdEose0cBAMhq0XtsvGZBmw8BZC5TO4qw9Yr1e7N4BQVnfEmiAsYkSmiZCtNCXKIRxkRRQCUg9ZCOMn09LwWajvrRSBHVc32EpeZAIv1xRuKfFAIZAc"

#define kUserInfoTag 1
#define kUserImage 2
#define kUserStatus 3
#define kUserFeedTag 4

#define GCD_BACKGROUND_BEGIN  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
#define GCD_MAIN_BEGIN dispatch_async(dispatch_get_main_queue(), ^{
#define GCD_END });

#define fileName @"tokenfile"
#define basePathUrl @"https://graph.facebook.com"

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; 