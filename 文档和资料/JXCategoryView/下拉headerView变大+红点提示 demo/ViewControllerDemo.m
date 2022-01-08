//
//  ViewController@5.m
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "ViewController@5.h"

#import "PagingViewTableHeaderView.h"

#import "DynamicVC.h"//动态
#import "ForecastVC.h"//预测
#import "VideoVC.h"//录像
#import "ReleaseVC.h"//发布
#import "CommentVC.h"//评论

static const CGFloat JXTableHeaderViewHeight = 200;
static const CGFloat JXheightForHeaderInSection = 50;

@interface ViewControllerDemo ()
<
JXPagerViewDelegate,
JXCategoryViewDelegate
>

@property(nonatomic,strong)PagingViewTableHeaderView *userHeaderView;
@property(nonatomic,strong)JXPagerView *pagingView;
@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;

@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *> *titlesMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;

@end

@implementation ViewControllerDemo

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryTitleView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.gk_navigationBar.hidden = YES;
//    self.gk_navTitle = @"2";//用GK
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
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
#pragma mark —— lazyLoad
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
        _userHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, JXTableHeaderViewHeight);
        _userHeaderView.isZoom = YES;
    }return _userHeaderView;
}

-(JXCategoryDotView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryDotView.new;
        _categoryTitleView.mj_w = SCREEN_WIDTH;
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

@end
