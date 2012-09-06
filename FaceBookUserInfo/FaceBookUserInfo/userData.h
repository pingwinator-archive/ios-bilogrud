//
//  UserData.h
//  FaceBookUserInfo
//
//  Created by Natasha on 05.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject
@property (retain, nonatomic) NSString *userName;
@property (retain, nonatomic) NSString *userFromID;
@property (retain, nonatomic) NSString *userFromName;
@property (retain, nonatomic) NSString *message;
@property (retain, nonatomic) NSString *feedID;
@property (retain, nonatomic) NSDate* time;
//uiimage??
@end
