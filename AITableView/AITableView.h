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

@interface AITableViewStaticHeaderFooterModel : NSObject

@property (strong, nonatomic) NSString *value;

@end

@class AITableView;

@protocol AITableViewDelegate <NSObject>

- (void)tableView:(AITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withCellModel:(id)cellModel;

@end

typedef void(^AITableViewDidSelectRowBlock)(AITableView *tableView, NSIndexPath *indexPath, id cellModel);

@interface AITableView : UITableView

@property (nonatomic, weak) id <AITableViewDelegate> AIDelegate;

+ (instancetype)tableView;
+ (instancetype)tableViewWithFrame:(CGRect)frame;
- (void)setAIDidSelectRowBlock:(AITableViewDidSelectRowBlock)didSelectRowBlock;

#pragma mark - Cell

//如果cell不需要对应的model来完成配置，第二个参数请传nil。
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

//如果需要有多个Section 可用以下方法拼装
#pragma mark - Section

- (void)bindHeaderFooterClass:(Class)sectionClass withModelClass:(Class)modelClass;
- (void)bindHeaderFooterNibClass:(Class)sectionNibClass withModelClass:(Class)modelClass;

//如果section不需要对应的model来完成配置，请使用这个方法bind它。
- (void)bindStaticHeaderFooterWithClass:(Class)headerFooterClass;
- (void)bindStaticHeaderFooterWithNibClass:(Class)headerFooterNibClass;

//如果HeaderFooter不需要对应的model来完成配置，可以用此方法生成一个这个cell对应的HeaderFooter。
- (AITableViewStaticHeaderFooterModel *)modelWithStaticHeaderFooterClass:(Class)headerFooterClass;

- (void)updateTableViewWithSections:(NSArray *)sections;


@end

