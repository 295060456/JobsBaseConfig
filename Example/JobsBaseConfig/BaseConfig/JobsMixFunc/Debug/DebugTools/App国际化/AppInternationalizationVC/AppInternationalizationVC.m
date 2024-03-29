//
//  AppInternationalizationVC.m
//  Casino
//
//  Created by Jobs on 2021/11/19.
//

#import "AppInternationalizationVC.h"

@interface AppInternationalizationVC ()
// UI
@property(nonatomic,strong)UITableView *tableView;
// Data
@property(nonatomic,strong)NSMutableArray <NSString *>*dataMutArr;

@end

@implementation AppInternationalizationVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    
    self.setupNavigationBarHidden = YES;
    
    {
        self.viewModel.backBtnTitleModel.text = Internationalization(@"返回");
        self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
        self.viewModel.textModel.text = Internationalization(@"App language switch");
        self.viewModel.textModel.font = UIFontWeightRegularSize(16);
        
        // 使用原则：底图有 + 底色有 = 优先使用底图数据
        // 以下2个属性的设置，涉及到的UI结论 请参阅父类（BaseViewController）的私有方法：-(void)setBackGround
        // self.viewModel.bgImage = JobsIMG(@"内部招聘导航栏背景图");/// self.gk_navBackgroundImage 和 self.bgImageView
        self.viewModel.bgCor = RGBA_COLOR(255, 238, 221, 1);/// self.gk_navBackgroundColor 和 self.view.backgroundColor
    //    self.viewModel.bgImage = JobsIMG(@"新首页的底图");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGKNav];
    [self setGKNavBackBtn];
    self.tableView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —— BaseViewProtocol
/// 下拉刷新 （子类要进行覆写）
-(void)pullToRefresh{
    // 刷新本界面
    if (self.dataMutArr.count) {
        [self.dataMutArr remove];
        _dataMutArr = nil;
    }
    self.isVisible = YES;
    if (self.dataMutArr.count) {
        [self endRefreshing:self.tableView];
    }else{
        [self endRefreshingWithNoMoreData:self.tableView];
    }
    /// 在reloadData后做的操作，因为reloadData刷新UI是在主线程上，那么就在主线程上等待
    @jobs_weakify(self)
    [self getMainQueue:^{
        @jobs_strongify(self)
        [self.tableView alphaAnimWithSortingType:(SortingType)SortingType_Positive
                                  animationBlock:nil
                                 completionBlock:nil];
    }];
}
/// 上拉加载更多 （子类要进行覆写）
-(void)loadMoreRefresh{
    [self pullToRefresh];
}
/// 接收通知并相应的方法
- (void)languageSwitchNotification:(NSNotification *)notification{
    NSLog(@"通知传递过来的 = %@",notification.object);
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JobsWidth(44);
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        return;
    }
    for (UITableViewCell *acell in tableView.visibleCells) {
        acell.accessoryType = acell == cell ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    [self setAppLanguageAtIndexPath:indexPath byNotificationName:nil];// 设置App语言环境并发送全局通知LanguageSwitchNotification
    [self changeTabBarItemTitle:indexPath];///【App语言国际化】更改UITabBarItem的标题
    
    /// 刷新本界面，且2秒后退出
    [self.tableView.mj_header beginRefreshing];
    @jobs_weakify(self)
    DispathdDelaySth(2.0, [weak_self backBtnClickEvent:nil]);
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell cellStyleValue1WithTableView:tableView];
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.textModel.text = self.dataMutArr[indexPath.row];
    [cell richElementsInCellWithModel:viewModel];
    
    {
        //    用户没有自己设置的语言，则跟随手机系统
        if (!CLLanguageManager.userLanguage.length) {
            cell.accessoryType = indexPath.row == 0 ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        } else {
            if (NSBundle.isChineseLanguage) {
                if (indexPath.row == 1) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            } else {
                if (indexPath.row == 2) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
    }return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return [BaseTableViewHeaderFooterView viewHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.alpha = self.isVisible;
    [tableView hideSeparatorLineAtLast:indexPath
                                  cell:cell];
}
/// 这里涉及到复用机制，return出去的是UITableViewHeaderFooterView的派生类
- (nullable UIView *)tableView:(UITableView *)tableView
        viewForHeaderInSection:(NSInteger)section{
    BaseTableViewHeaderFooterView *headerView = BaseTableViewHeaderFooterView.jobsInitWithReuseIdentifier;
    headerView.headerFooterViewStyle = JobsHeaderViewStyle;
    headerView.section = section;
    headerView.backgroundColor = JobsWhiteColor;
    headerView.contentView.backgroundColor = JobsWhiteColor;
    [headerView richElementsInViewWithModel:UIViewModel.new];
//        @jobs_weakify(self)
    [headerView actionObjectBlock:^(id data) {
//            @jobs_strongify(self)
    }];return headerView;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        [self dataLinkByTableView:_tableView];
        _tableView.backgroundColor = JobsWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = UIView.new;/// 这里接入的就是一个UIView的派生类
        _tableView.tableFooterView = UIView.new;/// 这里接入的就是一个UIView的派生类
        _tableView.separatorColor = HEXCOLOR(0xEEEEEE);
        {
            MJRefreshConfigModel *refreshConfigHeader = MJRefreshConfigModel.new;
            refreshConfigHeader.stateIdleTitle = Internationalization(@"Pull down to refresh");
            refreshConfigHeader.pullingTitle = Internationalization(@"Pull down to refresh");
            refreshConfigHeader.refreshingTitle = Internationalization(@"Release Refresh now");
            refreshConfigHeader.willRefreshTitle = Internationalization(@"Refreshing data");
            refreshConfigHeader.noMoreDataTitle = Internationalization(@"Pull down to refresh");

            MJRefreshConfigModel *refreshConfigFooter = MJRefreshConfigModel.new;
            refreshConfigFooter.stateIdleTitle = @"";
            refreshConfigFooter.pullingTitle = @"";
            refreshConfigFooter.refreshingTitle = @"";
            refreshConfigFooter.willRefreshTitle = @"";
            refreshConfigFooter.noMoreDataTitle = @"";

            self.refreshConfigHeader = refreshConfigHeader;
            self.refreshConfigFooter = refreshConfigFooter;

            _tableView.mj_header = self.mjRefreshNormalHeader;
            _tableView.mj_header.automaticallyChangeAlpha = YES;//根据拖拽比例自动切换透明度
        }
        
        {
            _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"暂无数据"
                                                                titleStr:@"暂无数据"
                                                               detailStr:@""];

            _tableView.ly_emptyView.titleLabTextColor = JobsLightGrayColor;
            _tableView.ly_emptyView.contentViewOffset = -JobsWidth(180);
            _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:JobsWidth(16) weight:UIFontWeightMedium];
        }
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
    }return _tableView;
}

-(NSMutableArray<NSString *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
        
        [_dataMutArr addObject:Internationalization(@"By System")];
        [_dataMutArr addObject:Internationalization(@"Chinese")];
        [_dataMutArr addObject:Internationalization(@"English")];
        
    }return _dataMutArr;
}

@end
