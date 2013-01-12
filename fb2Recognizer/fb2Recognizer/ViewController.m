//
//  ViewController.m
//  fb2Recognizer
//
//  Created by Natasha on 11.01.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "fb2Parser.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
//    self.label.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.label];
    
    self.testBook = [[fb2Parser alloc] init];
    

    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.textView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.textView];
    
    NSString* bookString = [NSMutableString string];
    for (NSString* s in self.testBook.elementArray) {
        bookString = [bookString stringByAppendingString:s];
    }
    self.textView.text = bookString;
//    NSLog(@"%@",[self.testBook.elementArray objectAtIndex:2]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//
//}
@end
