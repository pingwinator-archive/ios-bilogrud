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


#define settingFont [UIFont fontWithName:@"helvetica" size:25]
#define tutorialFont [UIFont fontWithName:@"American Typewriter" size:15]
#define textButtonFont [UIFont fontWithName:@"American Typewriter" size:10]
#define textButtonFontIPad [UIFont fontWithName:@"American Typewriter" size:12]
#define scoreFont [UIFont fontWithName:@"DS-Digital" size:15]
#define scoreFontLarge [UIFont fontWithName:@"DS-Digital" size:20]
#define scoreFontiPad [UIFont fontWithName:@"DS-Digital" size:30]

#define kRoundedCornerImageSize 10
#define kBorderSize 1
#define cameraIndexButton 1

#define defAlpha 0.5f

#define radiusForItemMenu 130.0f
#define rightPhotoMenuTag 1
#define leftPhotoMenuTag 0
#define rightPhotoTransformAngle M_PI_4/6
#define leftPhotoTransformAngle -M_PI_4/6

#define addPhotoPreViewSize 106.0f
#define editPhotoPreViewSize 63.0f
#define resultEditPhotoSize 228.0f

#define resImageSize 290.0f
#define leftPhotoPreViewTag 1
#define rightPhotoPreViewTag 2


#define startAlpha 0.5f

#define filterNameFont [UIFont fontWithName:@"Anke Calligraphic FG" size:14]
#define shareLabelFont [UIFont fontWithName:@"Anke Calligraphic FG" size:22]
#define shareButtonFont [UIFont fontWithName:@"Anke Calligraphic FG" size:16]

#define shareString @"MultiExpo Photo"
#define okString @"Image was saved"
#define failString @"Image wasn't save"
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
    ImageViewTag_First = 700,
    ImageViewTag_Second
} ImageViewTag;

typedef enum
{
    ItemLocation_Left,
    ItemLocation_Right
} ItemLocation;

typedef enum
{
    ResolutionType_Small,
    ResolutionType_Middle,
    ResolutionType_Max
} ResolutionType;

typedef enum
{
    SlyderType_Opacity = 500,
    SlyderType_Rotation
} SlyderType;

typedef enum {
    NO_FILTER = 0,
    GPUIMAGE_DISSOLVE,
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
    GPUIMAGE_NORMALBLEND,
    GPUIMAGE_NUMFILTERS
} GPUImageollectionFilterType;

// NSLog macro to output a CGRect, CGSize, CGPoint

#define NSLogR(rect) NSLog(@"%@", NSStringFromCGRect(rect))
#define NSLogS(size) NSLog(@"%@", NSStringFromCGSize(size))
#define NSLogP(point) NSLog(@"%@", NSStringFromCGPoint(point))

// Convert degrees to radians

#define degreesToRadians(degrees) degrees / 180.0 * M_PI

#define imagePNG(name) [UIImage imageNamed:  [NSString stringWithFormat:@"%@%@", name, @".png"]]