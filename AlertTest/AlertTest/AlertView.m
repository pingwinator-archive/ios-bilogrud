//
//  AlertView.m
//  AlertTest
//
//  Created by Natasha on 15.03.13.
//  Copyright (c) 2013 Natasha. All rights reserved.
//

#import "AlertView.h"
#import "UIView+Position.h"

#define heightButton 50
#define offset 20
#define borderOffset 15
@interface AlertView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *messageView;
@property (nonatomic, strong) UIButton* okButton;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* messageLabel;
@property (nonatomic, strong) id<AlertViewDelegate> delegate;
@end
@implementation AlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id )delegate cancelButtonTitle:(NSString *)cancelButtonTitle doneButtonTitles:(NSString *)doneButtonTitle
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.delegate = delegate;
        
        CGSize titlesSize = [title sizeWithFont:shareLabelFont constrainedToSize:CGSizeMake(240, 500)];
        CGSize messageSize = [message sizeWithFont:shareLabelFont constrainedToSize:CGSizeMake(240, 500)];
        
        CGSize maximumLabelSize = CGSizeMake(240,9999);
        CGSize titleSize = [self.titleLabel.text sizeWithFont:shareLabelFont constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        
        NSLog(@"Height: %.f  Width: %.f", titleSize.height, titleSize.width);

        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, messageSize.width, messageSize.height)];
        
        //messageview
        CGRect rect = CGRectMake(20, 300, 280, 100 + titleSize.height + messageSize.height);
        self.messageView = [[UIImageView alloc] initWithFrame:rect];
        self.messageView.userInteractionEnabled = YES;
        self.messageView.image = [UIImage imageNamed:@"alertBg.png"];
        self.messageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        //labels
         
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(borderOffset, borderOffset, 240, titlesSize.height)];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = alertLabelFont;
        self.titleLabel.text = title;
        [self.messageView addSubview:self.titleLabel];
        
//        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(borderOffset, borderOffset, 240, titlesSize.height)];
//        self.messageLabel.numberOfLines = 3;
//        self.messageLabel.backgroundColor = [UIColor clearColor];
//        self.messageLabel.textColor = [UIColor whiteColor];
//        self.messageLabel.font = alertLabelFont;
//        self.messageLabel.text = message;
//        [self.messageView addSubview:self.messageLabel];
        
        //buttons
        self.okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.okButton setBackgroundImage:[UIImage imageNamed:@"alertOk.png"] forState:UIControlStateNormal];
        self.okButton.frame = CGRectMake(borderOffset, self.messageView.bounds.size.height - heightButton - borderOffset, 120, 50);
        self.okButton.titleLabel.font = alertLabelFont;
        [self.okButton setTitle:doneButtonTitle forState:UIControlStateNormal];
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.okButton addTarget:self action:@selector(doneAlert) forControlEvents:UIControlEventTouchUpInside];
        [self.messageView addSubview:self.okButton];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"alertCancel.png"] forState:UIControlStateNormal];
        self.cancelButton.frame = CGRectMake(145, self.messageView.bounds.size.height - heightButton - borderOffset, 120, heightButton);
        self.cancelButton.titleLabel.font = alertLabelFont;
        [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelAlert) forControlEvents:UIControlEventTouchUpInside];
        [self.messageView addSubview:self.cancelButton];
        
        //background
        self.backgroundView = [[UIView alloc] initWithFrame: self.bounds];
        //    self.backgroundView.alpha = 0.2;
        [self.backgroundView setBackgroundColor: [UIColor clearColor]];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.backgroundView];
        [self.backgroundView addCenteredSubview:self.messageView];
        [self.messageView bringSubviewToFront:self];
    }

    return self;
}

- (void)cancelAlert
{
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButton:)]) {
        [self.delegate alertView:self clickedButton:1];
    }
}

- (void)doneAlert
{
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButton:)]) {
        [self.delegate alertView:self clickedButton:0];
    }
}

@end
