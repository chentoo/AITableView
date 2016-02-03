//
//  ViewController.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "ViewController.h"
#import "AITableView.h"
#import "HEHETableViewCell.h"
#import "HEHECellModel.h"
#import "HAHATableViewCell.h"
#import "HEHETableViewHeaderView.h"
#import "HEHETableViewFooterView.h"

@interface ViewController () <AITableViewDelegate>

@property (strong, nonatomic) AITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableview = [AITableView tableViewWithFrame:[UIScreen mainScreen].applicationFrame];
    [self.view addSubview:self.tableview];
    
    [self.tableview bindStaticHeaderFooterWithClass:[HEHETableViewHeaderView class]];
    [self.tableview bindStaticHeaderFooterWithNibClass:[HEHETableViewFooterView class]];
    [self.tableview bindCellClass:[HEHETableViewCell class] withModelClass:[HEHECellModel class]];
    [self.tableview bindStaticCellWithCellNibClass:[HAHATableViewCell class]];
    
    HEHECellModel *model = [[HEHECellModel alloc] init];
    
    model.AIDidSelectBlock = ^(NSIndexPath *indexPath) {
        NSLog(@"通过model 实现 prototal 的方式设置点击事件--%@", indexPath);
    };
    
    AITableViewStaticCellModel *sModel = [self.tableview modelWithStaticCellClass:[HAHATableViewCell class]];
    
    
    AITableViewStaticHeaderFooterModel *headerModel = [self.tableview modelWithStaticHeaderFooterClass:[HEHETableViewHeaderView class]];
    AITableViewStaticHeaderFooterModel *footerModel = [self.tableview modelWithStaticHeaderFooterClass:[HEHETableViewFooterView class]];
    AITableViewSection *aiSection = [AITableViewSection sectionWithHeaderModel:headerModel
                                                                   footerModel:footerModel
                                                                    cellModels:@[model, sModel, sModel, model]];
    
//    [self.tableview updateTableViewWithModels:@[model, sModel, sModel, model]];
    [self.tableview setAIDidSelectRowBlock:^(AITableView *tableView, NSIndexPath *indexPath, id cellModel) {
        NSLog(@"通过AITableView Block 的方式设置点击事件--%@", indexPath);
    }];
    
    [self.tableview updateTableViewWithSections:@[aiSection, aiSection, aiSection]];
    self.tableview.AIDelegate = self;
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
