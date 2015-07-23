//
//  AITableView.h
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AITableView : UITableView

+ (instancetype)tableView;
+ (instancetype)tableViewWithFrame:(CGRect)frame;

- (void)bindModelClass:(Class)modelClass withCellClass:(Class)cellClass;
- (void)bindModelClass:(Class)modelClass withCellNibClass:(Class)cellNibClass;
- (void)updateTabelViewWithModels:(NSArray *)models;

@end
