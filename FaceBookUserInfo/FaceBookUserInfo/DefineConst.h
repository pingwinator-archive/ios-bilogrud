//
//  InfoViewController_DefineConst.h
//  FaceBookUserInfo
//
//  Created by Natasha on 05.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#define kToken @"AAACEdEose0cBAHg3ruy9iROicCoC19PnxCTsVGGM0ZCbOdiDP9pdufe8lAUSijV9ZA4rDZC9LyZAJMfiZCwWZBfmHaWfvFVWuT7X9fUl4lv2ZCvsXGzjWhK"

#define kUserInfoTag 1
#define kUserImage 2
#define kUserStatus 3
#define kUserFeedTag 4

#define GCD_BACKGROUND_BEGIN  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
#define GCD_MAIN_BEGIN dispatch_async(dispatch_get_main_queue(), ^{
#define GCD_END });