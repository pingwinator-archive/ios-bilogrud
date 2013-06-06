//
//  PDFView.m
//  fb2Recognizer
//
//  Created by Natasha on 27.04.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "PDFView.h"
#import "DocumentModel.h"

@interface PDFView()

@property (assign, nonatomic) CGPDFDocumentRef document;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSURL* urlToFile;

@end

@implementation PDFView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame url:(NSURL*)url andCurPage:(NSInteger)page
{
    self = [super initWithFrame:frame];
           
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.document = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
        self.currentPage = page;
        self.urlToFile = url;
    }
    return self;

}

- (void)drawRect:(CGRect)rect
{
    if(self.document) {
        CGPDFPageRef page = CGPDFDocumentGetPage(self.document, self.currentPage);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        CGContextTranslateCTM(ctx, 0.0, [self bounds].size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextConcatCTM(ctx, CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, [self bounds], 0, true));
        CGContextDrawPDFPage(ctx, page);
        CGContextRestoreGState(ctx);
    }
}

@end
