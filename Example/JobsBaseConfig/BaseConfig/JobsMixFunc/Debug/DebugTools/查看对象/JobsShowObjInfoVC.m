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
    NSLog(@"%@",JobsLocalFunc);
    //    [NSNotificationCenter.defaultCenter removeObserver:self];
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
        self.viewModel.textModel.text = Internationalization(@"用户信息展示(开发测试专用)");
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
            NSString *text = propertyName;
            id subtext = requestParams.valueForKeyBlock(propertyName);
            /// 防崩溃处理：
            if([subtext isKindOfClass:NSString.class] &&
               [text isKindOfClass:NSString.class]){
                viewModel.textModel.text = propertyName;
                viewModel.subTextModel.text = requestParams.valueForKeyBlock(propertyName);
                viewModel.textModel.textCor = UIColor.blueColor;
                viewModel.textModel.textCor = UIColor.redColor;
                [self.dataMutArr addObject:viewModel];
            }
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
    return [JobsBaseTableViewCell cellHeightWithModel:self.dataMutArr[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIPasteboard.generalPasteboard.string = self.dataMutArr[indexPath.row].subTextModel.text;
    [WHToast jobsToastMsg:[NSString stringWithFormat:@"%@%@%@",Internationalization(@"复制"),self.dataMutArr[indexPath.row].textModel.text,Internationalization(@"成功")]];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobsBaseTableViewCell *cell = [JobsBaseTableViewCell cellStyleValue1WithTableView:tableView];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textColor = UIColor.brownColor;
    cell.textLabel.textColor = UIColor.blackColor;
    [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.alpha = self.isVisible;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        [self dataLinkByTableView:_tableView];
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
            
            _tableView.ly_emptyView.titleLabTextColor = JobsLightGrayColor;
            _tableView.ly_emptyView.contentViewOffset = -JobsWidth(180);
            _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:JobsWidth(16) weight:UIFontWeightMedium];
        }
        
        [self.view addSubview:_tableView];
        [self fullScreenConstraintTargetView:_tableView topViewOffset:0];
    }return _tableView;
}

-(NSMutableArray<UIViewModel *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
    }return _dataMutArr;
}

@end
