//
//  StatusCell.m
//  FacebookSDKApp
//
//  Created by Natasha on 11.09.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "StatusCell.h"


@implementation StatusCell
@synthesize time;
@synthesize name;
@synthesize message;
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize photoImageView;
@synthesize messageLabel;
@synthesize likeLabel;

-(void) dealloc
{
    self.likeLabel = nil;
    self.time = nil;
    self.name = nil;
    self.message = nil;
    self.messageLabel = nil;
    self.nameLabel = nil;
    self.timeLabel = nil;
    self.photoImageView = nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
    [name release];
    name = [n retain];
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
@end
