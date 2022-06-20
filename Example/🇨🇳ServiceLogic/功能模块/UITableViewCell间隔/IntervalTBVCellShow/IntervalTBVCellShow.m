//
//  IntervalTBVCellShow.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/8.
//

#import "IntervalTBVCellShow.h"

@interface IntervalTBVCellShow ()
/// UI
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)BaiShaETProjMembersBoardView *userHeaderView;
/// Data
@property(nonatomic,strong)NSMutableArray <NSMutableArray <UIViewModel *>*>*dataMutArr;
@property(nonatomic,strong)NSMutableArray <NSMutableArray <UITableViewCell<UITableViewCellProtocol> *>*>*tableViewCellMutArr;

@end

@implementation IntervalTBVCellShow

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
    
    //    self.viewModel.backBtnTitleModel.text = @"";
    //    self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
    //    self.viewModel.textModel.text = Internationalization(@"消息详情页");
    //    self.viewModel.textModel.font = notoSansBold(16);
    //
    //    self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGKNav];
    [self setGKNavBackBtn];
//    self.gk_navigationBar.jobsVisible = NO;
    
    self.tableView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark —— 一些私有方法
///下拉刷新 （子类要进行覆写）
-(void)pullToRefresh{
    [NSObject feedbackGenerator];//震动反馈

}
///上拉加载更多 （子类要进行覆写）
-(void)loadMoreRefresh{
    [self pullToRefresh];
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableViewCellMutArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return [BaiShaETProjMembersTBVCell2 cellHeightWithModel:nil];
            break;
        case 1:
        case 2:
            return [BaiShaETProjMembersTBVCell1 cellHeightWithModel:nil];
            break;
        default:
            return [BaseTableViewCell cellHeightWithModel:nil];
            break;
    }
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataMutArr[indexPath.section - 1][indexPath.row].textModel.text isEqualToString:Internationalization(@"额度記錄")]){
        toast(Internationalization(@"额度記錄"));
    }else if([self.dataMutArr[indexPath.section - 1][indexPath.row].textModel.text isEqualToString:Internationalization(@"投注記錄")]){
        toast(Internationalization(@"投注記錄"));
    }else if([self.dataMutArr[indexPath.section - 1][indexPath.row].textModel.text isEqualToString:Internationalization(@"存取款記錄")]){
        toast(Internationalization(@"存取款記錄"));
    }else{}
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.tableViewCellMutArr[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = (BaseTableViewCell *)self.tableViewCellMutArr[indexPath.section][indexPath.row];
    if (indexPath.section) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.section) {
        case 0:
            [cell richElementsInCellWithModel:nil];
            break;
        case 1:
        case 2:
            [cell richElementsInCellWithModel:self.dataMutArr[indexPath.section - 1][indexPath.row]];
            break;
        default:
            [cell richElementsInCellWithModel:nil];
            break;
    }return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return 0;
}
/// 这里涉及到复用机制，return出去的是UITableViewHeaderFooterView的派生类
- (nullable UIView *)tableView:(UITableView *)tableView
        viewForHeaderInSection:(NSInteger)section{
    BaseTableViewHeaderView *headerView = BaseTableViewHeaderView.jobsInitWithReuseIdentifier;
    headerView.section = section;
    headerView.backgroundColor = HEXCOLOR(0xEAEBED);
    headerView.contentView.backgroundColor = HEXCOLOR(0xEAEBED);
    
    [headerView richElementsInViewWithModel:nil];
    @jobs_weakify(self)
    [headerView actionObjectBlock:^(id data) {
        @jobs_strongify(self)
    }];return headerView;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.img = KIMG(@"向右的箭头（大）");
    @jobs_weakify(self)
    [cell customAccessoryView:^(id data) {
        @jobs_strongify(self)
        BaiShaETProjMembersTBVCell1 *cell = (BaiShaETProjMembersTBVCell1 *)data;
        NSLog(@"MMM - %ld",cell.index);
    }];
    
    [UITableViewCell tableView:tableView
   makeSectionFirstAndLastCell:cell
                   atIndexPath:indexPath
                     cellBgCor:UIColor.whiteColor
                 bottomLineCor:UIColor.whiteColor
                cellOutLineCor:HEXCOLOR(0xEEE2C8)
                   roundCorner:JobsWidth(8)
                   borderWidth:JobsWidth(10)
                            dx:JobsWidth(1)
                            dy:0];

}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.initWithStylePlain;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.userHeaderView;/// 这里接入的就是一个UIView的派生类
        _tableView.tableFooterView = UIView.new;/// 这里接入的就是一个UIView的派生类
        _tableView.separatorColor = UIColor.whiteColor;//HEXCOLOR(0xEEEEEE);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, JobsWidth(20), 0);
        [_tableView registerTableViewClass];
        if(@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            SuppressWdeprecatedDeclarationsWarning(self.automaticallyAdjustsScrollViewInsets = NO);
        }
        
        {
            MJRefreshConfigModel *refreshConfigHeader = MJRefreshConfigModel.new;
            refreshConfigHeader.stateIdleTitle = Internationalization(@"下拉可以刷新");
            refreshConfigHeader.pullingTitle = Internationalization(@"下拉可以刷新");
            refreshConfigHeader.refreshingTitle = Internationalization(@"松开立即刷新");
            refreshConfigHeader.willRefreshTitle = Internationalization(@"刷新数据中");
            refreshConfigHeader.noMoreDataTitle = Internationalization(@"下拉可以刷新");
            
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
        [self fullScreenConstraintTargetView:_tableView topViewOffset:0];
        [_tableView layerBorderColour:UIColor.clearColor andBorderWidth:0.1];
    }return _tableView;
}

