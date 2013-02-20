//
//  ContentViewController.m
//  fb2Recognizer
//
//  Created by Natasha on 13.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ContentViewController.h"
#import "fb2Parser.h"


@interface ContentViewController ()
@property(assign, nonatomic) NSUInteger currentNode;
@end

@implementation ContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    	// Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //    self.webView.scrollView.scrollEnabled = NO;
    //    self.webView.scrollView.bounces = NO;
    [self changePage:self.currentPage];
}

- (void)changePage:(NSUInteger)page
{
    self.currentPage = page;
    
    [self.webView loadHTMLString:[self generateHTML] baseURL:nil];
    [self.view addSubview:self.webView];
    
    [self.webView sizeThatFits:CGSizeZero];
    
    CGSize goodSize = [self.webView sizeThatFits: self.view.frame.size];
    NSLog(@"goodsize : ");
    NSLogS(goodSize);
}

- (id)initWithNodes:(fb2Parser*)nodes andCurrentNumber:(NSInteger)curNumber
{
    self = [super init];
    if (self) {
        self.testBookNodes = nodes;
        self.currentPage = curNumber;
        self.currentNode = 0;
    }
    return self;
}

- (NSString*)generateHTML
{
    NSString *content = [self getPage:self.currentPage];
    NSString *myHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@;}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body>%@</body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:25], content];
    return myHTML;
}

//с номером страницы 
- (NSString*)getPage:(NSUInteger)iPage
{
    UIFont *myFont = settingFont;
    NSString *content = [NSString string];
    while ([content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap].height < self.view.frame.size.height &&
           [content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap].width < self.view.frame.size.width &&
           self.currentNode < [self.testBookNodes.elementArray count]) {
        
        NSLog(@" h %f", [content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 400) lineBreakMode:UILineBreakModeWordWrap].height);
        NSLog(@" w %f", [content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 400) lineBreakMode:UILineBreakModeWordWrap].width);
        
        NSLog(@"content: %@  i: %d", content, self.currentNode);
        if ([[self.testBookNodes.elementArray objectAtIndex:self.currentNode] isKindOfClass:[NSString class]]) {
            content = [content stringByAppendingString:[self.testBookNodes.elementArray objectAtIndex:self.currentNode]];
            CGSize _size = [content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
            NSLogS(_size);
        }
        self.currentNode++;
    }
    return content;
}

@end
