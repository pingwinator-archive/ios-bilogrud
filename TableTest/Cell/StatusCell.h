//
//  StatusCell.h
//  FacebookSDKApp
//
//  Created by Natasha on 11.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusCell : UITableViewCell
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) IBOutlet UILabel* nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView* imageView;
@end
