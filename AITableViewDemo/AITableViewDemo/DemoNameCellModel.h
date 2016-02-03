//
//  DemoNameCellModel.h
//  AITableViewDemo
//
//  Created by Zhidi Xia on 16/2/3.
//  Copyright © 2016年 chentoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AITableViewProtocal.h"

@interface DemoNameCellModel : NSObject <AITableViewModelProtocal>

@property (nonatomic, copy) NSString *name;

@end
