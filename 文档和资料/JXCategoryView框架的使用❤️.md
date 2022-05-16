#  JXCategoryView框架的使用

## 其他
```
/// 手动跳转到某个指定的页面
[self.categoryTitleView selectItemAtIndex:3];
```
## 准备工作
```
#if __has_include(<JXCategoryView/JXCategoryView.h>)
#import <JXCategoryView/JXCategoryView.h>
#else
#import "JXCategoryView.h"
#endif
```
## 图文结合
```
<
JXCategoryTitleViewDataSource
,JXCategoryListContainerViewDelegate
,JXCategoryViewDelegate
>

CGFloat categoryViewHeight = JobsWidth(54);

============================== 方式一 ============================== 
// UI
@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;/// 跟随的指示器
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;/// 此属性决定依附于此的viewController
// Data
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCMutArr;

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
            make.height.mas_equalTo(categoryViewHeight);
        }];
        [self.view layoutIfNeeded];
    }return _categoryView;
}
============================== 方式二 ============================== 
// UI
@property(nonatomic,strong)JXCategoryImageView *categoryView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;/// 跟随的指示器
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;/// 此属性决定依附于此的viewController
// Data
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*imageNames;
@property(nonatomic,strong)NSMutableArray <NSString *>*selectedImageNames;

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
            make.height.mas_equalTo(categoryViewHeight);
        }];
        [self.view layoutIfNeeded];
    }return _categoryView;
}
==================================== 公共部分 ====================================
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
            make.top.equalTo(self.infoBoardView.mas_bottom).offset(categoryViewHeight);
            make.left.right.bottom.equalTo(self.view);
            
        }];
        [self.view layoutIfNeeded];
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
//传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
didClickSelectedItemAtIndex:(NSInteger)index {
     [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView
didScrollSelectedItemAtIndex:(NSInteger)index{}
//传递scrolling事件给listContainerView，必须调用！！！
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
## 下拉headerView变大 + 红点提示 
```
<
JXPagerViewDelegate,
JXCategoryViewDelegate
>
/// UI
@property(nonatomic,strong)PagingViewTableHeaderView *userHeaderView;
@property(nonatomic,strong)JXPagerView *pagingView;
@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
/// Data
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *> *titlesMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;

-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        [_childVCsMutArr addObject:DynamicVC.new];
        [_childVCsMutArr addObject:ForecastVC.new];
        [_childVCsMutArr addObject:VideoVC.new];
        [_childVCsMutArr addObject:ReleaseVC.new];
        [_childVCsMutArr addObject:CommentVC.new];
    }return _childVCsMutArr;
}

-(NSMutableArray<NSString *> *)titlesMutArr{
    if (!_titlesMutArr) {
        _titlesMutArr = NSMutableArray.array;
        [_titlesMutArr addObject:@"动态"];
        [_titlesMutArr addObject:@"预测"];
        [_titlesMutArr addObject:@"录像"];
        [_titlesMutArr addObject:@"发布"];
        [_titlesMutArr addObject:@"评论"];
    }return _titlesMutArr;
}

-(PagingViewTableHeaderView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = PagingViewTableHeaderView.new;
        _userHeaderView.frame = CGRectMake(0, 0, JobsMainScreen_WIDTH(), JXTableHeaderViewHeight);
        _userHeaderView.isZoom = YES;
    }return _userHeaderView;
}

-(JXCategoryDotView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryDotView.new;
        _categoryTitleView.mj_w = JobsMainScreen_WIDTH();
        _categoryTitleView.mj_h = JXheightForHeaderInSection;
        _categoryTitleView.backgroundColor = kWhiteColor;
        _categoryTitleView.titles = self.titlesMutArr;
        _categoryTitleView.indicators = @[self.lineView];
        _categoryTitleView.delegate = self;
        _categoryTitleView.dotStates = self.dotStatesMutArr;
        _categoryTitleView.titleSelectedColor = RGB_COLOR(105,
                                                         144,
                                                         239);
        _categoryTitleView.titleColor = kBlackColor;
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:14
                                                         weight:UIFontWeightMedium];
        _categoryTitleView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;
        _categoryTitleView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.titleLabelZoomEnabled = YES;
        [self.view addSubview:_categoryTitleView];
    }return _categoryTitleView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = RGB_COLOR(105, 144, 239);
        _lineView.indicatorWidth = 30;
    }return _lineView;
}

-(JXPagerView *)pagingView{
    if (!_pagingView) {
        _pagingView = [[JXPagerView alloc] initWithDelegate:self];
        [self.view addSubview:_pagingView];
        _pagingView.frame = self.view.bounds;
    }return _pagingView;
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

#pragma mark - JXPagingViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryTitleView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titlesMutArr.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView
                             initListAtIndex:(NSInteger)index {
    return self.childVCsMutArr[index];
}

- (void)pagerView:(JXPagerView *)pagerView
mainTableViewDidScroll:(UIScrollView *)scrollView{
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}
#pragma mark - JXCategoryViewDelegate
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

关于PagingViewTableHeaderView
```
PagingViewTableHeaderView.h文件

定义:
-(void)scrollViewDidScroll:(CGFloat)contentOffsetY;

PagingViewTableHeaderView.m文件

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,assign)CGRect imageViewFrame;

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    if (self.isZoom) {
        CGRect frame = self.imageViewFrame;
        frame.size.height -= contentOffsetY;
        frame.origin.y = contentOffsetY;
        self.imageView.frame = frame;
    }
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = KIMG(@"lufei.jpg");
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        if (self.isZoom) {
            _imageView.frame = CGRectMake(0, 0, self.mj_w, self.mj_h);
            self.imageViewFrame = _imageView.frame;
        }else{
            [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }return _imageView;
}
```
