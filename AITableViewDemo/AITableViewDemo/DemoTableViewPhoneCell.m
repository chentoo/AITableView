//
//  DemoTableViewPhoneCell.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 16/2/3.
//  Copyright © 2016年 chentoo. All rights reserved.
//

#import "DemoTableViewPhoneCell.h"
#import "AITableViewProtocal.h"

@interface DemoTableViewPhoneCell () <AITableViewCellProtocal>

@property (nonatomic, copy) UILabel *phoneLabel;

@end

@implementation DemoTableViewPhoneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.font = [UIFont systemFontOfSize:10.0f];
    [self.contentView addSubview:_phoneLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.phoneLabel.frame = self.bounds;
}

#pragma mark - AITableViewCellProtocal

- (void)AIConfigureWithModel:(id)model
{
    self.phoneLabel.text = @"1392883322";
}

+ (CGFloat)AIHeightWithModel:(id)model
{
    return 20.0f;
}

@end
