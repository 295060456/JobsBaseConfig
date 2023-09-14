#  JXCategoryView框架的使用01

## 其他功能

```objective-c
/// 手动跳转到某个指定的页面
[self.categoryTitleView selectItemAtIndex:3];
```
## 一些共同的准备工作

```objective-c
#if __has_include(<JXCategoryView/JXCategoryView.h>)
#import <JXCategoryView/JXCategoryView.h>
#else
#import "JXCategoryView.h"
#endif

<JXCategoryTitleViewDataSource
,JXCategoryListContainerViewDelegate
,JXCategoryViewDelegate>
```
## 图文结合

*方式一*

```objective-c
============================== 方式一 ============================== 
-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryTitleView.new;
        _categoryView.backgroundColor = UIColor.clearColor;
        _categoryView.titleSelectedColor = UIColor.whiteColor;
        _categoryView.titleColor = UIColor.whiteColor;
        _categoryView.titleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:28 weight:UIFontWeightRegular];
        _categoryView.delegate = self;
        _categoryView.titles = self.titleMutArr;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.indicators = @[self.lineView];//
        _categoryView.defaultSelectedIndex = 1;// 默认从第二个开始显示
        _categoryView.cellSpacing = JobsWidth(-20);
        // 关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryView.contentScrollView = self.listContainerView.scrollView;//
        [self.view addSubview:_categoryView];
        [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoBoardView.mas_bottom).offset(0);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(listContainerViewDefaultOffset);
        }];
        [self.view layoutIfNeeded];
    }return _categoryView;
}
```

*方式二*

```objective-c
============================== 方式二 ============================== 
-(JXCategoryImageView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryImageView.new;
        _categoryView.backgroundColor = UIColor.clearColor;
        _categoryView.delegate = self;

        _categoryView.imageNames = @[@"彩票_已选择",@"电子_已选择",@"棋牌_已选择",@"全部游戏_已选择",@"体育_已选择",@"真人直播_已选择"];
        _categoryView.selectedImageNames = @[@"彩票_已选择",@"电子_已选择",@"棋牌_已选择",@"全部游戏_已选择",@"体育_已选择",@"真人直播_已选择"];
        
        //_categoryView.imageInfoArray = @[@"彩票_已选择",@"电子_已选择",@"棋牌_已选择",@"全部游戏_已选择",@"体育_已选择",@"真人直播_已选择"];
        //@[KIMG(@"彩票_已选择"),KIMG(@"电子_已选择"),KIMG(@"棋牌_已选择"),KIMG(@"全部游戏_已选择"),KIMG(@"体育_已选择"),KIMG(@"真人直播_已选择")];
        //_categoryView.selectedImageInfoArray = @[@"彩票_已选择",@"电子_已选择",@"棋牌_已选择",@"全部游戏_已选择",@"体育_已选择",@"真人直播_已选择"];
        
        _categoryView.imageSize = CGSizeMake(JobsWidth(30), JobsWidth(30));
        _categoryView.imageCornerRadius = JobsWidth(8);
        _categoryView.imageZoomEnabled = YES;
        _categoryView.imageZoomScale = 2;

        _categoryView.indicators = @[self.lineView];//
        _categoryView.defaultSelectedIndex = 1;// 默认从第二个开始显示
        _categoryView.cellSpacing = JobsWidth(-20);
        // 关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryView.contentScrollView = self.listContainerView.scrollView;//
        [self.view addSubview:_categoryView];
        [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoBoardView.mas_bottom).offset(0);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(listContainerViewDefaultOffset);
        }];
        [self.view layoutIfNeeded];
    }return _categoryView;
}
```

*方式三*

