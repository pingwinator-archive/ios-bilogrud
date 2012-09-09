//
//  Cell.m
//  FaceBookUserInfo
//
//  Created by Natasha on 06.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "Cell.h"

@implementation Cell
@synthesize time;
@synthesize name;
@synthesize message;
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize photoImageView;
@synthesize messageLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTime:(NSDate *)c
{
    if (![c isEqual:time]) {
        timeLabel.text = (NSString*)c;
    }
}

- (void)setName:(NSString *)n
{
    if (![n isEqualToString:name]) {
        nameLabel.text = n;
    }
}

- (void)setMessage:(NSString *)m
{
    if (![m isEqualToString:message]) {
        messageLabel.text = m;
       
    }
}
//-(void)prepareForReuse{
//    self.imageView.image = nil;
//}

@end
