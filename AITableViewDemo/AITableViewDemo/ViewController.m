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

@interface ViewController ()

@property (strong, nonatomic) AITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableview = [AITableView tableViewWithFrame:self.view.bounds];
    [self.view addSubview:self.tableview];
    
    [self.tableview bindStaticSectionWithSectionClass:[HEHETableViewHeaderView class]];
    [self.tableview bindCellClass:[HEHETableViewCell class] withModelClass:[HEHECellModel class]];
    [self.tableview bindStaticCellWithCellNibClass:[HAHATableViewCell class]];
    
    
    HEHECellModel *model = [[HEHECellModel alloc] init];
    AITableViewStaticCellModel *sModel = [self.tableview modelWithStaticCellClass:[HAHATableViewCell class]];
    
    AITableViewStaticHeaderFooterModel *headerModel = [self.tableview modelWithStaticSectionClass:[HEHETableViewHeaderView class]];
    AITableViewSection *aiSection = [AITableViewSection sectionWithHeaderModel:headerModel
                                                                   footerModel:nil
                                                                    cellModels:@[model, sModel, sModel, model]];
    
//    [self.tableview updateTableViewWithModels:@[model, sModel, sModel, model]];
    [self.tableview updateTableViewWithSections:@[aiSection, aiSection, aiSection]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
