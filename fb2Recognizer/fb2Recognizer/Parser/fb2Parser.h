//
//  fb2Parser.h
//  fb2Recognizer
//
//  Created by Natasha on 12.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fb2Parser : NSObject<NSXMLParserDelegate>
@property (strong, nonatomic) id currentNodeContent;
@property (strong, nonatomic) NSString* currentElement;
@property (strong, nonatomic) NSXMLParser* xmlParser;
@property (strong, nonatomic) NSMutableArray* elementArray;
@end
