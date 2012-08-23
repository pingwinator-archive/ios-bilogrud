//
//  NameAndColorCell.h
//  Cells
//
//  Created by Natasha on 22.08.12.
//  Copyright (c) 2012 Natasha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameAndColorCell : UITableViewCell
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *color;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *colorLabel;
@end
