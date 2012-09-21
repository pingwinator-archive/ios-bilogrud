//
//  UserData.m
//  FaceBookUserInfo
//
//  Created by Natasha on 05.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "UserData.h"

@implementation UserData
@synthesize userName;
@synthesize userFromID;
@synthesize userFromName;
@synthesize message;
@synthesize time;
@synthesize feedID;
@synthesize likes;
@synthesize comments;
- (void) dealloc {
    self.userName = nil;
    self.userFromID = nil;
    self.userFromName = nil;
    self.message = nil;
    self.time = nil;
    self.feedID = nil;
    self.likes = nil;
    self.comments = nil;
    [super dealloc];
}
@end
