# JXCategoryView框架的使用02（结合使用 JXPagerView）

*一些共同的准备工作*

```objective-c
<JXCategoryTitleViewDataSource
,JXCategoryViewDelegate
,JXPagerViewDelegate>
```

*Demo =  JXPagerView + JXCategoryView*

```objective-c
// @interface BaiShaETProjCollectionHeaderView : UICollectionHeaderFooterView

/// UI
@property(nonatomic,strong)UIButton *ruleBtn;
@property(nonatomic,strong)JXCategoryTitleView *categoryView;/// 文字
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;/// 跟随的指示器
@property(nonatomic,strong)JXPagerView *pagerView;
@property(nonatomic,strong)BaiShaETProjCollectionHeaderView *collectionHeaderView;
/// Data
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCMutArr;

#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
  return self.collectionHeaderView;
  }
  /**
  页面朝上走 crollView.contentOffset.y 为正值
  页面朝下走 crollView.contentOffset.y 为负值
  初始态是0
   */
- (void)pagerView:(JXPagerView *)pagerView
  mainTableViewDidScroll:(UIScrollView *)scrollView{
    [self.collectionHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
  }
  /// 
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
  return JobsStatusBarHeight()
  //    + self.gk_navigationBar.height
  + JobsNavigationBarAndStatusBarHeight(nil)
  + [BaiShaETProjCollectionHeaderView viewSizeWithModel:nil].height;
    }
    /// JXCategoryTitleView *categoryView 的高度
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
  return listContainerViewDefaultOffset;
  }

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
  return self.categoryView;
  }

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
  return self.titleMutArr.count;
  }

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView
      initListAtIndex:(NSInteger)index {
  return self.childVCMutArr[index];
  }
  #pragma mark —— lazyLoad
  -(JXPagerView *)pagerView{
  if (!_pagerView) {
      _pagerView = [JXPagerView.alloc initWithDelegate:self];
      [self.view addSubview:_pagerView];
      _pagerView.frame = CGRectMake(0,
                                    JobsNavigationBarAndStatusBarHeight(nil) + self.getTopLineLabSize.height,
                                    JobsMainScreen_WIDTH(),
                                    JobsMainScreen_HEIGHT());
      _pagerView.pinSectionHeaderVerticalOffset = JobsWidth(0);/// 额外的偏移量
  }return _pagerView;
  }

-(BaiShaETProjCollectionHeaderView *)collectionHeaderView{
    if (!_collectionHeaderView) {
        _collectionHeaderView = BaiShaETProjCollectionHeaderView.new;
        _collectionHeaderView.frame = CGRectMake(0,
                                                 JobsNavigationBarAndStatusBarHeight(nil),
                                                 [BaiShaETProjCollectionHeaderView viewSizeWithModel:nil].width,
                                                 [BaiShaETProjCollectionHeaderView viewSizeWithModel:nil].height);
        _collectionHeaderView.isZoom = YES;
        [_collectionHeaderView richElementsInViewWithModel:nil];
    }return _collectionHeaderView;
}

-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryTitleView.new;
        _categoryView.backgroundColor = UIColor.clearColor;
        _categoryView.titleSelectedColor = HEXCOLOR(0xAE8330);
        _categoryView.titleColor = HEXCOLOR(0x757575);
        _categoryView.titleFont = notoSansBold(12);
        _categoryView.titleSelectedFont = notoSansBold(12);
        _categoryView.delegate = self;
        _categoryView.titles = self.titleMutArr;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.indicators = @[self.lineView];//
        _categoryView.defaultSelectedIndex = 1;// 默认从第二个开始显示
        _categoryView.cellSpacing = JobsWidth(-20);
        _categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
        [self.view addSubview:_categoryView];
        [self.view layoutIfNeeded];
    }return _categoryView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = HEXCOLOR(0xAE8330);
        _lineView.indicatorHeight = JobsWidth(4);
        _lineView.indicatorWidthIncrement = JobsWidth(10);
        _lineView.verticalMargin = 0;
    }return _lineView;
}

-(UIButton *)ruleBtn{
    if (!_ruleBtn) {
        _ruleBtn = UIButton.new;
        _ruleBtn.normalTitleColor = HEXCOLOR(0x3D4A58);
        _ruleBtn.normalTitle = Internationalization(@"VIP規則");
        _ruleBtn.titleFont = notoSansRegular(12);
        BtnClickEvent(_ruleBtn, {
            [self comingToPushVC:BaiShaETProjRuleDetailVC.new requestParams:UIViewModel.new];
        });
    }return _ruleBtn;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        for (int i = 0; i <= 5; i++) {
            [_titleMutArr addObject:Internationalization([@"Lv" stringByAppendingString:[NSString stringWithFormat:@"%d",i]])];
        }
    }return _titleMutArr;
}

-(NSMutableArray<UIViewController *> *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        for (NSString *str in self.titleMutArr) {
            BaiShaETProjVIPSubVC *vipSubVC = BaiShaETProjVIPSubVC.new;
            vipSubVC.jobsTag = [self.titleMutArr indexOfObject:str];
            [self.childVCMutArr addObject:vipSubVC];
        }
    }return _childVCMutArr;
}
```

