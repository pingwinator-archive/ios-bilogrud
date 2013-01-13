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

@end

@implementation ContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];

//    self.webView.scrollView.scrollEnabled = NO;
//    self.webView.scrollView.bounces = NO;
  
    [self.webView loadHTMLString:[self generateHTML] baseURL:nil];
    [self.view addSubview:self.webView];

    [self.webView sizeThatFits:CGSizeZero];
    
    CGSize goodSize = [self.webView sizeThatFits: self.view.frame.size];
    NSLog(@"good");
    NSLogS(goodSize);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNodes:(fb2Parser*)nodes andCurrentNumber:(NSInteger)curNumber
{
    self = [super init];
    if (self) {
        self.testBookNodes = nodes;
        self.currentPage = curNumber;
    }
    return self;
}

- (NSString*)generateHTML
{
    
    UIFont *myFont = settingFont;
    NSString *content = [NSString string];
    
    int i = 0;
    while ([content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 480) lineBreakMode:UILineBreakModeWordWrap].height < self.view.frame.size.height &&
           [content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 480) lineBreakMode:UILineBreakModeWordWrap].width < self.view.frame.size.width) {
//     NSLog(@"%@", [[self.testBookNodes.elementArray lastObject] description]);
        if ([[self.testBookNodes.elementArray lastObject] isKindOfClass:[NSData class]]) {
            UIImage* image = [UIImage imageWithData:[self.testBookNodes.elementArray lastObject]];
            [content stringByAppendingFormat:@"<image>%@</image>", image];
        }
        if ([[self.testBookNodes.elementArray lastObject] isKindOfClass:[NSString class]]) {
           
             content = [content stringByAppendingString:[self.testBookNodes.elementArray lastObject]];
      
        
//        NSLog(@" w %f ", [content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 480) lineBreakMode:UILineBreakModeWordWrap].width);
//        
//        NSLog(@" i %d", i);
//        
//        NSLog(@"cur %@", [self.testBookNodes.elementArray objectAtIndex:i]);
        }
        
        i++;
    }
    
//    do {
//        UILineBreakModeCharacterWrap].height - 30 < self.view.frame.size.height) {
//            content = [content stringByAppendingString:[self.testBookNodes.elementArray objectAtIndex:i]];
//            i++;
//    } while (<#condition#>);
    NSString *myHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@;}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body>%@</body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:20], content];
//    
//    CGSize _size = [content sizeWithFont:myFont
//                                   forWidth:320.0f
//                              lineBreakMode:UILineBreakModeCharacterWrap];
    CGSize _size = [content sizeWithFont:myFont constrainedToSize:CGSizeMake(320, 480) lineBreakMode:UILineBreakModeWordWrap];
    NSLogS(_size);
    return myHTML;
}
@end
