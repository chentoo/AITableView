//
//  HEHETableViewHeaderView.m
//  AITableViewDemo
//
//  Created by chentoo on 15/8/20.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "HEHETableViewHeaderView.h"
#import "AITableViewProtocal.h"

@interface HEHETableViewHeaderView () <AITableViewSectionProtocal>

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation HEHETableViewHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}


#pragma mark - AITableViewSectionProtocal

- (void)AIConfigureWithModel:(id)model
{
    self.titleLabel.text = @"      Head view!";
}

+ (CGFloat)AIHeightWithModel:(id)model
{
    return 50;
}

+ (NSString *)AIReuseIdentifier
{
    return NSStringFromClass(self.class);
}


@end
