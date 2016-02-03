//
//  AITableView.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "AITableView.h"
#import "AITableViewProtocal.h"

@implementation AITableViewStaticCellModel

@end

@implementation AITableViewStaticHeaderFooterModel

@end

static NSString * const kAITableViewBindDicModelDefault = @"kAITableViewBindDicModelDefault";

@interface AITableView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *bindDic;
@property (strong, nonatomic) NSMutableDictionary *bindSectionDic;
@property (strong, nonatomic) NSArray *models;
@property (strong, nonatomic) NSArray *sections;
@property (nonatomic, copy) AITableViewDidSelectRowBlock didSelectRowBlock;

@end

@implementation AITableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _models = [NSArray array];
        _sections = [NSArray array];
        _bindDic = [NSMutableDictionary dictionary];
        _bindSectionDic = [NSMutableDictionary dictionary];
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

- (void)setAIDidSelectRowBlock:(AITableViewDidSelectRowBlock)didSelectRowBlock
{
    self.didSelectRowBlock = didSelectRowBlock;
}

#pragma mark - Cell Public

- (void)bindCellClass:(Class)cellClass withModelClass:(Class)modelClass
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

- (void)bindCellNibClass:(Class)cellNibClass withModelClass:(Class)modelClass
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
    [self bindCellClass:cellClass withModelClass:Nil];
}

- (void)bindStaticCellWithCellNibClass:(Class)cellNibClass
{
    [self bindCellNibClass:cellNibClass withModelClass:Nil];
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

#pragma mark - Section Public

- (void)bindHeaderFooterClass:(Class)sectionClass withModelClass:(Class)modelClass
{
    [self registerSectionWithClass:sectionClass];
    if (modelClass)
    {
        [self.bindSectionDic setObject:NSStringFromClass(sectionClass) forKey:NSStringFromClass(modelClass)];
    }
    else
    {
        NSString *key = [self keyOfBindSectionDicWithStaticSectionClassName:NSStringFromClass(sectionClass)];
        [self.bindSectionDic setObject:NSStringFromClass(sectionClass) forKey:key];
    }
}

- (void)bindHeaderFooterNibClass:(Class)sectionNibClass withModelClass:(Class)modelClass
{
    [self registerSectionWithNibClass:sectionNibClass];
    if (modelClass)
    {
        [self.bindSectionDic setObject:NSStringFromClass(sectionNibClass) forKey:NSStringFromClass(modelClass)];
    }
    else
    {
        NSString *key = [self keyOfBindSectionDicWithStaticSectionClassName:NSStringFromClass(sectionNibClass)];
        [self.bindSectionDic setObject:NSStringFromClass(sectionNibClass) forKey:key];
    }
}

- (void)bindStaticHeaderFooterWithClass:(Class)headerFooterClass
{
    [self bindHeaderFooterClass:headerFooterClass withModelClass:Nil];
}

- (void)bindStaticHeaderFooterWithNibClass:(Class)headerFooterNibClass
{
    [self bindHeaderFooterNibClass:headerFooterNibClass withModelClass:Nil];
}

- (AITableViewStaticHeaderFooterModel *)modelWithStaticHeaderFooterClass:(Class)headerFooterClass
{
    AITableViewStaticHeaderFooterModel *model = [[AITableViewStaticHeaderFooterModel alloc] init];
    model.value = [self keyOfBindSectionDicWithStaticSectionClassName:NSStringFromClass(headerFooterClass)];
    return model;
}

- (void)updateTableViewWithSections:(NSArray *)sections
{
    self.sections = sections;
    self.models = nil;
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

#pragma mark - Reigster Section

- (void)registerSectionWithClass:(Class)sectionClass
{
    if(![sectionClass conformsToProtocol:@protocol(AITableViewSectionProtocal)])
    {
        NSAssert(NO, @"Your sectionClass did not have protocal : AITableViewSectionProtocal");
        return;
    }
    NSString *sectionIdentifier = [self identifierOfSectionClass:sectionClass];
    if (sectionIdentifier.length == 0) {
        NSAssert(NO, @"Your section protocal AITableViewSectionProtocal 's method :' + reuseIdentifier ' return nil or empty!");
    }
    else {
        [self registerClass:sectionClass forHeaderFooterViewReuseIdentifier:sectionIdentifier];
    }
}

- (void)registerSectionWithNibClass:(Class)sectionNibClass
{
    if(![sectionNibClass conformsToProtocol:@protocol(AITableViewSectionProtocal)])
    {
        NSAssert(NO, @"Your sectionClass did not have protocal : AITableViewSectionProtocal");
        return;
    }
    NSString *sectionIdentifier = [self identifierOfSectionClass:sectionNibClass];
    if (sectionIdentifier.length == 0) {
        NSAssert(NO, @"Your section protocal AITableViewSectionProtocal 's method :' + reuseIdentifier ' return nil or empty!");
    }
    else {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *path = [mainBundle pathForResource:NSStringFromClass(sectionNibClass) ofType:@"nib"];
        NSAssert(path, @"Your cell class nib is nil!");
        if (path.length > 0) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass(sectionNibClass) bundle:nil];
            [self registerNib:nib forHeaderFooterViewReuseIdentifier:sectionIdentifier];
        }
    }
}

#pragma mark - Cell Private

- (NSString *)keyOfBindDicWithStaticCellClassName:(NSString *)cellClassName
{
    return [kAITableViewBindDicModelDefault stringByAppendingString:cellClassName];
}

