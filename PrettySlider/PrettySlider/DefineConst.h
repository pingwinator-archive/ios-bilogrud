//
//  DefineConst.h
//  
//
//  Created by Natasha on 29.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//


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

#define GCD_BACKGROUND_BEGIN  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
#define GCD_MAIN_BEGIN dispatch_async(dispatch_get_main_queue(), ^{
#define GCD_END });

#define maxImageSize 2000

#define kRoundedCornerImageSize 10
#define kBorderSize 1
#define cameraIndexButton 1

#define radiusForItemMenu 130.0f
#define rightPhotoMenuTag 1
#define leftPhotoMenuTag 0
#define rightPhotoTransformAngle M_PI_4/6
#define leftPhotoTransformAngle -M_PI_4/6

#define resImageSize 290.0f
#define leftPhotoPreViewTag 1
#define rightPhotoPreViewTag 2

#define resultEditPhotoSize 228.0f
#define resultEditPhotoSize4inch 247.0f

#define editPhotoPreViewSize 63.0f
#define editPhotoPreViewImageSize editPhotoPreViewSize*2
//parametres scrollview item
#define menuItemWidth 80
#define menuItemHeight 80

//fonts

#define filterNameFont [UIFont fontWithName:@"HomemadeApple" size:12]
#define shareLabelFont [UIFont fontWithName:@"HomemadeApple" size:20]

//strings

#define shareString @"MultiExpo Photo"
#define sucessSaveString @"The image is saved"
#define failSaveString @"The image is not saved"
#define failEnableLocationString @"You need to able location services to saving image"
#define okString @"Ok"
#define noInternetString @"No internet connection"
#define interruptString @"The operation was interrupted"
#define noAppString @"No other app"
#define noInstaString @"Oops! Please, install Instagram"
#define noMailString @"No avaliable mail account"


// parametrs for result image 
#define maxResultImageResolution 3000
#define maxResultImageSize CGSizeMake(maxResultImageResolution, maxResultImageResolution)

typedef enum{
    IconState_IconPlain,
    IconState_IconChoose,
    IconState_IconChooseActive
} IconState;

typedef enum{
    PolaroidType_FirstIconType,
    PolaroidType_SecondIconType
} PolaroidType;

typedef enum
{
    ItemLocation_Left,
    ItemLocation_Right, 
    ItemLocation_Undefine
} ItemLocation;

typedef enum
{
    ResolutionType_Small,
    ResolutionType_Middle,
    ResolutionType_Max
} ResolutionType;

typedef enum {
    NO_FILTER = 0,
    GPUIMAGE_ADD,
    GPUIMAGE_DIVIDE,
    GPUIMAGE_MULTIPLY,
    GPUIMAGE_OVERLAY,
    GPUIMAGE_LIGHTEN,
    GPUIMAGE_DARKEN,
    GPUIMAGE_COLORBURN,
    GPUIMAGE_COLORDODGE,
    GPUIMAGE_SCREENBLEND,
    GPUIMAGE_DIFFERENCEBLEND,
    GPUIMAGE_SUBTRACTBLEND,
    GPUIMAGE_EXCLUSIONBLEND,
    GPUIMAGE_HARDLIGHTBLEND,
    GPUIMAGE_SOFTLIGHTBLEND,
    GPUIMAGE_AMATORKA,
    GPUIMAGE_MISSETIKATE,
    GPUIMAGE_EROSION,
    GPUIMAGE_NUMFILTERS
} GPUImageollectionFilterType;


#define leftImageAlpha(v) (1 - v)
#define rightImageAlpha(v) v

// NSLog macro to output a CGRect, CGSize, CGPoint

#define NSLogR(rect) NSLog(@"%@", NSStringFromCGRect(rect))
#define NSLogS(size) NSLog(@"%@", NSStringFromCGSize(size))
#define NSLogP(point) NSLog(@"%@", NSStringFromCGPoint(point))

// Convert degrees to radians

#define degreesToRadians(degrees) degrees / 180.0 * M_PI

#define imagePNG(name) [UIImage imageNamed:  [NSString stringWithFormat:@"%@%@", name, @".png"]]


//  System Versioning Preprocessor Macros


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
