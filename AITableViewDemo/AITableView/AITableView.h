//
//  AITableView.h
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AITableView : UITableView

- (void)registerCellWithClass:(Class)cellClass;
- (void)registerCellWithNib:(Class)nibClass;

@end
