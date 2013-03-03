//
//  DocumentModel.h
//  Reader
//
//  Created by Natasha on 04.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentModel : NSObject
@property (strong, nonatomic) NSURL* documentUrl;
@property (assign, nonatomic) NSInteger documentLastPage;
@end
