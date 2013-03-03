//
//  UIImage+Additions.h
//  PhotoFilters
//
//  Created by Oleg Kovtun on 24.06.12.
//  Copyright (c) 2012 olegftl88@list.ru. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPUImageOpacityFilter;

@interface UIImage (Additions)

CGRect CGRectScale(CGRect rect, CGFloat scale);
- (UIImage*) rotateToOrientation:(UIImageOrientation) orientation;
- (UIImage*) scaleToSize:(CGSize)mSize;
- (UIImage*) proportionalScaleToSize:(CGSize)mSize;
- (CGSize) sizeFromProportionalScaleToSize:(CGSize)mSize;
- (UIImage*) fixOrientation;
- (UIImage*) crop:(CGRect)cropRect;
- (UIImage*) cropCenter:(CGSize)size;
- (BOOL) isBiggerThanSize:(CGSize)mSize;

- (UIImage*) cropWithScreenRes:(CGRect)cropRect;

- (UIImage*) makeCorrectProportionalScale:(CGSize)size;
//- (UIImage*) imageByApplyingAlpha:(CGFloat)alpha;

- (UIImage*) rotatePhoto;
- (UIImageOrientation) rotateOrientation:(UIImageOrientation)start;
- (UIImage*) imageSquareWithBlackStrip:(BOOL)showBlackStrip;
- (NSArray*) imageCropOnSide:(NSInteger)side;
+ (UIImage*) imageFromFilteredPart:(NSArray*)partialImage andSide:(CGFloat)side;

- (UIImage*) softScaleToSide:(CGFloat)side;

+ (UIImage *) processAlbumPhoto:(NSDictionary *)info;

@end
       