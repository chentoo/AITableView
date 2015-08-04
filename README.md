# AITableView

## Easy To Get Started

#### 1、Your Cell have to implement AITableViewCellProtocal
```objective-c
//HEHETableViewCell.h
#import <UIKit/UIKit.h>
#import "AITableViewCellProtocal.h"

@interface HEHETableViewCell : UITableViewCell <AITableViewCellProtocal>

@end

//HEHETableViewCell.m
#import "HEHETableViewCell.h"

@implementation HEHETableViewCell

+ (NSString *)AIReuseIdentifier
{
    return @"HEHETableViewCellReuseIdentifier";
}

- (void)AIConfigureWithModel:(id)model
{
    self.textLabel.text = @"Hey, girl~";
}

+ (CGFloat)AIHeightWithModel:(id)model
{
    return 40.0f;
}

@end
```
You have to put cell configure code in this methed:
```objective-c
- (void)AIConfigureWithModel:(id)model
```

Return your cell 's height in this class methed:
```objective-c
+ (CGFloat)AIHeightWithModel:(id)model
```

#### 2、Then ,each cell corresponds to a unique model, or the cell does not need a model(a static cell).
You have to bind model and cell ,or bind static cell:
```objective-c
//AITableView.h

- (void)bindModelClass:(Class)modelClass withCellClass:(Class)cellClass;
- (void)bindModelClass:(Class)modelClass withCellNibClass:(Class)cellNibClass;

- (void)bindStaticCellWithCellClass:(Class)cellClass;
- (void)bindStaticCellWithCellNibClass:(Class)cellNibClass;
```

#### 3、Enjoy your AITableView...
```objective-c
    self.tableview = [AITableView tableViewWithFrame:self.view.bounds];
    [self.view addSubview:self.tableview];
    
    [self.tableview bindModelClass:[HEHECellModel class] withCellClass:[HEHETableViewCell class]];
    [self.tableview bindStaticCellWithCellNibClass:[HAHATableViewCell class]];
    
    HEHECellModel *model = [[HEHECellModel alloc] init];
    AITableViewStaticCellModel *sModel = [self.tableview modelWithStaticCellClass:[HAHATableViewCell class]];
    
    [self.tableview updateTabelViewWithModels:@[model, model, model, model, sModel, sModel, model]];
```

#### May be your need to see Demo.


