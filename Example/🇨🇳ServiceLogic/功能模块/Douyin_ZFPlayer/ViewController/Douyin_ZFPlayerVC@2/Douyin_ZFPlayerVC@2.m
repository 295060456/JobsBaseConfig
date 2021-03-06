//
//  Douyin_ZFPlayerVC@2.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/8.
//

#import "Douyin_ZFPlayerVC@2.h"

@interface Douyin_ZFPlayerVC_2 ()

/// UI
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)ZFDouYinControlView *controlView;
@property(nonatomic,strong)ZFCustomControlView *fullControlView;
@property(nonatomic,strong)JobsBitsMonitorSuspendLab *bitsMonitorSuspendLab;
/// Data
@property(nonatomic,strong)NSMutableArray <VideoModel_Core *>*dataSource;

@end

@implementation Douyin_ZFPlayerVC_2

-(void)dealloc {
    NSLog(@"%@",JobsLocalFunc);
}
#pragma mark —— Lifecycle
-(instancetype)init{
    if (self = [super init]) {
       
    }return self;
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    
    self.setupNavigationBarHidden = YES;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    
    self.tableView.alpha = 1;
    self.bitsMonitorSuspendLab.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    JobsBitsMonitorCore.sharedInstance.bitsMonitorRunMode = BitsMonitorManualRun;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [JobsBitsMonitorCore.sharedInstance stop];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    /**
     * 请求到数据以后，刷新界面reloadData
     * 这个时候会先走UITableViewDelegate,UITableViewDataSource
     * 再viewWillLayoutSubviews-viewDidLayoutSubviews
     * 在这个时候拿到确定的当前self.indexPath进行播放
     */
    if (self.dataSource.count) {
        [self playTheVideoAtIndexPath:self.indexPath];
        [self.tableView ly_hideEmptyView];
    }else{
        [self.tableView ly_showEmptyView];
    }
}
//- (void)requestDataa {
//    /// 下拉时候一定要停止当前播放，不然有新数据，播放位置会错位。
//    [self.player stopCurrentPlayingCell];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"data"
//                                                     ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data
//                                                             options:NSJSONReadingAllowFragments
//                                                               error:nil];
//
//    NSArray *videoList = [rootDict objectForKey:@"list"];
//    for (NSDictionary *dataDic in videoList) {
//        ZFTableData *data = [[ZFTableData alloc] init];
//        [data setValuesForKeysWithDictionary:dataDic];
//        [self.dataSource addObject:data];
//    }
//    [self endRefreshing:self.tableView];
////    [self endRefreshingWithNoMoreData:self.tableView];
//}
// 刷新加载最新数据（以前的数据全部清空）
-(void)requestData:(BOOL)isLoadMore{
    /// 下拉时候一定要停止当前播放，不然有新数据，播放位置会错位。
    [self.player stopCurrentPlayingCell];
    NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],[ZBRequestManager networkReachability]);
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
    extern NSString *appInterfaceTesting;
    [DDNetworkingAPI requestApi:NSObject.appInterfaceTesting.funcName
                     parameters:@{@"pageSize":@(self.pageSize),
                                  @"pageNum":@(self.currentPage)}
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
                    [self.dataSource removeAllObjects];
                }
                
                if (isLoadMore) {
                    if (tempDataArr.count) {
                        [self.dataSource addObjectsFromArray:tempDataArr];
                        [self endRefreshing:self.tableView];//上拉加载更多
                    }else{
                        [self endRefreshingWithNoMoreData:self.tableView];//没有更多数据了
                    }
                }
            }
            
            /// 找到可以播放的视频并播放
            @jobs_weakify(self)
            [self.player zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
                @jobs_strongify(self)
                [self playTheVideoAtIndexPath:indexPath];
            }];
            
        }
    }failureBlock:^(id data) {
        @jobs_strongify(self)
        if (self.currentPage > 1) {
            self.currentPage -= 1;
        }
    }];
}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    self.currentPage = 1;
    [self requestData:NO];
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
    self.currentPage += 1;
//    NSLog(@"currentPageNum = %ld",self.currentPage);
    [self requestData:YES];
}

