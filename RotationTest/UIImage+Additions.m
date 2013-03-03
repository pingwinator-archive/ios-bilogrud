//
//  UIImage+Additions.m
//  PhotoFilters
//
//  Created by Oleg Kovtun on 24.06.12.
//  Copyright (c) 2012 olegftl88@list.ru. All rights reserved.
//

#import "UIImage+Additions.h"
//#import "GPUImage.h"

@implementation UIImage (Additions)

CGRect CGRectScale(CGRect rect, CGFloat scale) {
    return CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
}

- (UIImage*) rotateToOrientation:(UIImageOrientation) orientation {
    return [[UIImage alloc] initWithCGImage: self.CGImage
                                      scale: self.scale
                                orientation: orientation];
}

- (UIImage*) scaleToSize:(CGSize)mSize {
    UIGraphicsBeginImageContextWithOptions(mSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, mSize.width, mSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*) softScaleToSide:(CGFloat)side {
    return [UIImage imageWithCGImage:[self CGImage]
                               scale:(MAX(self.size.width, self.size.height) / side) * self.scale
                         orientation:self.imageOrientation];
}

- (UIImage*) proportionalScaleToSize:(CGSize)mSize  {
    return [self scaleToSize:[self sizeFromProportionalScaleToSize:mSize]];
}

- (CGSize) sizeFromProportionalScaleToSize:(CGSize)mSize {
    float widthRatio = mSize.width/self.size.width;
    float heightRatio = mSize.height/self.size.height;
	float minRatio = MIN(widthRatio,heightRatio);	
    return CGSizeMake(self.size.width*minRatio,self.size.height*minRatio);
}

- (UIImage*) fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage*) crop:(CGRect)cropRect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectScale(cropRect, self.scale));
	UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

- (UIImage*) cropWithScreenRes:(CGRect)cropRect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], CGRectScale(cropRect, self.scale));
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:1 orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

- (UIImage*) cropCenter:(CGSize)size {
	
    // This calculates the crop area.
    float originalWidth  = self.size.width;
    float originalHeight = self.size.height;
	
    float posX = (originalWidth   - size.width) / 2.0f;
    float posY = (originalHeight  - size.height) / 2.0f;
	
    CGRect cropSquare = CGRectMake(posX, posY,size.width, size.height);
	
    return [self crop:cropSquare];
}

- (BOOL) isBiggerThanSize:(CGSize)mSize {
    BOOL isBigger = NO;
    if ( self.size.width > mSize.width || self.size.height > mSize.height ) {
        isBigger = YES;
    }
    return isBigger;
}

- (UIImage*) makeCorrectProportionalScale:(CGSize)size {
	return [self proportionalScaleToSize:[self isBiggerThanSize:size]?size:self.size];
}

//- (UIImage*)imageByApplyingAlpha:(CGFloat)alpha
//{
//    GPUImageOpacityFilter* localFilter = [[GPUImageOpacityFilter alloc] init];
//    localFilter.opacity = alpha;
//    return [localFilter imageByFilteringImage:self];
//}

- (UIImage*)rotatePhoto
{
    return [[UIImage alloc] initWithCGImage: self.CGImage scale: 1.0 orientation: [self rotateOrientation:self.imageOrientation]];
}

- (UIImageOrientation)rotateOrientation:(UIImageOrientation)start
{
    UIImageOrientation finish = UIImageOrientationUp;
    switch (start) {
        case UIImageOrientationRight:
            finish = UIImageOrientationUp;
            break;
        case UIImageOrientationDown:
            finish = UIImageOrientationRight;
            break;
        case UIImageOrientationLeft:
            finish = UIImageOrientationDown;
            break;
        case UIImageOrientationUp:
            finish = UIImageOrientationLeft;
            break;
        default:
            break;
    }
    return finish;
}

