//
//  AITableView.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "AITableView.h"
#import "AITableViewCellProtocal.h"

@implementation AITableViewStaticCellModel

@end

static NSString * const kAITableViewBindDicModelDefault = @"kAITableViewBindDicModelDefault";

@interface AITableView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *bindDic;
@property (strong, nonatomic) NSArray *models;

@end

@implementation AITableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _models = [NSArray array];
        _bindDic = [NSMutableDictionary dictionary];
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

+ (instancetype)tableView
{
    AITableView *tableView = [[AITableView alloc] init];
    
    return tableView;
}

+ (instancetype)tableViewWithFrame:(CGRect)frame
{
    AITableView *tableView = [AITableView tableView];
    tableView.frame = frame;
    
    return tableView;
}

#pragma mark - Public

- (void)bindModelClass:(Class)modelClass withCellClass:(Class)cellClass
{
    [self registerCellWithClass:cellClass];
    if (modelClass)
    {
        [self.bindDic setObject:NSStringFromClass(cellClass) forKey:NSStringFromClass(modelClass)];
    }
    else
    {
        NSString *key = [self keyOfBindDicWithStaticCellClassName:NSStringFromClass(cellClass)];
        [self.bindDic setObject:NSStringFromClass(cellClass) forKey:key];
    }
}

- (void)bindModelClass:(Class)modelClass withCellNibClass:(Class)cellNibClass
{
    [self registerCellWithNib:cellNibClass];
    if (modelClass)
    {
        [self.bindDic setObject:NSStringFromClass(cellNibClass) forKey:NSStringFromClass(modelClass)];
    }
    else
    {
        NSString *key = [self keyOfBindDicWithStaticCellClassName:NSStringFromClass(cellNibClass)];
        [self.bindDic setObject:NSStringFromClass(cellNibClass) forKey:key];
        
    }
}

- (void)bindStaticCellWithCellClass:(Class)cellClass
{
    [self bindModelClass:nil withCellClass:cellClass];
}

- (void)bindStaticCellWithCellNibClass:(Class)cellNibClass
{
    [self bindModelClass:nil withCellNibClass:cellNibClass];
}

- (AITableViewStaticCellModel *)modelWithStaticCellClass:(Class)cellClass
{
    AITableViewStaticCellModel *model = [[AITableViewStaticCellModel alloc] init];
    model.value = [self keyOfBindDicWithStaticCellClassName:NSStringFromClass(cellClass)];
    return model;
}

- (void)updateTableViewWithModels:(NSArray *)models
{
    self.models = models;
    [self reloadData];
}

#pragma mark - Reigster Cell

- (void)registerCellWithClass:(Class)cellClass
{
    if(![cellClass conformsToProtocol:@protocol(AITableViewCellProtocal)])
    {
        NSAssert(NO, @"Your cell did not have protocal : AITableViewCellProtocal");
        return;
    }
    
    NSString *cellIdentifier = [self identifierOfCellClass:cellClass];
    NSAssert(cellIdentifier, @"Your cell protocal AITableViewCellProtocal 's method :' + reuseIdentifier ' return nil or empty!");

    [self registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
}

- (void)registerCellWithNib:(Class)nibClass
{
    if(![nibClass conformsToProtocol:@protocol(AITableViewCellProtocal)])
    {
        NSAssert(NO, @"Your cell did not have protocal : AITableViewCellProtocal");
        return;
    }
    
    NSString *cellIdentifier = [self identifierOfCellClass:nibClass];
    NSAssert(cellIdentifier, @"Your cell protocal AITableViewCellProtocal 's method :' + reuseIdentifier ' return nil or empty!");

    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:NSStringFromClass(nibClass) ofType:@"nib"];
    NSAssert(path, @"Your cell class nib is nil!");
    if (path.length > 0) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(nibClass) bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:cellIdentifier];
    }
}

#pragma mark - Private

- (NSString *)keyOfBindDicWithStaticCellClassName:(NSString *)cellClassName
{
    return [kAITableViewBindDicModelDefault stringByAppendingString:cellClassName];
}

- (NSString *)identifierOfCellClass:(Class)cellClass
{
    Class <AITableViewCellProtocal> cellClassProtocal = cellClass;
    return [cellClassProtocal AIReuseIdentifier];
}

- (Class)cellClassWithBindModel:(id)model
{
    NSString *cellModelClassName;
    if ([model isKindOfClass:[AITableViewStaticCellModel class]])
    {
        cellModelClassName = [(AITableViewStaticCellModel *)model value];
    }
    else
    {
        cellModelClassName = NSStringFromClass([model class]);
    }

    NSString *cellClassName = self.bindDic[cellModelClassName];
    Class cellClass = NSClassFromString(cellClassName);
    return cellClass;
}

#pragma mark - UITableView Datesource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel = self.models[indexPath.row];
    Class cellClass = [self cellClassWithBindModel:cellModel];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self identifierOfCellClass:cellClass] forIndexPath:indexPath];
    [cell performSelector:@selector(AIConfigureWithModel:) withObject:cellModel];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel = self.models[indexPath.row];
    Class cellClass = [self cellClassWithBindModel:cellModel];
    Class <AITableViewCellProtocal> cellClassProtocal = cellClass;

    return [cellClassProtocal AIHeightWithModel:cellModel];
}

@end

