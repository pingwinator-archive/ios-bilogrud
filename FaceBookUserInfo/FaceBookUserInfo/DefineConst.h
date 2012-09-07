//
//  InfoViewController_DefineConst.h
//  FaceBookUserInfo
//
//  Created by Natasha on 05.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#define kToken @"AAACEdEose0cBAPVOjuiPDL8cZALi4pKvTjGhxLucpKVVN6FmhlNiwEkJ2PCWjHTwZArBWrqAmmZC2qr1o8ZC7M8ivRP74t0JeBbVoQXpwWOxAx6akgoW"

#define kUserInfoTag 1
#define kUserImage 2
#define kUserStatus 3
#define kUserFeedTag 4

#define GCD_BACKGROUND_BEGIN  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
#define GCD_MAIN_BEGIN dispatch_async(dispatch_get_main_queue(), ^{
#define GCD_END });

