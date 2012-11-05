//
//  GCTurnBasedMatchHelper.h
//  TetrisNew
//
//  Created by Natasha on 05.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
@interface GCTurnBasedMatchHelper : NSObject {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}
@property (assign, readonly) BOOL gameCenterAvailable;
+ (GCTurnBasedMatchHelper *)sharedInstance;
- (void)authenticateLocalUser;
@end