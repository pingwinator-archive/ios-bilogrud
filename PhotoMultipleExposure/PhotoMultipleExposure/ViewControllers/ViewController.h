//
//  ViewController.h
//  PhotoMultipleExposure
//
//  Created by Natasha on 14.11.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    firstPhotoSlider = 0,
    secondPhotoSlider,
    nonePhoto
} PhotoSliderNumber;
@interface ViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (assign, nonatomic) UIImage* resultImage;
@end
