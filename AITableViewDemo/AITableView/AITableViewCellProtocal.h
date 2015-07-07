//
//  AITableViewCellProtocal.h
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AITableViewCellProtocal <NSObject>

@required

- (void)configureWithModel:(id)model;
+ (NSString *)reuseIdentifier;

@optional
+ (CGFloat)heightWithModel:(id)model;

@end
