//
//  ContentViewController.m
//  fb2Recognizer
//
//  Created by Natasha on 13.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ContentViewController.h"
#import "Fb2Parser.h"
#import "PDFView.h"

#define fadeNavButtonDelay 0.1f
#define fadeAnimationDuration 0.5f
#define minAlpha 0
@interface ContentViewController ()

@property (strong, nonatomic) UIWebView* webView;
@property (strong, nonatomic) Fb2Parser* testBookNodes;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSString* htmlDoc;

@end

@implementation ContentViewController

- (id)initWithNodes:(Fb2Parser*)nodes andCurrentNumber:(NSInteger)curNumber
{
    self = [super init];
    if (self) {
        self.testBookNodes = nodes;
        self.currentPage = curNumber;
        self.currentPosition = 0;
        self.currentNode = 0;
    }
    return self;
}

- (id)initWithHtml:(id)htmlFile andCurrentNumber:(NSInteger)curNumber
{
    self = [super init];
    if (self) {
        self.htmlDoc = htmlFile;
        self.currentPage = curNumber;
        self.currentPosition = 0;
        self.currentNode = 0;
    }
    return self;
}

- (id)initWithUrl:(NSURL*)url andCurrentNumber:(NSInteger)currentPage
{
    self = [super init];
    if (self) {
        self.urlToFile = url;
        self.currentPage = currentPage;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wantsFullScreenLayout = YES;

    if (self.documentType == DocumentType_fb2) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.webView];
        [self changePage:self.currentPage withCurrentNode:self.currentNode andCurrentPosition:self.currentPosition];
        self.navigationController.navigationBar.alpha = 0;
//        self.navigationController.navigationBarHidden = YES;
        
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//        singleTap.numberOfTouchesRequired = 1;
//        singleTap.numberOfTapsRequired = 1;
//        singleTap.delegate = self;
//        [self.webView addGestureRecognizer:singleTap];
    }
    if (self.documentType == DocumentType_PDF) {
        self.pdfContentView = [[PDFView alloc] initWithFrame:self.view.frame url:self.urlToFile andCurPage:self.currentPage];
        self.pdfContentView.frame = CGRectMake(0, 0, 320, 480);
        [self.view addSubview:self.pdfContentView];
    }
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.numberOfTouchesRequired = 1;
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {
    return YES;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"alpha %f",self.navigationController.navigationBar.alpha);
    [UIView animateWithDuration:fadeAnimationDuration animations:^{
        self.navigationController.navigationBar.alpha = !self.navigationController.navigationBar.alpha;
    }];
}


- (void)hiddenNavigationBarWithAnimation:(BOOL)isHidden
{
    [self performSelector:@selector(animate:) withObject:[NSNumber numberWithBool:isHidden] afterDelay:fadeNavButtonDelay];
}

- (void)hideNavigationBar
{
    self.navigationController.navigationBar.alpha = minAlpha;
}

- (void)changePage:(NSUInteger)curPage withCurrentNode:(NSInteger)curNode andCurrentPosition:(NSInteger)curPos
{
    self.currentPage = curPage;
    self.currentNode = curNode;
    self.currentPosition = curPos;
    [self.webView loadHTMLString:self.htmlDoc baseURL:nil];
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
    CGSize emptySize = CGSizeMake(320, 0);
    //
    while (self.currentNode < [self.testBookNodes.elementArray count]-1 && [[content stringByAppendingString:[self.testBookNodes.elementArray objectAtIndex:self.currentNode]] sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap].height < self.view.frame.size.height &&
           [[content stringByAppendingString:[self.testBookNodes.elementArray objectAtIndex:self.currentNode]] sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap].width < self.view.frame.size.width) {
        
        if (self.currentPosition > 0) {
            content = [content stringByAppendingString:[self addTailNode:[self.testBookNodes.elementArray objectAtIndex:self.currentNode] onSize:self.view.frame.size]];
            
        } else {
            if ([[self.testBookNodes.elementArray objectAtIndex:self.currentNode] isKindOfClass:[NSString class]]) {
                content = [content stringByAppendingString:[self.testBookNodes.elementArray objectAtIndex:self.currentNode]];
                CGSize _size = [content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
                emptySize.height = self.view.frame.size.height - _size.height;
                NSLogS(emptySize);
            }
        }
        if (self.moveAhead) {
            self.currentNode++;
        } else {
            if (self.currentNode > 0) {
                self.currentNode--;   
            }
        }
    }
    if (emptySize.height > 30) {
        content = [content stringByAppendingString:[self fillEmptySpace:[self.testBookNodes.elementArray objectAtIndex:self.currentNode] onSize:emptySize]];
    }
    NSLog(@"content: %@  i: %d", content, self.currentNode);
    return content;
}

//проверка на пробелы!
- (NSString*)fillEmptySpace:(NSString*)nodeContent onSize:(CGSize)size
{
    NSString* partNode;
    CGSize _size = [nodeContent sizeWithFont:settingFont constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat part = size.height / _size.height;
    
    NSInteger len = nodeContent.length;
    NSInteger index = (NSInteger)(part * len);
    
    self.currentPosition = index;
    NSLog(@"2 index : %d", self.currentPosition);
    partNode = [nodeContent substringToIndex:index];
    
    NSLog(@"partNode: %@ ", partNode);
    return partNode;
}

- (NSString*)addTailNode:(NSString*)nodeContent onSize:(CGSize)size
{
    NSString* partNode;
    CGSize _size = [nodeContent sizeWithFont:settingFont constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat part = size.height / _size.height;
    
    NSInteger len = nodeContent.length;
    NSInteger index = (NSInteger)(part * len);
    
    NSLog(@"1 index : %d", (index > len) ? len - 1 :  self.currentPosition - 1);
    partNode = [nodeContent substringToIndex:(index > len) ? len - 1 :  self.currentPosition - 1];
    self.currentPosition = (index > len) ? 0 : index;
    NSLog(@"%@",[nodeContent substringFromIndex:self.currentPosition ]);
    
    return partNode;
}

+ (NSString*)firstWords:(NSString*)theStr howMany:(NSInteger)maxWords {
    
    NSArray *theWords = [theStr componentsSeparatedByString:@" "];
    if ([theWords count] < maxWords) {
    	maxWords = [theWords count];
    }
    NSRange wordRange = NSMakeRange(0, maxWords - 1);
    NSArray *firstWords = [theWords subarrayWithRange:wordRange];
    return [firstWords componentsJoinedByString:@" "];
}

@end
