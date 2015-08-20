//
//  AITableViewSection.m
//  AITableViewDemo
//
//  Created by chentoo on 15/8/20.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import "AITableViewSection.h"

@implementation AITableViewSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellModels = [NSArray array];
    }
    return self;
}


+ (instancetype)sectionWithHeaderModel:(id)sectionHeaderModel
                           footerModel:(id)sectionFooterModel
                            cellModels:(NSArray *)cellModels
{
    AITableViewSection *sectionObject = [[AITableViewSection alloc] init];
    
    sectionObject.headerModel = sectionHeaderModel;
    sectionObject.footerModel = sectionFooterModel;
    sectionObject.cellModels = cellModels;
    
    return sectionObject;
}


@end