- (UIImage*)imageSquareWithBlackStrip:(BOOL)showBlackStrip
{
    CGSize size = [self size];
    CGFloat imageViewH, imageViewW, widthExtraStrip, heightExtraStrip;

    imageViewH = imageViewW = showBlackStrip ? MAX(size.width, size.height) : MIN(size.width, size.height);
    widthExtraStrip = (imageViewW - self.size.width)/2;
    heightExtraStrip = (imageViewW - self.size.height)/2;

    CGRect squareRect = CGRectMake(0, 0, imageViewW, imageViewH);
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, squareRect.size.width, squareRect.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGRect rect = CGRectMake(widthExtraStrip, heightExtraStrip, size.width, size.height);
            CGContextDrawImage(ctx, rect, self.CGImage);
   
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

- (NSArray*)imageCropOnSide:(NSInteger)side
{
    NSMutableArray* partialImage = [NSMutableArray array];   
    for (NSInteger i = 0; i < self.size.width / side; i++) {
        for (NSInteger j = 0; j < self.size.height / side; j++) {
            UIImage* croppedImage = [self cropWithScreenRes:CGRectMake(i * side, j * side,
                                                                       ((i + 1) * side <= self.size.width) ? side : (NSInteger)self.size.width % side,
                                                                       ((j + 1) * side <= self.size.height) ? side : (NSInteger)self.size.height % side)];
            CGPoint point = CGPointMake(i, j);
            NSDictionary* dict = @{@"kImage" : croppedImage, @"kPosition" : [NSValue valueWithCGPoint:point]};
            [partialImage addObject:dict];
        }
    }
    return partialImage;
}

+ (UIImage*)imageFromFilteredPart:(NSArray*)partialImage andSide:(CGFloat)side
{
    //size of context = size of image
    NSInteger resWidth = 0;
    NSInteger resHeight = 0;
    for (NSInteger i = 0; i < [partialImage count]; i++) {
        CGPoint p = [[[partialImage objectAtIndex:i] valueForKey:@"kPosition"] CGPointValue];
        if (p.x == 0) {
            resHeight += [[[partialImage objectAtIndex:i] valueForKey:@"kImage"] size].height;
        }
        if (p.y == 0) {
            resWidth += [[[partialImage objectAtIndex:i] valueForKey:@"kImage"] size].width;
        }
    }
    
    CGSize size = CGSizeMake(resWidth, resHeight);
    UIGraphicsBeginImageContext(size);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    
    for (NSInteger k = 0; k < [partialImage count]; k++) {
        NSInteger i = [[[partialImage objectAtIndex:k] valueForKey:@"kPosition"] CGPointValue].x;
        NSInteger j = [[[partialImage objectAtIndex:k] valueForKey:@"kPosition"] CGPointValue].y;
        UIImage* curImage = [[partialImage objectAtIndex:k] valueForKey:@"kImage"];
        CGRect rectLeft = CGRectMake(i * side, j * side, [curImage size].width, [curImage size].height);
//        NSLogR(rectLeft);
        
        [curImage drawInRect:rectLeft blendMode:kCGBlendModeNormal alpha:1.0];
        CGContextStrokeRect(context, rectLeft);
    }

    UIImage *result =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

#pragma mark - Process Album Photo from Image Pick
+ (UIImage *) processAlbumPhoto:(NSDictionary *)info {
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    float original_width = originalImage.size.width;
    float original_height = originalImage.size.height;
    
    if ([info objectForKey:UIImagePickerControllerCropRect] == nil) {
        if (original_width < original_height) {
            /*
             UIGraphicsBeginImageContext(mask.size);
             [ori drawAtPoint:CGPointMake(0,0)];
             [mask drawAtPoint:CGPointMake(0,0)];
             
             UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
             UIGraphicsEndImageContext();
             return newImage;
             */
            return nil;
        } else {
            return nil;
        }
    } else {
        CGRect crop_rect = [[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
        float crop_width = crop_rect.size.width;
        float crop_height = crop_rect.size.height;
        float crop_x = crop_rect.origin.x;
        float crop_y = crop_rect.origin.y;
        float remaining_width = original_width - crop_x;
        float remaining_height = original_height - crop_y;
        
        // due to a bug in iOS
        if ( (crop_x + crop_width) > original_width) {
            NSLog(@" - a bug in x direction occurred! now we fix it!");
            crop_width = original_width - crop_x;
        }
        if ( (crop_y + crop_height) > original_height) {
            NSLog(@" - a bug in y direction occurred! now we fix it!");
            
            crop_height = original_height - crop_y;
        }
        
        float crop_longer_side = 0.0f;
        
        if (crop_width > crop_height) {
            crop_longer_side = crop_width;
        } else {
            crop_longer_side = crop_height;
        }
        //NSLog(@" - ow = %g, oh = %g", original_width, original_height);
        //NSLog(@" - cx = %g, cy = %g, cw = %g, ch = %g", crop_x, crop_y, crop_width, crop_height);
        //NSLog(@" - cls=%g, rw = %g, rh = %g", crop_longer_side, remaining_width, remaining_height);
        if ( (crop_longer_side <= remaining_width) && (crop_longer_side <= remaining_height) ) {
            UIImage *tmpImage = [originalImage cropImageWithBounds:CGRectMake(crop_x, crop_y, crop_longer_side, crop_longer_side)];
            
            return tmpImage;
        } else if ( (crop_longer_side <= remaining_width) && (crop_longer_side > remaining_height) ) {
            UIImage *tmpImage = [originalImage cropImageWithBounds:CGRectMake(crop_x, crop_y, crop_longer_side, remaining_height)];
            
            float new_y = (crop_longer_side - remaining_height) / 2.0f;
            //UIGraphicsBeginImageContext(CGSizeMake(crop_longer_side, crop_longer_side));
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(crop_longer_side, crop_longer_side), YES, 1.0f);
            [tmpImage drawAtPoint:CGPointMake(0.0f,new_y)];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return newImage;
        } else if ( (crop_longer_side > remaining_width) && (crop_longer_side <= remaining_height) ) {
            UIImage *tmpImage = [originalImage cropImageWithBounds:CGRectMake(crop_x, crop_y, remaining_width, crop_longer_side)];
            
            float new_x = (crop_longer_side - remaining_width) / 2.0f;
            //UIGraphicsBeginImageContext(CGSizeMake(crop_longer_side, crop_longer_side));
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(crop_longer_side, crop_longer_side), YES, 1.0f);
            [tmpImage drawAtPoint:CGPointMake(new_x,0.0f)];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return newImage;
        } else {
            return nil;
        }
        
    }
}

CGFloat RadiansOfDegrees(CGFloat degrees) {return degrees * M_PI / 180;};

- (UIImage *)cropImageWithBounds:(CGRect)bounds {
    
    UIImage *tmpImage = [UIImage imageWithCGImage:self.CGImage scale:1.0f orientation:UIImageOrientationUp];
    
    if ((self.imageOrientation == UIImageOrientationUp) || (self.imageOrientation == UIImageOrientationUpMirrored)) {
    } else if ((self.imageOrientation == UIImageOrientationLeft) || (self.imageOrientation == UIImageOrientationLeftMirrored)) {
        tmpImage = [tmpImage imageRotatedByDegrees:-90.0f];
        
    } else if ((self.imageOrientation == UIImageOrientationRight) || (self.imageOrientation == UIImageOrientationRightMirrored)) {
        tmpImage = [tmpImage imageRotatedByDegrees:90.0f];
        
    } else if ((self.imageOrientation == UIImageOrientationDown) || (self.imageOrientation == UIImageOrientationDownMirrored)) {
        tmpImage = [tmpImage imageRotatedByDegrees:180.0f];
        
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([tmpImage CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return croppedImage;
}


- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(RadiansOfDegrees(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, RadiansOfDegrees(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}
@end