- (NSString *)identifierOfCellClass:(Class)cellClass
{
//    Class <AITableViewCellProtocal> cellClassProtocal = cellClass;
//    return [cellClassProtocal AIReuseIdentifier];
    return NSStringFromClass(cellClass);
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

#pragma mark - Section Private

- (NSString *)keyOfBindSectionDicWithStaticSectionClassName:(NSString *)sectionClassName
{
    return [kAITableViewBindDicModelDefault stringByAppendingString:sectionClassName];
}

- (NSString *)identifierOfSectionClass:(Class)sectionClass
{
//    Class <AITableViewSectionProtocal> sectionClassProtocal = sectionClass;
//    return [sectionClassProtocal AIReuseIdentifier];
    return NSStringFromClass(sectionClass);
}

- (Class)sectionClassWithBindModel:(id)model
{
    NSString *sectionModelClassName;
    if ([model isKindOfClass:[AITableViewStaticHeaderFooterModel class]])
    {
        sectionModelClassName = [(AITableViewStaticHeaderFooterModel *)model value];
    }
    else
    {
        sectionModelClassName = NSStringFromClass([model class]);
    }
    
    NSString *sectionClassName = self.bindSectionDic[sectionModelClassName];
    Class sectionClass = NSClassFromString(sectionClassName);
    return sectionClass;
}

#pragma mark - UITableView Datesource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MAX(self.sections.count, 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sections.count > 0) {
        AITableViewSection *sectionObject = self.sections[section];

        return sectionObject.cellModels.count;
    }
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel;
    if (self.sections.count > 0) {
        AITableViewSection *sectionObject = self.sections[indexPath.section];
        cellModel = sectionObject.cellModels[indexPath.row];
    }
    else {
        cellModel = self.models[indexPath.row];
    }

    Class cellClass = [self cellClassWithBindModel:cellModel];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self identifierOfCellClass:cellClass] forIndexPath:indexPath];
    [cell performSelector:@selector(AIConfigureWithModel:) withObject:cellModel];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.sections.count > 0) {
        AITableViewSection *sectionObject = self.sections[section];
        if (!sectionObject.headerModel) {
            return nil;
        }
        Class sectionClass = [self sectionClassWithBindModel:sectionObject.headerModel];
        
        UITableViewHeaderFooterView *headerView = [self dequeueReusableHeaderFooterViewWithIdentifier:[self identifierOfSectionClass:sectionClass]];
        [headerView performSelector:@selector(AIConfigureWithModel:) withObject:sectionObject.headerModel];
        return headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.sections.count > 0) {
        AITableViewSection *sectionObject = self.sections[section];
        if (!sectionObject.footerModel) {
            return nil;
        }
        Class sectionClass = [self sectionClassWithBindModel:sectionObject.footerModel];
        
        UITableViewHeaderFooterView *footerView = [self dequeueReusableHeaderFooterViewWithIdentifier:[self identifierOfSectionClass:sectionClass]];
        [footerView performSelector:@selector(AIConfigureWithModel:) withObject:sectionObject.footerModel];
        return footerView;
    }
    return nil;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel;
    if (self.sections.count > 0) {
        AITableViewSection *sectionObject = self.sections[indexPath.section];
        cellModel = sectionObject.cellModels[indexPath.row];
    }
    else {
        cellModel = self.models[indexPath.row];
    }

    Class cellClass = [self cellClassWithBindModel:cellModel];
    Class <AITableViewCellProtocal> cellClassProtocal = cellClass;

    return [cellClassProtocal AIHeightWithModel:cellModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.sections.count > 0) {
        AITableViewSection *sectionObject = self.sections[section];
        if (!sectionObject.headerModel) {
            return 0;
        }
        Class sectionClass = [self sectionClassWithBindModel:sectionObject.headerModel];
        Class <AITableViewSectionProtocal> sectionClassProtocal = sectionClass;
        
        return [sectionClassProtocal AIHeightWithModel:sectionObject.headerModel];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.sections.count > 0) {
        AITableViewSection *sectionObject = self.sections[section];
        if (!sectionObject.footerModel) {
            return 0;
        }
        Class sectionClass = [self sectionClassWithBindModel:sectionObject.footerModel];
        Class <AITableViewSectionProtocal> sectionClassProtocal = sectionClass;
        
        return [sectionClassProtocal AIHeightWithModel:sectionObject.footerModel];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel;
    if (self.sections.count > 0) {
        AITableViewSection *sectionObject = self.sections[indexPath.section];
        cellModel = sectionObject.cellModels[indexPath.row];
    }
    else {
        cellModel = self.models[indexPath.row];
    }
    
    // AITableView delegate 方式传递cell select事件
    
    id <AITableViewDelegate> strongDelegate = self.AIDelegate;
    if ([strongDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:withCellModel:)]) {
        [strongDelegate tableView:self didSelectRowAtIndexPath:indexPath withCellModel:cellModel];
    }
    
    // AITableView Block 方式传递cell select事件

    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(self, indexPath, cellModel);
    }
    
    // AITableViewModelProtocal 方式，向model传递 cell select 事件
    
    id <AITableViewModelProtocal> modelProtocal = cellModel;
    if ([modelProtocal respondsToSelector:@selector(AIDidSelectBlock)]) {
        AITableViewCellDidSelectBlock didSelectBlock = [modelProtocal AIDidSelectBlock];
        if (didSelectBlock) {
            didSelectBlock(indexPath);
        }
    }
}

@end

