//
//  ViewController.m
//  AssetLibraryTest
//
//  Created by Natasha on 26.02.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) ALAssetsLibrary* assetsLibrary;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index,
                                           /* Get the asset type */
                                           BOOL *stop) {
            
            
            NSString *assetType = [result valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto]){
                NSLog(@"This is a photo asset"); }
            else if ([assetType isEqualToString:ALAssetTypeVideo]){
                NSLog(@"This is a video asset");
            }
            else if ([assetType isEqualToString:ALAssetTypeUnknown]){
                NSLog(@"This is an unknown asset");
            }
            /* Get the URLs for the asset */
            NSDictionary *assetURLs = [result valueForProperty:ALAssetPropertyURLs];
            NSUInteger assetCounter = 0;
            for (NSString *assetURLKey in assetURLs){
                assetCounter++;
                NSLog(@"Asset URL %lu = %@",(unsigned long)assetCounter, [assetURLs valueForKey:assetURLKey]);
            }
                    
                /* Get the asset's representation object */ ALAssetRepresentation *assetRepresentation =
                [result defaultRepresentation];
                NSLog(@"Representation Size = %lld", [assetRepresentation size]);
            }];
    }
                            failureBlock:^(NSError *error) {
                                NSLog(@"Failed to enumerate the asset groups.");
                            }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
