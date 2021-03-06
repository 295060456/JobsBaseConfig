//
//  Douyin_ZFPlayerVC@1.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/8.
//

#import "Douyin_ZFPlayerVC@1.h"

@interface Douyin_ZFPlayerVC_1 ()

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray <VideoModel_Core *>*__block dataMutArr;

@end

@implementation Douyin_ZFPlayerVC_1

- (void)dealloc {
    NSLog(@"%@",JobsLocalFunc);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.index = 0;
    }return self;
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    
    self.setupNavigationBarHidden = YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];

    self.view.backgroundColor = JobsYellowColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    
    self.tableView.alpha = 1;
//    [self monitorScrollView];
    [self requestDataa:NO];
//    [self requestData:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.index = 0;//此时cell的第一次生命周期走完，置零
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti1" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    self.currentPage = 1;
    @"data".readLocalFileWithName;/// 获取本地的数据
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
    self.currentPage += 1;
//    NSLog(@"%@",self.tableView.mj_footer);
//    [self.tableView.mj_footer endRefreshing];
//    [self.tableView reloadData];
//    //特别说明：pagingEnabled = YES 在此会影响Cell的偏移量，原作者希望我们在这里临时关闭一下，刷新完成以后再打开
//    self.tableView.pagingEnabled = NO;
//    [self performSelector:@selector(delayMethods) withObject:nil afterDelay:2];
    
    @"data".readLocalFileWithName;/// 获取本地的数据
}

/// 真实的网络请求
-(void)requestDataa:(BOOL)isLoadMore{
    DDNetworkingPrepare
    DataManager.sharedInstance.tag = ReuseIdentifier;
    /**
     公共配置
     插件机制
     证书设置
     */
    RequestTool *config = RequestTool.new;
    config.languageType = HTTPRequestHeaderLanguageCN;
    [RequestTool setupPublicParameters:config];
    @jobs_weakify(self)
    NSDictionary *parameters = @{@"pageSize":@(10),
                                 @"pageNum":@(self.currentPage)};

    [DDNetworkingAPI requestApi:NSObject.appInterfaceTesting.funcName
                     parameters:parameters
                   successBlock:^(DDResponseModel *data) {
        @jobs_strongify(self)
        NSLog(@"");
        if([data.data isKindOfClass:NSArray.class]){
            NSArray *tempDataArr = (NSArray *)data.data;
            
            {// 数据组装
                /**
                    上拉加载更多
                    请求到有实际意义上的数据 ——> 上拉加载更多
                    请求到没有有实际意义上的数据 ——>  没有更多数据了
                 */
                
                /**
                 下拉刷新
                    请求到有实际意义上的数据 ——> 清除以前的旧的数据 下拉可以刷新
                    请求到没有有实际意义上的数据 ——> 不清除以前的旧的数据 下拉可以刷新
                 */
                
                // 如果当前操作是下拉刷新 并且 请求到的数组里面有值——>清除已有的数据
                if (!isLoadMore && tempDataArr.count) {
                    [self.dataMutArr removeAllObjects];
                }
                
                if (isLoadMore) {
                    if (tempDataArr.count) {
                        [self.dataMutArr addObjectsFromArray:tempDataArr];
                        [self endRefreshing:self.tableView];//上拉加载更多
                    }else{
                        [self endRefreshingWithNoMoreData:self.tableView];//没有更多数据了
                    }
                }
            }
        }
    }failureBlock:^(id data) {
        @jobs_strongify(self)
        if (self.currentPage > 1) {
            self.currentPage -= 1;
        }
    }];
}

-(void)roll{
    if (self.index <= self.dataMutArr.count - 1 &&
        self.index >= 0) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionMiddle];
    }
}
/*
 * 如果用户下拉,返回1;如果上拉快到底部时返回2
 * 并且在映射完成后用了distinctUntilChanged属性,当我的映射值不产生变化时是不会传递映射值的
 * 这样当用户拉倒需要刷新的位置,只会发一个信号给订阅者,只会执行一次刷新数据的方法
 */
