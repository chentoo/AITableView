//
//  DemoTableViewNameCell.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 16/2/3.
//  Copyright © 2016年 chentoo. All rights reserved.
//

#import "DemoTableViewNameCell.h"
#import "AITableViewProtocal.h"
#import "DemoNameCellModel.h"

@interface DemoTableViewNameCell ()  <AITableViewCellProtocal>

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation DemoTableViewNameCell

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
    _nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameLabel.frame = self.bounds;
}

#pragma mark - AITableViewCellProtocal

- (void)AIConfigureWithModel:(DemoNameCellModel *)model
{
    self.nameLabel.text = model.name;
}

+ (CGFloat)AIHeightWithModel:(id)model
{
    return 30.0f;
}

@end
