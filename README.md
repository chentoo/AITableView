# AITableView

## 做什么用？

这是一个简化UITableView使用方式的一个尝试，不需要再实现UI TableView繁多的delegate和datasource方法，不需要重复实现繁多的cell的if else / switch 逻辑，只需要简单的配置过程，你就可以轻松的驾驭和布局TableView。

这是一个基于MVVM思想的尝试，并且最终拼装成为TableView的元素不再是一个个的cell，而是一个个轻量的ViewModel(我们暂且叫他CellModel)。每个CellModel对应值唯一的一种cell，CellModel只拥有属性， 且每一个属性都将直接决定Cell的展示效果。

长远来看，你可以轻松的组建一个你自己的CellModel库。在同一个TableView的不同的逻辑情况下，或者不同的TableView中,你可以根据自己的需求选出合适的CellModel，配置属性，拼装组建即可。

## 怎么使用？

首先使用AITabelView，你不需要更改你原本的Cell的基类和model的基类，只需根据需要实现特定的Protocal即可。

1、 你的每个Cell需要实现AITableViewCellProtocal,并实现对应方法。你应该把你所有的Cell UI元素的配置放在

```objective-c
- (void)AIConfigureWithModel:(DemoNameCellModel *)model
```
并在类方法

```objective-c
+ (CGFloat)AIHeightWithModel:(id)model
```
返回你的cell的高度。

比如：

```objective-c
#import "DemoTableViewNameCell.h"
#import "AITableViewProtocal.h"
#import "DemoNameCellModel.h"

@interface DemoTableViewNameCell ()  <AITableViewCellProtocal>

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation DemoTableViewNameCell

#pragma mark - AITableViewCellProtocal

- (void)AIConfigureWithModel:(DemoNameCellModel *)model
{
    self.nameLabel.text = model.name;
}

+ (CGFloat)AIHeightWithModel:(id)model
{
    return 30.0f;
}

@end

```

2、接下来去写一个能够唯一对应这个cell的cellModel，它可以继承自任何基类，也不需实现任何Protocal。但是需要保证的是，cell可以根据它所唯一对应的cellModel完成所有配置。

需要特别注意的是，每个CellModel类，对应且唯一对应一个Cell类，也即不同的Cell Class 不能对应同一个CellModel类。

完成cell对应的cellModel后，使用下面的方法，去绑定他们。

```objective-c
//AITableView.h

- (void)bindModelClass:(Class)modelClass withCellClass:(Class)cellClass;
- (void)bindModelClass:(Class)modelClass withCellNibClass:(Class)cellNibClass;
```
特别的，如果一个cell的逻辑不依赖外部的变化而变化，那么他可能不需要一个cellModel去控制。那么有下面的特别方法去绑定它们。

当然其实我并不建议这么做，因为从长远组建CellModel库的角度来讲，拥有一个唯一的cellModel可能更容易管理和使用。

```objective-c
//AITableView.h

- (void)bindStaticCellWithCellClass:(Class)cellClass;
- (void)bindStaticCellWithCellNibClass:(Class)cellNibClass;
```

3、最后使用下面的方法就可以更新你的TableView了。

```objective-c
[self.tableview updateTabelViewWithModels:@[model, sModel, sModel, model]];
```


4、如果你需要包含不同的section，或者需要headview footerview，那么你可以使用：
AITableViewSection 去构建。

```objective-c
@interface AITableViewSection : NSObject

@property (strong, nonatomic) id headerModel;
@property (strong, nonatomic) id footerModel;
@property (strong, nonatomic) NSArray *cellModels;

+ (instancetype)sectionWithHeaderModel:(id)sectionHeaderModel
                           footerModel:(id)sectionFooterModel
                            cellModels:(NSArray *)cellModels;

@end
```
并且使用下面的方法去更新TableView

```objective-c
[self.tableview updateTableViewWithSections:@[aiSection, aiSection, aiSection]];
```

5、更多的请参看完整示例代码。

## 如何接收cell 点击事件？

提供了三种方式：

1. AITableView的 delegate
2. AITableView的 Block
3. model 的 protocal block（可以方便的配置在model身上）

具体请看示例代码。

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
    
    [self.tableview updateTabelViewWithModels:@[model, sModel, sModel, model]];
```

#### May be your need to see Demo.


#License
MIT
