//
//  InfoViewController_DefineConst.h
//  FaceBookUserInfo
//
//  Created by Natasha on 05.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#define kToken @"AAACEdEose0cBAI12neD9N6jb5RDK22mp9A48rS7oA1GimuDodlIZCXXL8iVPl8mYfpeQoefRsMzZA6sk04aEXXB83BfxKZA33cgCufUn5t35rPfTo2Y"

#define kUserInfoTag 1
#define kUserImage 2
#define kUserStatus 3
#define kUserFeedTag 4

#define GCD_BACKGROUND_BEGIN  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
#define GCD_MAIN_BEGIN dispatch_async(dispatch_get_main_queue(), ^{
#define GCD_END });