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
- (void)AIConfigureWithModel:(id)model;
+ (CGFloat)AIHeightWithModel:(id)model;

@end

@protocol AITableViewSectionProtocal <NSObject>

@required
- (void)AIConfigureWithModel:(id)model;
+ (CGFloat)AIHeightWithModel:(id)model;

@end

typedef void(^AITableViewCellDidSelectBlock)(NSIndexPath *indexPath);

@protocol AITableViewModelProtocal <NSObject>

@optional

@property (nonatomic, copy) AITableViewCellDidSelectBlock AIDidSelectBlock;

@end
