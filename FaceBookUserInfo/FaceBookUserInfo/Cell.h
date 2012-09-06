//
//  Cell.h
//  FaceBookUserInfo
//
//  Created by Natasha on 06.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfloadImage.h"
//fonts
#define kCellOffset 50
#define kFontMesage 14
@interface Cell : UITableViewCell
@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSDate *time;
@property(retain, nonatomic) NSString *message;
//@property(retain, nonatomic) UIImage *photo;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet SelfloadImage *photoImageView;
@property (retain, nonatomic) IBOutlet UILabel *messageLabel;
@end