-(void)monitorScrollView{
    [[[RACObserve(self.tableView, contentOffset) map:^id(id value) {
        if (self.tableView.contentOffset.y < - 50) {
            //下拉刷新方法
//            NSLog(@"1");
            return @"1";
        }

        if (self.tableView.contentOffset.y - self.tableView.contentSize.height < 80 &&
            self.tableView.contentSize.height > 80) {
            //上拉加载方法
            self.tableView.mj_footer.hidden = NO;
//            [self.tableView.mj_footer endRefreshingWithNoMoreData]; MJRefreshStateNoMoreData
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            [self.tableView.mj_footer endRefreshing];
//            NSLog(@"2");
            return @"2";
        }else{
//            NSLog(@"0");
            return @"0";
        }
    }] distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        if ([x integerValue] == 1) {
//            NSLog(@"↓");
        }else if ([x integerValue] == 2){
//            NSLog(@"↑");
        }
    }];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PlayerCell cellHeightWithModel:nil];
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    [self dataSource:self.dataMutArr
         contentView:self.tableView];
    return self.dataMutArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerCell *cell = [PlayerCell cellStyleValue1WithTableView:tableView];
    cell.index = indexPath.row;
    
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.row = indexPath.row;
    viewModel.data = self.dataMutArr[indexPath.row];
    
    [cell richElementsInCellWithModel:viewModel];
    
    self.index = indexPath.row;
    @jobs_weakify(self)
    [cell actionBlockPlayerCell:^(NSNumber *direction,
                                  NSNumber *index) {
        @jobs_strongify(self)
        self.index = index.intValue;
        if (direction.intValue) {//手势朝下
            self.index -= 1;
        }else{//手势朝上
            self.index += 1;
        }
        
        if (self.index < 0) {
            self.index = 0;
        }
        
        if (self.index > self.dataMutArr.count - 1) {
            self.index = self.dataMutArr.count - 1;
        }
        
        NSLog(@"MMM = %ld",self.index);
        [self roll];
    }];
    NSLog(@"DDD0 = %ld",self.index);
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell的生命周期
//将要出现的cell
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(PlayerCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"KKK %ld",(long)indexPath.row);

    [cell.player.currentPlayerManager play];
}
//已经消失的cell
- (void)tableView:(UITableView *)tableView
didEndDisplayingCell:(PlayerCell *)cell
forRowAtIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"DDDD %ld",(long)indexPath.row);
    [cell.player.currentPlayerManager pause];
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = JobsWhiteColor;
        _tableView.pagingEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = UIView.new;/// 这里接入的就是一个UIView的派生类
        
        {
            // 创建自定义值，用model管理
            MJRefreshConfigModel *refreshConfigHeader = MJRefreshConfigModel.new;
            refreshConfigHeader.stateIdleTitle = @"下拉刷新数据";
            refreshConfigHeader.pullingTitle = @"下拉刷新数据";
            refreshConfigHeader.refreshingTitle = @"正在刷新数据";
            refreshConfigHeader.willRefreshTitle = @"刷新数据中";
            refreshConfigHeader.noMoreDataTitle = @"下拉刷新数据";
            
            MJRefreshConfigModel *refreshConfigFooter = MJRefreshConfigModel.new;
            refreshConfigFooter.stateIdleTitle = @"";
            refreshConfigFooter.pullingTitle = @"";
            refreshConfigFooter.refreshingTitle = @"";
            refreshConfigFooter.willRefreshTitle = @"";
            refreshConfigFooter.noMoreDataTitle = @"";
            
            // 赋值
            self.lotAnimMJRefreshHeader.refreshConfigModel = refreshConfigHeader;
            self.refreshConfigFooter = refreshConfigFooter;//数据赋值
            // 用值
            _tableView.mj_header = self.lotAnimMJRefreshHeader;
            _tableView.mj_footer = self.mjRefreshAutoGifFooter;
            _tableView.mj_footer.backgroundColor = JobsRedColor;
            self.view.mjRefreshTargetView = _tableView;
        }
        
        {
            _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
                                                              titleStr:@"暂无数据"
                                                             detailStr:@"骚等片刻"];
            
        }
        
        if(@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            SuppressWdeprecatedDeclarationsWarning(self.automaticallyAdjustsScrollViewInsets = NO);
        }

        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (self.gk_navBarAlpha && !self.gk_navigationBar.hidden) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view.mas_top);
            }

            extern AppDelegate *appDelegate;
            if (appDelegate.tabBarVC.tabBar.isHidden) {
                make.bottom.equalTo(self.view.mas_bottom);
            }else{
                make.bottom.equalTo(self.view.mas_bottom).offset(-JobsTabBarHeightByBottomSafeArea(appDelegate.tabBarVC));
            }
        }];
    }return _tableView;
}

-(NSMutableArray<VideoModel_Core *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
//        [_dataMutArr addObject:@"0"];
//        [_dataMutArr addObject:@"1"];
//        [_dataMutArr addObject:@"2"];
//        [_dataMutArr addObject:@"3"];
//        [_dataMutArr addObject:@"4"];
//        [_dataMutArr addObject:@"5"];
//        [_dataMutArr addObject:@"6"];
//        [_dataMutArr addObject:@"7"];
//        [_dataMutArr addObject:@"8"];
//        [_dataMutArr addObject:@"9"];
//        [_dataMutArr addObject:@"10"];
//        [_dataMutArr addObject:@"11"];
//        [_dataMutArr addObject:@"12"];
//        [_dataMutArr addObject:@"13"];
//        [_dataMutArr addObject:@"14"];
//        [_dataMutArr addObject:@"15"];
//        [_dataMutArr addObject:@"16"];
//        [_dataMutArr addObject:@"17"];
//        [_dataMutArr addObject:@"18"];
//        [_dataMutArr addObject:@"19"];
//        [_dataMutArr addObject:@"20"];
//        [_dataMutArr addObject:@"21"];
//        [_dataMutArr addObject:@"22"];
//        [_dataMutArr addObject:@"23"];
//        [_dataMutArr addObject:@"24"];
//        [_dataMutArr addObject:@"25"];
//        [_dataMutArr addObject:@"26"];
//        [_dataMutArr addObject:@"27"];
//        [_dataMutArr addObject:@"28"];
//        [_dataMutArr addObject:@"29"];
    }return _dataMutArr;
}

@end
