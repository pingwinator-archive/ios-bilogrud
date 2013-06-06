//
//  ContentViewController.h
//  fb2Recognizer
//
//  Created by Natasha on 13.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentModel.h"

@class Fb2Parser;
@class PDFView;

@interface ContentViewController : UIViewController<UIGestureRecognizerDelegate>
@property (assign, nonatomic) DocumentType documentType;
@property (assign, nonatomic) NSUInteger currentNode;
@property (assign, nonatomic) NSInteger currentPosition;
@property (assign, nonatomic) BOOL moveAhead;

@property (strong, nonatomic) PDFView* pdfContentView;
@property (assign, nonatomic) NSInteger currentPageNumber;
@property (strong, nonatomic) NSURL* urlToFile;

- (id)initWithNodes:(Fb2Parser*)nodes andCurrentNumber:(NSInteger)curNumber;
- (id)initWithHtml:(id)htmlFile andCurrentNumber:(NSInteger)curNumber;
- (id)initWithUrl:(NSURL*)url andCurrentNumber:(NSInteger)currentPage;

- (void)changePage:(NSUInteger)curPage withCurrentNode:(NSInteger)curNode andCurrentPosition:(NSInteger)curPos;
@end
