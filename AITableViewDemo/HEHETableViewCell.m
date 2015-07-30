//
//  HEHETableViewCell.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "HEHETableViewCell.h"

@implementation HEHETableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+ (NSString *)AIReuseIdentifier
{
    return @"sbsbsbsbsbs";
}

- (void)AIConfigureWithModel:(id)model
{
    self.textLabel.text = @"月月DSB";
}

+ (CGFloat)AIHeightWithModel:(id)model
{
    return 40.0f;
}

@end
