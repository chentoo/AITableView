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

@implementation AITableView


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

@end
