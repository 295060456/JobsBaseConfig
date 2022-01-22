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
@property(nonatomic,strong)UITableViewHeaderFooterView *userHeaderView;
// Data
@property(nonatomic,strong)NSMutableArray <NSString *>*dataMutArr;

@end

@implementation AppInternationalizationVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    self.setupNavigationBarHidden = YES;
    self.viewModel.textModel.text = Internationalization(@"App language switch");
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
    self.visible = YES;
    if (self.dataMutArr.count) {
        [self endRefreshing:self.tableView];
    }else{
        [self endRefreshingWithNoMoreData:self.tableView];
    }
    /// 在reloadData后做的操作，因为reloadData刷新UI是在主线程上，那么就在主线程上等待
    @jobs_weakify(self)
    [self getMainQueue:^{
        @jobs_strongify(self)
        [UIScrollViewAnimationKit showWithAnimationType:XSScrollViewAnimationTypeAlpha
                                             scrollView:self.tableView];
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
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    /// 适配iOS 13夜间模式/深色外观(Dark Mode)
    cell.backgroundColor = [UIColor xy_createWithLightColor:UIColor.whiteColor darkColor:UIColor.whiteColor];
    cell.detailTextLabel.textColor = UIColor.brownColor;
    cell.textLabel.textColor = UIColor.blackColor;
    
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.textModel.text = self.dataMutArr[indexPath.row];
    [cell richElementsInCellWithModel:viewModel];
    
    {
        //    用户没有自己设置的语言，则跟随手机系统
        if (![CLLanguageManager userLanguage].length) {
            cell.accessoryType = indexPath.row == 0 ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        } else {
            if ([NSBundle isChineseLanguage]) {
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
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return [UITableViewHeaderFooterView viewHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.alpha = self.visible;
    [tableView hideSeparatorLineAtLast:indexPath
                                  cell:cell];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    return self.userHeaderView;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = AppMainCor_02;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.userHeaderView;
        _tableView.tableFooterView = UIView.new;
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

            _tableView.ly_emptyView.titleLabTextColor = KLightGrayColor;
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

-(UITableViewHeaderFooterView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = UITableViewHeaderFooterView.new;
        _userHeaderView.backgroundColor = UIColor.whiteColor;
        _userHeaderView.contentView.backgroundColor = UIColor.whiteColor;
        _userHeaderView.frame = [UITableViewHeaderFooterView viewFrameWithModel:nil];
        [_userHeaderView richElementsInViewWithModel:UIViewModel.new];
//        @jobs_weakify(self)
        [_userHeaderView actionViewBlock:^(id data) {
//            @jobs_strongify(self)
        }];
    }return _userHeaderView;
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