```objective-c
============================== 方式三 ==============================
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;

-(JXCategoryDotView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryDotView.new;
        _categoryTitleView.delegate = self;
        _categoryTitleView.dotStates = self.dotStatesMutArr;
        _categoryTitleView.titles = self.titleMutArr;
        _categoryTitleView.indicators = @[self.lineView];
        _categoryTitleView.backgroundColor = HEXCOLOR(0xFCFBFB);
        _categoryTitleView.titleSelectedColor = HEXCOLOR(0xAE8330);
        _categoryTitleView.titleColor = HEXCOLOR(0xC4C4C4);
        _categoryTitleView.titleFont = notoSansRegular(12);
        _categoryTitleView.titleSelectedFont = notoSansRegular(12);
        _categoryTitleView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
//        _categoryTitleView.titleLabelZoomEnabled = YES;//默认为NO。为YES时titleSelectedFont失效，以titleFont为准。这句话貌似有点问题，等作者回复
        _categoryTitleView.listContainer = self.listContainerView;
        _categoryTitleView.dotSize = CGSizeMake(JobsWidth(5), JobsWidth(5));
        // 关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryTitleView.contentScrollView = self.listContainerView.scrollView;
        [_categoryTitleView reloadDataWithoutListContainer];
        [self.view addSubview:_categoryTitleView];
        [_categoryTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLineLab.mas_bottom);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(listContainerViewDefaultOffset);
        }];
    }return _categoryTitleView;
}

-(NSMutableArray<NSNumber *> *)dotStatesMutArr{
    if (!_dotStatesMutArr) {
        _dotStatesMutArr = NSMutableArray.array;
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
    }return _dotStatesMutArr;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    //点击以后红点消除
    if ([self.dotStatesMutArr[index] boolValue]) {
        self.dotStatesMutArr[index] = @(NO);
        self.categoryTitleView.dotStates = self.dotStatesMutArr;
        [categoryView reloadCellAtIndex:index];
    }
}
```

*方式四*

```objective-c
============================== 方式四 ==============================
-(JXCategoryNumberView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryNumberView.new;
        _categoryTitleView.delegate = self;
        _categoryTitleView.titles = self.titleMutArr;
        _categoryTitleView.indicators = @[self.lineView];
        _categoryTitleView.backgroundColor = HEXCOLOR(0xFCFBFB);
        _categoryTitleView.titleSelectedColor = HEXCOLOR(0xAE8330);
        _categoryTitleView.titleColor = HEXCOLOR(0xC4C4C4);
        _categoryTitleView.titleFont = notoSansRegular(12);
        _categoryTitleView.titleSelectedFont = notoSansRegular(12);
        _categoryTitleView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
//        _categoryTitleView.titleLabelZoomEnabled = YES;//默认为NO。为YES时titleSelectedFont失效，以titleFont为准。这句话貌似有点问题，等作者回复
        _categoryTitleView.listContainer = self.listContainerView;
        _categoryTitleView.counts = self.numberMutArr;
        _categoryTitleView.numberLabelOffset = CGPointMake(JobsWidth(5), JobsWidth(2));
        /// 内部默认不会格式化数字，直接转成字符串显示。比如业务需要数字超过999显示999+，可以通过该block实现。
        _categoryTitleView.numberStringFormatterBlock = ^NSString *(NSInteger number) {
            if (number > 999) {
                return @"999+";
            }
            return [NSString stringWithFormat:@"%ld", (long)number];
        };
        /// 关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryTitleView.contentScrollView = self.listContainerView.scrollView;
        [_categoryTitleView reloadDataWithoutListContainer];
        [self.view addSubview:_categoryTitleView];
        [_categoryTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLineLab.mas_bottom);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(listContainerViewDefaultOffset);
        }];
    }return _categoryTitleView;
}
```

*公共部分*