*用JXPagerView管理的区别：*

```objective-c
 1、注册协议JXPagerViewDelegate、舍弃协议JXCategoryListContainerViewDelegate
    1.1、舍弃 : - (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView;
    1.2、舍弃： - (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index;
    1.3、舍弃： - (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index ;
    1.4、舍弃： - (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index ;
    1.5、舍弃： - (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;
    1.6、舍弃： - (void)categoryView:(JXCategoryBaseView *)categoryView
            scrollingFromLeftIndex:(NSInteger)leftIndex
                   toRightIndex:(NSInteger)rightIndex
                         ratio:(CGFloat)ratio ;
 2、舍弃属性类 JXCategoryListContainerView
    2.1、舍弃 @property(nonatomic,strong)JXCategoryListContainerView *listContainerView;/// 此属性决定依附于此的viewController@property(nonatomic,strong)
    2.1 、舍弃
 -(JXCategoryListContainerView *)listContainerView{
     if (!_listContainerView) {
         _listContainerView = [JXCategoryListContainerView.alloc initWithType:JXCategoryListContainerType_CollectionView
                                                                     delegate:self];
         _listContainerView.defaultSelectedIndex = 1;// 默认从第二个开始显示
         [self.view addSubview:_listContainerView];
         [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
 //            make.edges.equalTo(self.view);
             make.top.equalTo(self.topLineLab.mas_bottom).offset(listContainerViewDefaultOffset);
             make.left.right.bottom.equalTo(self.view);

         }];
         [self.view layoutIfNeeded];
 //        /// ❤️在需要的地方写❤️
 //        NSNumber *currentIndex = [self.listContainerView valueForKey:@"currentIndex"];
 //        NSLog(@"滑动或者点击以后，改变控制器，得到的目前最新的index = %d",currentIndex.intValue);

     }return _listContainerView;
 }

 3、JXCategoryTitleView 舍弃部分属性：
    3.1、舍弃：_categoryView.contentScrollView = self.listContainerView.scrollView;/// 关联cotentScrollView，关联之后才可以互相联动！！！
    3.2、在 JXPagerView 模式下 ,不用设置JXCategoryTitleView的height、size、frame。而是在JXPagingViewDelegate代理方法里面设置

 4、_categoryView新增属性：_categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
 5、全局新增属性：@property(nonatomic,strong)JXPagerView *pagerView;
 6、新增JXPagingViewDelegate代理协议的实现
     6.1、- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView;
     6.2、- (void)pagerView:(JXPagerView *)pagerView
        mainTableViewDidScroll:(UIScrollView *)scrollView;
     6.3、- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView ;
     6.4、- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView;/// JXCategoryTitleView *categoryView 的高度
     6.5、- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView;
     6.6、- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView;
     6.7、- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView
                                  initListAtIndex:(NSInteger)index;
 7、各个子VC要遵循代理协议JXPagerViewListViewDelegate，并实现相关方法
    7.1、 - (UIView *)listView;
    7.2、 - (UIScrollView *)listScrollView;
    7.3、 - (void)listViewDidScrollCallback:(void (^)(UIScrollView *scrollView))callback;
    7.4、或者直接导入类：#import "UIViewController+JXPagerViewListViewDelegate.h"
```

