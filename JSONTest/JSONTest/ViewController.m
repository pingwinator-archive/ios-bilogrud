//
//  ViewController.m
//  JSONTest
//
//  Created by Natasha on 06.06.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableData *jsonData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // создаем объект NSURL с адресом, на который будет идти запрос
    NSURL *url = [ NSURL URLWithString: @"https://graph.facebook.com/19292868552" ];
    
    // создаем объект NSURLRequest - запрос
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    // запускаем соединение
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        self.jsonData = [NSMutableData data];
    } else {
        NSLog(@"Connection failed");
    }
}

/**
 * При получении новой порции данных добавляем их к уже полученным
 **/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.jsonData appendData:data];
}

/**
 * Если соединение не удалось - выводим в консоль сообщение об ошибке
 **/
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

/**
 * Когда все данные получены - разбираем их
 **/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// сохраняем полученные данные в строку result
	NSString *result = [[NSString alloc] initWithData:self.jsonData encoding:NSUTF8StringEncoding];
	
	// можно вывести в консоль и посмотреть - что мы получили
	NSLog( @"%@",result );
    
    
	// создаем объект с JSON-парсером
	SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
	
	
	// Парсим строку данных result в объект класса NSArray (массив)
	NSArray *dataObject = [jsonParser objectWithString:result];
	
    NSLog(@"check");
}
@end
