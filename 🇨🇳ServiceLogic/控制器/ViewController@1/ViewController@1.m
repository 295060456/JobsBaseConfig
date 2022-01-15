//
//  ViewController@1.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/8.
//

#import "ViewController@1.h"

@interface ViewController_1 ()
/// UI
@property(nonatomic,strong)UITableView *tableView;
/// Data
@property(nonatomic,strong)NSMutableArray <UITableViewCell *>*tbvCellMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*dataMutArr;

@end

@implementation ViewController_1

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
    self.view.backgroundColor = RandomColor;
    [self setGKNav];
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
///下拉刷新 （子类要进行覆写）
-(void)pullToRefresh{
    [NSObject feedbackGenerator];//震动反馈
    [self endRefreshing:self.tableView];
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
    return [BaseTableViewCell cellHeightWithModel:Nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataMutArr[indexPath.row].cls) {
        
        [self comingToPushVC:self.dataMutArr[indexPath.row].cls.new
               requestParams:self.dataMutArr[indexPath.row]];
    }else{
        [WHToast toastMsg:@"尚未接入此功能"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = (BaseTableViewCell *)self.tbvCellMutArr[indexPath.row];
    [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView hideSeparatorLineAtLast:indexPath
                                  cell:cell];
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = AppMainCor_02;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = UIView.new;
        _tableView.tableFooterView = UIView.new;
        _tableView.separatorColor = HEXCOLOR(0xEEEEEE);
        _tableView.contentInset = UIEdgeInsetsMake(JobsWidth(20), 0, 0, 0);
        {
            MJRefreshConfigModel *refreshConfigHeader = MJRefreshConfigModel.new;
            refreshConfigHeader.stateIdleTitle = @"下拉可以刷新";
            refreshConfigHeader.pullingTitle = @"下拉可以刷新";
            refreshConfigHeader.refreshingTitle = @"松开立即刷新";
            refreshConfigHeader.willRefreshTitle = @"刷新数据中";
            refreshConfigHeader.noMoreDataTitle = @"下拉可以刷新";
            
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

-(NSMutableArray<UITableViewCell *> *)tbvCellMutArr{
    if (!_tbvCellMutArr) {
        _tbvCellMutArr = NSMutableArray.array;
        for (UIViewModel *viewModel in self.dataMutArr) {
            [_tbvCellMutArr addObject:[BaseTableViewCell cellWithTableView:self.tableView]];
        }
    }return _tbvCellMutArr;
}

-(NSMutableArray<UIViewModel *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;

        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"JobsAppDoor-1";
            viewModel.subText = @"点击查看";
            viewModel.cls = JobsAppDoorVC.class;
            viewModel.requestParams = @(JobsAppDoorBgType_video);
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"JobsAppDoor-2";
            viewModel.subText = @"点击查看";
            viewModel.cls = JobsAppDoorVC_Style2.class;
            viewModel.requestParams = @(JobsAppDoorBgType_video);
            [_dataMutArr addObject:viewModel];
        }

        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"TransparentRegion";
            viewModel.subText = @"点击查看";
            viewModel.cls = TransparentRegionVC.class;
            
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"Douyin_ZFPlayer_1";
            viewModel.subText = @"点击查看";
            viewModel.cls = Douyin_ZFPlayerVC_1.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"Douyin_ZFPlayer_2";
            viewModel.subText = @"点击查看";
            viewModel.cls = Douyin_ZFPlayerVC_2.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"JobsComment";
            viewModel.subText = @"点击查看";
            viewModel.cls = JobsCommentVC.class;
            [_dataMutArr addObject:viewModel];
        }
    
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"JobsSearch";
            viewModel.subText = @"点击查看";
            viewModel.cls = JobsSearchVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"JobsTimer";
            viewModel.subText = @"点击查看";
//            viewModel.cls =
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"ShadowTBVCell";
            viewModel.subText = @"点击查看";
//            viewModel.cls =
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"JobsShooting";
            viewModel.subText = @"点击查看";
//            viewModel.cls =
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"DynamicView";
            viewModel.subText = @"点击查看";
            viewModel.cls = DynamicViewTestVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"Progress";
            viewModel.subText = @"点击查看";
            viewModel.cls = JobsProgressVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"IrregularView";
            viewModel.subText = @"点击查看";
            viewModel.cls = TestIrregularViewTestVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"JobsTimer";
            viewModel.subText = @"点击查看";
//            viewModel.cls =
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"JobsIM";
            viewModel.subText = @"点击查看";
            viewModel.cls = JobsIMShowVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
    }return _dataMutArr;
}

@end
