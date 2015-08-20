//
//  AITableView.h
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AITableViewSection.h"

@interface AITableViewStaticCellModel : NSObject

@property (strong, nonatomic) NSString *value;

@end

@interface AITableViewStaticSectionModel : NSObject

@property (strong, nonatomic) NSString *value;

@end


@interface AITableView : UITableView

+ (instancetype)tableView;
+ (instancetype)tableViewWithFrame:(CGRect)frame;

#pragma mark - Cell

//如果cell不需要对应的model来完成配置，第一个参数请传nil。
//但建议使用 - bindStatacCellClass 来完成 cell bind。
- (void)bindCellClass:(Class)cellClass withModelClass:(Class)modelClass;
- (void)bindCellNibClass:(Class)cellNibClass withModelClass:(Class)modelClass;

//如果cell不需要对应的model来完成配置，请使用这个方法bind它。
- (void)bindStaticCellWithCellClass:(Class)cellClass;
- (void)bindStaticCellWithCellNibClass:(Class)cellNibClass;

//如果cell不需要对应的model来完成配置，可以用此方法生成一个这个cell对应的model，放入updateTabelViewWithModels的models 中。
- (AITableViewStaticCellModel *)modelWithStaticCellClass:(Class)cellClass;

//更新tableview，根据传入的models
- (void)updateTableViewWithModels:(NSArray *)models;


#pragma mark - Section

- (void)bindSectionClass:(Class)sectionClass withModelClass:(Class)modelClass;
- (void)bindSectionNibClass:(Class)sectionNibClass withModelClass:(Class)modelClass;

//如果section不需要对应的model来完成配置，请使用这个方法bind它。
- (void)bindStaticSectionWithSectionClass:(Class)sectionClass;
- (void)bindStaticSectionWithSectionNibClass:(Class)sectionNibClass;

//如果cell不需要对应的model来完成配置，可以用此方法生成一个这个cell对应的model，放入updateTabelViewWithModels的models 中。
- (AITableViewStaticSectionModel *)modelWithStaticSectionClass:(Class)sectionClass;

- (void)updateTableViewWithSections:(NSArray *)sections;


@end