-(NSMutableArray<NSMutableArray<UIViewModel *> *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
        
        {
            NSMutableArray *sectionMutArr = NSMutableArray.array;
            
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"投注記錄");
                viewModel.image = KIMG(@"投注记录");
                [sectionMutArr addObject:viewModel];
            }
            
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"额度記錄");
                viewModel.image = KIMG(@"額度記錄");
                [sectionMutArr addObject:viewModel];
            }
            
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"存取款記錄");
                viewModel.image = KIMG(@"存取款记录");
                [sectionMutArr addObject:viewModel];
            }
            
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"收款账户管理");
                viewModel.image = KIMG(@"收款账户管理");
                [sectionMutArr addObject:viewModel];
            }
            
            [_dataMutArr addObject:sectionMutArr];
        }
        
        {
            NSMutableArray *sectionMutArr = NSMutableArray.array;
            
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"帮助中心");
                viewModel.image = KIMG(@"帮助中心");
                [sectionMutArr addObject:viewModel];
            }
            
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"加入我们");
                viewModel.image = KIMG(@"加入我们");
                [sectionMutArr addObject:viewModel];
            }
            
            [_dataMutArr addObject:sectionMutArr];
        }
    }return _dataMutArr;
}

-(NSMutableArray<NSMutableArray<UITableViewCell<UITableViewCellProtocol> *> *> *)tableViewCellMutArr{
    if (!_tableViewCellMutArr) {
        _tableViewCellMutArr = NSMutableArray.array;
        
        NSMutableArray *sectionMutArr = NSMutableArray.array;
        [sectionMutArr addObject:[BaiShaETProjMembersTBVCell2 cellWithTableView:self.tableView]];
        [_tableViewCellMutArr addObject:sectionMutArr];
        
        {
            NSMutableArray *sectionMutArr = NSMutableArray.array;
            for (id arr in self.dataMutArr[0]) {
                [sectionMutArr addObject:[BaiShaETProjMembersTBVCell1 cellWithTableView:self.tableView]];
            }
            [_tableViewCellMutArr addObject:sectionMutArr];
        }
        
        {
            NSMutableArray *sectionMutArr = NSMutableArray.array;
            for (id arr in self.dataMutArr[1]) {
                [sectionMutArr addObject:[BaiShaETProjMembersTBVCell1 cellWithTableView:self.tableView]];
            }
            [_tableViewCellMutArr addObject:sectionMutArr];
        }
    }return _tableViewCellMutArr;
}


@end
