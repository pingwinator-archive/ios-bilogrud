//
//  Generator.h
//  RandomTimerApp
//
//  Created by Natasha on 17.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Generator : NSObject

@property (retain, nonatomic) NSTimer* timer;

- (void)doGenerate;

@end
