//
//  AITableViewSection.h
//  AITableViewDemo
//
//  Created by chentoo on 15/8/20.
//  Copyright (c) 2015年 chentoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AITableViewSection : NSObject

@property (strong, nonatomic) id headerModel;
@property (strong, nonatomic) id footerModel;
@property (strong, nonatomic) NSArray *cellModels;

+ (instancetype)sectionWithHeaderModel:(id)sectionHeaderModel
                           footerModel:(id)sectionFooterModel
                            cellModels:(NSArray *)cellModels;

@end
