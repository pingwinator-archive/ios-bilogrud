//
//  fb2Parser.m
//  fb2Recognizer
//
//  Created by Natasha on 12.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "fb2Parser.h"

static NSString * const kTitleElementName = @"title";
static NSString * const kTextElementName = @"p";

@interface fb2Parser ()

@end
@implementation fb2Parser
- (id)init
{
    self = [super init];
    if (self) {
        NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"Larsson" ofType:@"fb2"];
        NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
        self.xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
        self.xmlParser.delegate = self;
        BOOL ok = [self.xmlParser parse];
        if (!ok) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Error" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }

    }
    return self;
}

#pragma mark - NSXMLParserDelegate Methods
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:kTextElementName]) {
        self.currentElement = kTextElementName;
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.currentElement isEqualToString:kTextElementName]) {
        self.currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (!self.elementArray) {
            self.elementArray = [NSMutableArray array];
        }
        [self.elementArray addObject:self.currentNodeContent];
        NSLog(@"%@", self.currentNodeContent);
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"File found and parsing started");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Finish");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Error %@", parseError);
}

@end
