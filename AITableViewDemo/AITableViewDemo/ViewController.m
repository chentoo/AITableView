//
//  ViewController.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "ViewController.h"
#import "AITableView.h"
#import "DemoTableViewHeaderView.h"
#import "DemoTableViewFooterView.h"
#import "DemoNameCellModel.h"
#import "DemoTableViewNameCell.h"
#import "DemoTableViewPhoneCell.h"

@interface ViewController () <AITableViewDelegate>

@property (strong, nonatomic) AITableView *topTableview;
@property (strong, nonatomic) AITableView *bottomTableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 包含section的 topTableview
    [self configureTopTableView];
    // 不含section的简单 bottomTableView
    [self configureBottomTableView];
}

- (void)configureTopTableView
{
    self.topTableview = [AITableView tableViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2)];
    [self.view addSubview:self.topTableview];
    
    [self.topTableview bindStaticHeaderFooterWithClass:[DemoTableViewHeaderView class]];
    [self.topTableview bindStaticHeaderFooterWithNibClass:[DemoTableViewFooterView class]];
    
    [self.topTableview bindCellClass:[DemoTableViewNameCell class] withModelClass:[DemoNameCellModel class]];
    [self.topTableview bindStaticCellWithCellClass:[DemoTableViewPhoneCell class]];
    
    DemoNameCellModel *nameCellmodel = [[DemoNameCellModel alloc] init];
    nameCellmodel.name = @"我是名字";
    
    AITableViewStaticCellModel *phoneCellModel = [self.topTableview modelWithStaticCellClass:[DemoTableViewPhoneCell class]];
    
    AITableViewStaticHeaderFooterModel *headerModel = [self.topTableview modelWithStaticHeaderFooterClass:[DemoTableViewHeaderView class]];
    AITableViewStaticHeaderFooterModel *footerModel = [self.topTableview modelWithStaticHeaderFooterClass:[DemoTableViewFooterView class]];
    AITableViewSection *aiSection = [AITableViewSection sectionWithHeaderModel:headerModel
                                                                   footerModel:footerModel
                                                                    cellModels:@[nameCellmodel, phoneCellModel]];
    
    //    [self.tableview updateTableViewWithModels:@[model, sModel, sModel, model]];
    [self.topTableview setAIDidSelectRowBlock:^(AITableView *tableView, NSIndexPath *indexPath, id cellModel) {
        NSLog(@"通过AITableView Block 的方式设置点击事件--%@", indexPath);
    }];
    
    [self.topTableview updateTableViewWithSections:@[aiSection, aiSection, aiSection]];
    self.topTableview.AIDelegate = self;
}

- (void)configureBottomTableView
{
    self.bottomTableview = [AITableView tableViewWithFrame:CGRectMake(0, self.view.bounds.size.height / 2 + 100, self.view.bounds.size.width, self.view.bounds.size.height / 2)];
    [self.view addSubview:self.bottomTableview];
    
    [self.bottomTableview bindCellClass:[DemoTableViewNameCell class] withModelClass:[DemoNameCellModel class]];
    [self.bottomTableview bindStaticCellWithCellClass:[DemoTableViewPhoneCell class]];
    
    DemoNameCellModel *nameCellmodel = [[DemoNameCellModel alloc] init];
    nameCellmodel.name = @"我是名字";
    nameCellmodel.AIDidSelectBlock = ^(NSIndexPath *indexPath) {
        NSLog(@"通过实现model protocal 的方式设置点击事件--%@", indexPath);
    };
    
    AITableViewStaticCellModel *phoneCellModel = [self.topTableview modelWithStaticCellClass:[DemoTableViewPhoneCell class]];
    
    [self.bottomTableview setAIDidSelectRowBlock:^(AITableView *tableView, NSIndexPath *indexPath, id cellModel) {
        NSLog(@"通过AITableView Block 的方式设置点击事件--%@", indexPath);
    }];
    
    self.bottomTableview.AIDelegate = self;
    [self.bottomTableview updateTableViewWithModels:@[nameCellmodel, phoneCellModel]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AITableViewDelegate

- (void)tableView:(AITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withCellModel:(id)cellModel
{
    NSLog(@"通过AITableViewDelegate 的方式设置点击事件--%@", indexPath);
}

@end
