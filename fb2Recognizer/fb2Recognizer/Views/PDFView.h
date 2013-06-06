//
//  PDFView.h
//  fb2Recognizer
//
//  Created by Natasha on 27.04.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DocumentModel;

@interface PDFView : UIView

- (id)initWithFrame:(CGRect)frame url:(NSURL*)url andCurPage:(NSInteger)page;

@end
