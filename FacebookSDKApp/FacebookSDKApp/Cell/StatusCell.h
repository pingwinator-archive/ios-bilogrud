//
//  StatusCell.h
//  FacebookSDKApp
//
//  Created by Natasha on 11.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfloadImage.h"

#define kCellOffset 59
#define kFontMesage 14

@interface StatusCell : UITableViewCell
@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSString *time;
@property(retain, nonatomic) NSString *message;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet SelfloadImage *photoImageView;
@property (retain, nonatomic) IBOutlet UILabel *messageLabel;

@end
