//
//  AITableView.m
//  AITableViewDemo
//
//  Created by Zhidi Xia on 15/7/7.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "AITableView.h"
#import "AITableViewCellProtocal.h"
#import <objc/runtime.h>

@interface AITableView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *bindDic;
@property (strong, nonatomic) NSArray *models;

@end

@implementation AITableView

+ (instancetype)tableView
{
    AITableView *tableView = [[AITableView alloc] init];
    
    tableView.dataSource = tableView;
    tableView.delegate = tableView;
    tableView.models = @[];
    tableView.bindDic = [NSMutableDictionary dictionary];
    
    return tableView;
}

#pragma mark - Reigster Cell

- (NSString *)identifierOfCellClass:(Class)cellClass
{
    NSMethodSignature *methodSignature = [cellClass instanceMethodSignatureForSelector:@selector(reuseIdentifier)];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:@selector(reuseIdentifier)];
    [invocation setTarget:cellClass];
    
    NSString * cellIdentifier = [NSString string];
    [invocation retainArguments];
    [invocation invoke];
    [invocation getReturnValue:&cellIdentifier];
    
    return cellIdentifier;
}

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
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(nibClass) bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:cellIdentifier];
}



- (void)bindModelClass:(Class)modelClass withCellClass:(Class)cellClass
{
    [self registerCellWithClass:cellClass];
//    [self.bindDic setObject:NSStringFromClass(modelClass) forKey:NSStringFromClass(cellClass)];
    [self.bindDic setObject:NSStringFromClass(cellClass) forKey:NSStringFromClass(modelClass)];
}

- (void)bindModelClass:(Class)modelClass withCellNibClass:(Class)cellNibClass
{
    [self registerCellWithNib:cellNibClass];
    [self.bindDic setObject:NSStringFromClass(cellNibClass) forKey:NSStringFromClass(modelClass)];
}

- (Class)cellClassWithBindModelClass:(Class)modelClass
{
    NSString *cellModelClassName = NSStringFromClass(modelClass);
    NSString *cellClassName = self.bindDic[cellModelClassName];
    Class cellClass = NSClassFromString(cellClassName);
    return cellClass;
}

- (void)updateTabelViewWithModels:(NSArray *)models
{
    self.models = models;
    [self reloadData];
}

#pragma mark - UITableView Datesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel = self.models[indexPath.row];
    Class cellClass = [self cellClassWithBindModelClass:[cellModel class]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self identifierOfCellClass:cellClass] forIndexPath:indexPath];
    [cell performSelector:@selector(configureWithModel:) withObject:cellModel];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel = self.models[indexPath.row];
    Class cellClass = [self cellClassWithBindModelClass:[cellModel class]];
    
    SEL aaa = NSSelectorFromString(@"reuseIdentifier2");
    
    NSMethodSignature *methodSignature = [cellClass instanceMethodSignatureForSelector:aaa];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:aaa];
    [invocation setTarget:cellClass];
    
    NSString * cellIdentifier = [NSString string];
    [invocation retainArguments];
    [invocation invoke];
    [invocation getReturnValue:&cellIdentifier];

    return 10;
}

@end