- (void)playTheIndex:(NSInteger)index {
    @jobs_weakify(self)
    /// 指定到某一行播放
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
    [self.player zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        @jobs_strongify(self)
        [self playTheVideoAtIndexPath:indexPath];
    }];
    /// 如果是最后一行，去请求新数据
    if (index == self.dataSource.count - 1) {
        /// 加载下一页数据
        [self requestData:YES];
    }
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}
/// play the video
-(void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath{
    VideoModel_Core *data = self.dataSource[indexPath.row];
    [self.player playTheIndexPath:indexPath//
                         assetURL:[NSURL URLWithString:data.videoIdcUrl]];//@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
//    [self.player playTheIndexPath:indexPath assetURL:[VIResourceLoaderManager assetURLWithURL:[NSURL URLWithString:data.video_url]]];
    [self.controlView resetControlView];
    [self.controlView showCoverViewWithUrl:data.videoImg];
    [self.fullControlView showTitle:@"custom landscape controlView"
                     coverURLString:data.videoImg
                     fullScreenMode:ZFFullScreenModeLandscape];
}
//#pragma mark - ZFTableViewCellDelegate
//-(void)zf_playTheVideoAtIndexPath:(NSIndexPath *)indexPath{
//    [self playTheVideoAtIndexPath:indexPath];
//}
#pragma mark - ZFDouYinCellDelegate
-(void)zf_douyinRotation{
    UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
    if(self.player.isFullScreen){
        orientation = UIInterfaceOrientationPortrait;
    }else{
        orientation = UIInterfaceOrientationLandscapeRight;
    }
    [self.player rotateToOrientation:orientation
                            animated:YES
                          completion:nil];
}
#pragma mark —— UIScrollViewDelegate 列表播放必须实现
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [scrollView zf_scrollViewDidEndDecelerating];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    [scrollView zf_scrollViewDidScrollToTop];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [scrollView zf_scrollViewDidScroll];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [scrollView zf_scrollViewWillBeginDragging];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ZFDouYinCell cellHeightWithModel:@{@"tableView":tableView}];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    ZFDouYinCell *cell = [ZFDouYinCell cellStyleValue1WithTableView:tableView];
    cell.delegate = self;
    cell.index = indexPath.row;
    [cell richElementsInCellWithModel:@{
        @"index":@(indexPath.row),
        @"res":self.dataSource[indexPath.row]
    }];return cell;
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark —— lazyLoad
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.pagingEnabled = YES;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
        
        if (@available(iOS 11.0, *)) {
            
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            SuppressWdeprecatedDeclarationsWarning(self.automaticallyAdjustsScrollViewInsets = NO);
        }
        
        {
//            _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"暂无数据"
//                                                                titleStr:@"暂无数据"
//                                                               detailStr:@""];
            _tableView.ly_emptyView = [EmptyView diyEmptyViewWithTitle:@"暂无数据"];
            _tableView.ly_emptyView.autoShowEmptyView = NO;
            _tableView.ly_emptyView.titleLabTextColor = JobsWhiteColor;
            _tableView.ly_emptyView.contentViewOffset = -JobsWidth(40);
        }
        
        {
            MJRefreshConfigModel *refreshConfigHeader = MJRefreshConfigModel.new;
            refreshConfigHeader.stateIdleTitle = @"下拉刷新数据";
            refreshConfigHeader.pullingTitle = @"下拉刷新数据";
            refreshConfigHeader.refreshingTitle = @"正在刷新数据";
            refreshConfigHeader.willRefreshTitle = @"刷新数据中";
            refreshConfigHeader.noMoreDataTitle = @"下拉刷新数据";
            
            MJRefreshConfigModel *refreshConfigFooter = MJRefreshConfigModel.new;
            refreshConfigFooter.stateIdleTitle = @"上拉加载数据";
            refreshConfigFooter.pullingTitle = @"上拉加载数据";
            refreshConfigFooter.refreshingTitle = @"正在加载数据";
            refreshConfigFooter.willRefreshTitle = @"加载数据中";
            refreshConfigFooter.noMoreDataTitle = @"没有更多数据";
            
            self.refreshConfigHeader = refreshConfigHeader;
            self.refreshConfigFooter = refreshConfigFooter;
            
            _tableView.mj_header = self.mjRefreshNormalHeader;
            _tableView.mj_header.automaticallyChangeAlpha = YES;//根据拖拽比例自动切换透明度
            _tableView.mj_footer = self.mjRefreshAutoNormalFooter;
            _tableView.mj_footer.hidden = NO;
        }
        
        {/// 设置tabAnimated相关属性
            // 可以不进行手动初始化，将使用默认属性
            _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:ZFDouYinCell.class
                                                                  cellHeight:[ZFDouYinCell cellHeightWithModel:nil]];
            _tableView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeShimmer;
   //            [_tableView.tabAnimated addHeaderViewClass:LineTableViewHeaderFooterView.class viewHeight:60 toSection:0];
            [_tableView tab_startAnimation];   // 开启动画
        }
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (self.gk_navBarAlpha && !self.gk_navigationBar.hidden) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view.mas_top);
            }
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }return _tableView;
}

