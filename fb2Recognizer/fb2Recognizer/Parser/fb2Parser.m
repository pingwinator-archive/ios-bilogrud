//
//  fb2Parser.m
//  fb2Recognizer
//
//  Created by Natasha on 12.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "Fb2Parser.h"
#import "NSData+NSDataAdditions.h"
#import "NSString+NSStringAdditions.h"
#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT
static NSString * const kTitleElementName = @"title";
static NSString * const kTextElementName = @"p";
static NSString * const kAuthorElementName = @"author";
static NSString * const kBookTitleElementName = @"book-title";
static NSString * const kAnnotationElementName = @"annotation";
static NSString * const kImageElementName = @"image";

@interface Fb2Parser ()

@end
@implementation Fb2Parser
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

- (id)initWithUrl:(NSURL*)fileUrl
{
    self = [super init];
    if (self) {
        NSString *xmlPath = fileUrl.path;
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
    if (!self.elementArray) {
        self.elementArray = [NSMutableArray array];
    }
    SWITCH (self.currentElement) {
        CASE (kTextElementName) {
            self.currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
             [self.elementArray addObject:self.currentNodeContent];
            NSLog(@"%@", self.currentNodeContent);
        } break;
        CASE (kAnnotationElementName) {
            
            
        } break;
        CASE (kAuthorElementName) {
            
        } break;
        CASE (kImageElementName) {
            
        } break;
        CASE (kTitleElementName) {
            
        } break;
        CASE (@"binary") {
            NSData* data = [NSData base64DataFromString:string];
            self.currentNodeContent = data;
            [self.elementArray addObject:self.currentNodeContent];
            NSLog(@"-------binary!!!");
            NSLog(@"%@", self.currentNodeContent);
        } break;
        DEFAULT {
            break;
        }
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

+ (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ;
}
@end
