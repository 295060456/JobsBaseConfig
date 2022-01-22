//
//  JobsShowObjInfoVC.m
//  Casino
//
//  Created by Jobs on 2021/12/3.
//

#import "JobsShowObjInfoVC.h"

@interface JobsShowObjInfoVC ()
/// UI
@property(nonatomic,strong)UITableView *tableView;
/// Data
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*dataMutArr;

@end

@implementation JobsShowObjInfoVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    self.setupNavigationBarHidden = YES;
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
        if ([NSString isNullString:self.viewModel.textModel.text]) {
            self.viewModel.textModel.text = Internationalization(@"用户信息展示(开发测试专用)");
        }
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

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
/// 装载数据
-(void)loadData{
    if ([self.viewModel.requestParams isKindOfClass:NSObject.class]) {
        NSObject *requestParams = (NSObject *)self.viewModel.requestParams;
        NSMutableArray <NSString *>*propertyList = requestParams.printPropertyList;
        for (NSString *propertyName in propertyList) {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.textModel.text = propertyName;
            viewModel.textModel.textCor = UIColor.blueColor;
            viewModel.subTextModel.text = [requestParams valueForKey:propertyName];
            viewModel.textModel.textCor = UIColor.redColor;
            [self.dataMutArr addObject:viewModel];
        }
    }
}
#pragma mark —— BaseViewProtocol
///下拉刷新 （子类要进行覆写）
-(void)pullToRefresh{
    [NSObject feedbackGenerator];//震动反馈
    if (self.dataMutArr.count) {
        [self.dataMutArr removeAllObjects];
    }
    [self loadData];
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
///上拉加载更多 （子类要进行覆写）
-(void)loadMoreRefresh{
    [self pullToRefresh];
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [BaseTableViewCell cellHeightWithModel:self.dataMutArr[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIPasteboard.generalPasteboard.string = self.dataMutArr[indexPath.row].subTextModel.text;
    [WHToast toastMsg:[NSString stringWithFormat:@"复制%@成功",self.dataMutArr[indexPath.row].textModel.text]];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textColor = UIColor.brownColor;
    cell.textLabel.textColor = UIColor.blackColor;
    [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.alpha = self.visible;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
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
            _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"加载失败"
                                                                titleStr:Internationalization(@"No Data")
                                                               detailStr:@""];
            
            _tableView.ly_emptyView.titleLabTextColor = KLightGrayColor;
            _tableView.ly_emptyView.contentViewOffset = -JobsWidth(180);
            _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:JobsWidth(16) weight:UIFontWeightMedium];
        }
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.setupNavigationBarHidden && self.gk_statusBarHidden) {// 系统、GK均隐藏
                make.edges.equalTo(self.view);
            }else{
                if (!self.setupNavigationBarHidden && self.gk_statusBarHidden) {// 用系统的导航栏
                    make.top.equalTo(self.view).offset(JobsNavigationBarAndStatusBarHeight(nil));
                }
                
                if (self.setupNavigationBarHidden && !self.gk_statusBarHidden) {// 用GK的导航栏
                    make.top.equalTo(self.gk_navigationBar.mas_bottom);
                }
                
                make.left.right.bottom.equalTo(self.view);
            }
        }];
    }return _tableView;
}

-(NSMutableArray<UIViewModel *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
    }return _dataMutArr;
}

@end
