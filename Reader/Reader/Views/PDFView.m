//
//  PDFView.m
//  Reader
//
//  Created by Natasha on 16.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

- (id)initWithFrame:(CGRect)frame url:(NSURL*)url andCurPage:(NSInteger)page
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        //!!
        self.document = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
        self.currentPage = page;
        self.urlToFile = url;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if(self.document) {
        CGPDFPageRef page = CGPDFDocumentGetPage(self.document, self.currentPage);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        CGContextTranslateCTM(ctx, 0.0, [self bounds].size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextConcatCTM(ctx, CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, [self bounds], 0, true));
        CGContextDrawPDFPage(ctx, page);
        CGContextRestoreGState(ctx);
    }
}

@end