```objective-c
==================================== 公共部分 ====================================
#ifndef listContainerViewDefaultOffset
#define listContainerViewDefaultOffset JobsWidth(50)
#endif
// UI
/// N 选 1
@property(nonatomic,strong)JXCategoryTitleView *categoryView;/// 文字
@property(nonatomic,strong)JXCategoryImageView *categoryView;/// 纯图
@property(nonatomic,strong)JXCategoryDotView *categoryView;/// 右上角带红点
@property(nonatomic,strong)JXCategoryNumberView *categoryView;/// 右上角带文字
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;/// 跟随的指示器
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;/// 此属性决定依附于此的viewController
// Data
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*imageNames;
@property(nonatomic,strong)NSMutableArray <NSString *>*selectedImageNames;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCMutArr;

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = kWhiteColor;
        _lineView.indicatorHeight = JobsWidth(4);
        _lineView.indicatorWidthIncrement = JobsWidth(10);
        _lineView.verticalMargin = 0;
    }return _lineView;
}
/// 此属性决定依附于此的viewController
-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [JXCategoryListContainerView.alloc initWithType:JXCategoryListContainerType_CollectionView
                                                                    delegate:self];
        _listContainerView.defaultSelectedIndex = 1;// 默认从第二个开始显示
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
            make.top.equalTo(self.infoBoardView.mas_bottom).offset(listContainerViewDefaultOffset);
            make.left.right.bottom.equalTo(self.view);
            
        }];
        [self.view layoutIfNeeded];
        
        /// ❤️在需要的地方写❤️
        NSNumber *currentIndex = [self.listContainerView valueForKey:@"currentIndex"];
        NSLog(@"滑动或者点击以后，改变控制器，得到的目前最新的index = %d",currentIndex.intValue);
        
    }return _listContainerView;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:Internationalization(@"全部游戏")];
        [_titleMutArr addObject:Internationalization(@"真人")];
        [_titleMutArr addObject:Internationalization(@"体育")];
        [_titleMutArr addObject:Internationalization(@"电子")];
        [_titleMutArr addObject:Internationalization(@"棋牌")];
        [_titleMutArr addObject:Internationalization(@"彩票")];
    }return _titleMutArr;
}

-(NSMutableArray<UIViewController *> *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [self.childVCMutArr addObject:BaiShaETProjAllGameVC.new];// 全部游戏
        [self.childVCMutArr addObject:BaiShaETProjManVideoVC.new];// 真人
        [self.childVCMutArr addObject:BaiShaETProjSportVC.new];// 体育
        [self.childVCMutArr addObject:BaiShaETProjGameOnllineVC.new];// 电子
        [self.childVCMutArr addObject:BaiShaETProjChessPokerVC.new];// 棋牌
        [self.childVCMutArr addObject:BaiShaETProjLotteryVC.new];// 彩票
    }return _childVCMutArr;
}

#pragma mark JXCategoryTitleViewDataSource
//// 如果将JXCategoryTitleView嵌套进UITableView的cell，每次重用的时候，JXCategoryTitleView进行reloadData时，会重新计算所有的title宽度。所以该应用场景，需要UITableView的cellModel缓存titles的文字宽度，再通过该代理方法返回给JXCategoryTitleView。
//// 如果实现了该方法就以该方法返回的宽度为准，不触发内部默认的文字宽度计算。
//- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView
//               widthForTitle:(NSString *)title{
//
//    return 10;
//}
#pragma mark JXCategoryListContainerViewDelegate
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titleMutArr.count;
}
/**
 根据index初始化一个对应列表实例，需要是遵从`JXCategoryListContentViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                          initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}
#pragma mark JXCategoryViewDelegate
///【点击的结果】点击选中的情况才会调用该方法。传递didClickSelectedItemAt事件给listContainerView
- (void)categoryView:(JXCategoryBaseView *)categoryView
didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}
///【点击选中或者滚动选中的结果】点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {
    
}
///【滚动选中的结果】滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView 
didScrollSelectedItemAtIndex:(NSInteger)index{
    
}
/// 传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
scrollingFromLeftIndex:(NSInteger)leftIndex
        toRightIndex:(NSInteger)rightIndex
               ratio:(CGFloat)ratio {
    NSLog(@"");
//    [self.listContainerView scrollingFromLeftIndex:leftIndex
//                                      toRightIndex:rightIndex
//                                             ratio:ratio
//                                     selectedIndex:categoryView.selectedIndex];
}
```

