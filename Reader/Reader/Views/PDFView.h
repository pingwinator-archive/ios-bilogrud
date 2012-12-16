//
//  PDFView.h
//  Reader
//
//  Created by Natasha on 16.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView
@property (assign, nonatomic) CGPDFDocumentRef document;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSURL* urlToFile;
-(void)increasePageNumber;
-(void)decreasePageNumber;
- (id)initWithFrame:(CGRect)frame url:(NSURL*)url andCurPage:(NSInteger)page;
@end
