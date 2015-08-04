//
//  HAHATableViewCell.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/30.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "HAHATableViewCell.h"

@implementation HAHATableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (NSString *)AIReuseIdentifier
{
    return @"HAHATableViewCellReuseIdentifier";
}

- (void)AIConfigureWithModel:(id)model
{
    
}

+ (CGFloat)AIHeightWithModel:(id)model
{
    return 40.0f;
}


@end
