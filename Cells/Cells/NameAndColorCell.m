//
//  NameAndColorCell.m
//  Cells
//
//  Created by Natasha on 22.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import "NameAndColorCell.h"
@implementation NameAndColorCell
@synthesize name;
@synthesize color;
@synthesize colorLabel;
@synthesize nameLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
//        UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
//        nameLabel.textAlignment = UITextAlignmentRight;
//        nameLabel.text = @"Name:";
//        nameLabel.font = [UIFont boldSystemFontOfSize:12];
//        [self.contentView addSubview: nameLabel];
//        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
//        UILabel *colorLabel = [[UILabel alloc] initWithFrame:colorLabelRect];
//        colorLabel.textAlignment = UITextAlignmentRight;
//        colorLabel.text = @"Color:";
//        colorLabel.font = [UIFont boldSystemFontOfSize:12];
//        [self.contentView addSubview: colorLabel];
//        CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
//        UILabel *nameValue = [[UILabel alloc] initWithFrame: nameValueRect];
//        nameValue.tag = kNameValueTag;
//        [self.contentView addSubview:nameValue];
//        CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
//        UILabel *colorValue = [[UILabel alloc] initWithFrame:colorValueRect];
//        colorValue.tag = kColorValueTag;
//        [self.contentView addSubview:colorValue];
//    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setName:(NSString *)n {
    if (![n isEqualToString:name]) {
        name = [n copy];
        nameLabel.text = name;
    }
}
- (void)setColor:(NSString *)c {
    if (![c isEqualToString:color]) {
        color = [c copy];
        colorLabel.text = color;
    }
}
@end
