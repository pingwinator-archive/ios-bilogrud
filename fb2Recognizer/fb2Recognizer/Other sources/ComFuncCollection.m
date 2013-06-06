//
//  ComFuncCollection.m
//  MultiExpoNew
//
//  Created by Natasha on 04.12.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "ComFuncCollection.h"

CGRect CGRectScale(CGRect rect, CGFloat scale) {
    return CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
}

CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
};

BOOL sizeMoreThan(CGSize size, CGFloat side)
{
    return ((size.height > side) || (size.width > side));
}

CGFloat getMinSide(CGSize sizeFirst, CGSize sizeSecond)
{
    return MIN( MIN(sizeFirst.width, sizeFirst.height), MIN(sizeSecond.width, sizeSecond.height));
}

CGSize proportionalMinimizeSize(CGSize size, CGFloat side)
{
    CGSize newSize;
    newSize.width = (size.width > size.height) ? side : side * size.width / size.height;
    newSize.height = (size.width > size.height) ? side * size.height / size.width : side;
    return newSize;
}

UIImage* imageForCurrentDeviceNamed(NSString* nameResourse)
{
    NSString* originalName = nameResourse;
    UIImage* image = nil;
    if (isiPad) {
        nameResourse = [NSString stringWithFormat:@"%@iPad", nameResourse];
    } else {
        if ([[UIDevice currentDevice] has4inchDisplay]) {
            nameResourse = [NSString stringWithFormat:@"%@-568h@2x", nameResourse];
        }
    }
    NSString *pathAndFileName = [[NSBundle mainBundle] pathForResource:nameResourse ofType:@"png"];
    image = imagePNG(([[NSFileManager defaultManager] fileExistsAtPath:pathAndFileName]) ? nameResourse : originalName);
    return image;
}

BOOL isRuLang()
{
    NSString *locString = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    return [locString isEqualToString:@"ru"];
}

BOOL isDeLang()
{
    NSString *locString = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    return [locString isEqualToString:@"de"];
}