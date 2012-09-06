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
@synthesize photo;
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize photoImageView;
@synthesize messageTextView;
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
- (void)setTime:(NSDate *)c {
    if (![c isEqual:time]) {
//?????
       // self.time = [c copy];
        time = [c copy];
        timeLabel.text = (NSString*)time;
    }
}

- (void)setName:(NSString *)n {
    if (![n isEqualToString:name]) {
        name = [n copy];
        nameLabel.text = name;
    }
}

- (void)setMessage:(NSString *)m{
    if (![m isEqualToString:message]) {
        message = [m copy];
        messageTextView.text = message;
    }
}
- (void)setPhoto:(UIImage *)n {
    if (![n isEqual:photo]) {
        photo = [n copy];
        photoImageView.image = photo;
    }
}

@end
