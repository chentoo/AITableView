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

@interface ViewController ()

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
    AITableViewStaticCellModel *sModel = [self.tableview modelWithStaticCellClass:[HAHATableViewCell class]];
    
    AITableViewStaticHeaderFooterModel *headerModel = [self.tableview modelWithStaticHeaderFooterClass:[HEHETableViewHeaderView class]];
    AITableViewStaticHeaderFooterModel *footerModel = [self.tableview modelWithStaticHeaderFooterClass:[HEHETableViewFooterView class]];
    AITableViewSection *aiSection = [AITableViewSection sectionWithHeaderModel:headerModel
                                                                   footerModel:footerModel
                                                                    cellModels:@[model, sModel, sModel, model]];
    
//    [self.tableview updateTableViewWithModels:@[model, sModel, sModel, model]];
    [self.tableview updateTableViewWithSections:@[aiSection, aiSection, aiSection]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
