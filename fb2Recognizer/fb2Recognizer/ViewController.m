//
//  ViewController.m
//  fb2Recognizer
//
//  Created by Natasha on 11.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"Larsson" ofType:@"fb2"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    // do whatever you want with xmlParser
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
//    currentElement = [elementName copy];
//    ElementValue = [[NSMutableString alloc] init];
//    if ([elementName isEqualToString:@"item"]) {
//        item = [[NSMutableDictionary alloc] init];
//        
//    }
    
}
@end