-(ZFPlayerController *)player{
    if (!_player) {
        /// player,tag值必须在cell里设置
        _player = [ZFPlayerController playerWithScrollView:self.tableView
                                             playerManager:self.playerManager
                                          containerViewTag:kPlayerViewTag];
        _player.disableGestureTypes = ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
        _player.controlView = self.controlView;

        _player.allowOrentitaionRotation = NO;
        _player.WWANAutoPlay = YES;
        /// 1.0是完全消失时候
        _player.playerDisapperaPercent = 1.0;
        
        @jobs_weakify(self)
        _player.playerDidToEnd = ^(id _Nonnull asset) {
            @jobs_strongify(self)
            [self->_player.currentPlayerManager replay];
        };

        _player.orientationWillChange = ^(ZFPlayerController * _Nonnull player,
                                          BOOL isFullScreen) {
            extern AppDelegate *appDelegate;
            appDelegate.allowOrentitaionRotation = isFullScreen;
            @jobs_strongify(self)
            self->_player.controlView.hidden = YES;
        };
        
        _player.orientationDidChanged = ^(ZFPlayerController * _Nonnull player,
                                          BOOL isFullScreen) {
            @jobs_strongify(self)
            self->_player.controlView.hidden = NO;
            if (isFullScreen) {
                self->_player.controlView = self.fullControlView;
            } else {
                self->_player.controlView = self.controlView;
            }
        };
        
        /// 更新另一个控制层的时间
        _player.playerPlayTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset,
                                          NSTimeInterval currentTime,
                                          NSTimeInterval duration) {
            @jobs_strongify(self)
            if ([self->_player.controlView isEqual:self.fullControlView]) {
                [self.controlView videoPlayer:self->_player
                                  currentTime:currentTime
                                    totalTime:duration];
            } else if ([self->_player.controlView isEqual:self.controlView]) {
                [self.fullControlView videoPlayer:self->_player
                                      currentTime:currentTime
                                        totalTime:duration];
            }
        };
        
        /// 更新另一个控制层的缓冲时间
        _player.playerBufferTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset,
                                            NSTimeInterval bufferTime) {
            @jobs_strongify(self)
            if ([self->_player.controlView isEqual:self.fullControlView]) {
                [self.controlView videoPlayer:self->_player
                                   bufferTime:bufferTime];
            } else if ([self->_player.controlView isEqual:self.controlView]) {
                [self.fullControlView videoPlayer:self->_player
                                       bufferTime:bufferTime];
            }
        };
        
        /// 停止的时候找出最合适的播放
        _player.zf_scrollViewDidEndScrollingCallback = ^(NSIndexPath * _Nonnull indexPath) {
            @jobs_strongify(self)
            if (self->_player.playingIndexPath) return;
            if (indexPath.row == self.dataSource.count - 1) {
                /// 加载下一页数据
                [self requestData:YES];
                [self.tableView reloadData];
            }
            [self playTheVideoAtIndexPath:indexPath];
        };
    }return _player;
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
    }return _playerManager;
}

-(ZFDouYinControlView *)controlView{
    if (!_controlView){
        _controlView = ZFDouYinControlView.new;
    }return _controlView;
}

- (ZFCustomControlView *)fullControlView {
    if (!_fullControlView) {
        _fullControlView = ZFCustomControlView.new;
    }return _fullControlView;
}

-(NSMutableArray<VideoModel_Core *> *)dataSource{
    if (!_dataSource) {
        _dataSource = NSMutableArray.array;
    }return _dataSource;
}

@synthesize pageSize = _pageSize;
-(NSInteger)pageSize{
    if (!_pageSize) {
        _pageSize = 6;
    }return _pageSize;
}

-(JobsBitsMonitorSuspendLab *)bitsMonitorSuspendLab{
    if (!_bitsMonitorSuspendLab) {
        _bitsMonitorSuspendLab = JobsBitsMonitorSuspendLab.new;
        _bitsMonitorSuspendLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightBold];
        _bitsMonitorSuspendLab.backgroundColor = JobsLightGrayColor;
        _bitsMonitorSuspendLab.textColor = JobsRedColor;
        @jobs_weakify(self)
        _bitsMonitorSuspendLab.vc = weak_self;
        _bitsMonitorSuspendLab.isAllowDrag = YES;//悬浮效果必须要的参数
        [self.view addSubview:_bitsMonitorSuspendLab];
        _bitsMonitorSuspendLab.frame = CGRectMake(20,
                                                  JobsMainScreen_HEIGHT() - 200,
                                                  80,
                                                  30);
    }return _bitsMonitorSuspendLab;
}

@end
