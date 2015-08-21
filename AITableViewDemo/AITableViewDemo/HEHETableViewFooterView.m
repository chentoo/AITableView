//
//  HEHETableViewFooterView.m
//  AITableViewDemo
//
//  Created by chentoo on 15/8/21.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "HEHETableViewFooterView.h"
#import "AITableViewProtocal.h"

@interface HEHETableViewFooterView () <AITableViewSectionProtocal>

@property (weak, nonatomic) IBOutlet UILabel *footerLabel;

@end

@implementation HEHETableViewFooterView

- (void)awakeFromNib
{
    //do sth.
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.footerLabel.frame = self.bounds;
}


#pragma mark - AITableViewSectionProtocal

- (void)AIConfigureWithModel:(id)model
{
    self.footerLabel.text = @"      footer view!";
}

+ (CGFloat)AIHeightWithModel:(id)model
{
    return 20;
}

+ (NSString *)AIReuseIdentifier
{
    return NSStringFromClass(self.class);
}




@end
