//
//  ContentViewController.h
//  fb2Recognizer
//
//  Created by Natasha on 13.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Fb2Parser;

@interface ContentViewController : UIViewController<UIGestureRecognizerDelegate>
@property (assign, nonatomic) NSUInteger currentNode;
@property (assign, nonatomic) NSInteger currentPosition;
- (id)initWithNodes:(Fb2Parser*)nodes andCurrentNumber:(NSInteger)curNumber;
- (void)changePage:(NSUInteger)curPage withCurrentNode:(NSInteger)curNode andCurrentPosition:(NSInteger)curPos;
@end
