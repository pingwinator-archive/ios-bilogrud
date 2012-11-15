//
//  DefineConst.h
//  Tetris
//
//  Created by Natasha on 29.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#ifndef Tetris_DefineConst_h
#define Tetris_DefineConst_h

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject;

#define isiPhone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define isiPad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#ifdef DEBUGGING
# define DBLog(fmt,...) NSLog(@"%@",[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);
#else
# define DBLog(...)
#endif

//http://stackoverflow.com/questions/1902021/suppressing-is-deprecated-when-using-respondstoselector
#define DISABLE_DEPRICADETED_WARNINGS_BEGIN _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\" ")
#define DISABLE_DEPRICADETED_WARNINGS_END _Pragma("clang diagnostic pop")


#define settingFont [UIFont fontWithName:@"American Typewriter" size:20]
#define tutorialFont [UIFont fontWithName:@"American Typewriter" size:15]
#define textButtonFont [UIFont fontWithName:@"American Typewriter" size:10]
#define textButtonFontIPad [UIFont fontWithName:@"American Typewriter" size:12]
#define scoreFont [UIFont fontWithName:@"DS-Digital" size:15]
#define scoreFontLarge [UIFont fontWithName:@"DS-Digital" size:20]
#define scoreFontiPad [UIFont fontWithName:@"DS-Digital" size:30]

#define kRoundedCornerImageSize 10
#define kBorderSize 1
#define cameraIndexButton 1
#endif
