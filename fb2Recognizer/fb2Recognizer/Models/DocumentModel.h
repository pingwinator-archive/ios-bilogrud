//
//  DocumentModel.h
//  Reader
//
//  Created by Natasha on 04.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    DocumentType_PDF = 0,
    DocumentType_fb2,
    DocumentType_HTML,
    DocumentType_fb2Extended
} DocumentType;

@interface DocumentModel : NSObject
@property (strong, nonatomic) NSURL* documentUrl;
@property (assign, nonatomic) NSInteger documentLastPage;
@property (assign, nonatomic) NSInteger documentCurrentPage;
@property (assign, nonatomic) DocumentType documentType;
@end
