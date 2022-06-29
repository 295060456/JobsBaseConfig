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
@property(nonatomic,strong)UILabel *tableFooterView;
@property(nonatomic,strong)UIButton *userHeadBtn;
/// Data
@property(nonatomic,strong)NSMutableArray <UITableViewCell *>*tbvCellMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*dataMutArr;

@end

@implementation ViewController_1

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.viewModel.textModel.text = Internationalization(@"相关功能列表");
    self.setupNavigationBarHidden = YES;
    /// 装填用户信息数据
    /// json生成器 ： https://www.site24x7.com/zhcn/tools/json-generator.html
    NSDictionary *dic = @"UserData".readLocalFileWithName;
    DDUserModel *userModel = [DDUserModel mj_objectWithKeyValues:dic];
    [self saveUserInfo:userModel];// 保存全局唯一的一份用户档案
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navLeftBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:self.userHeadBtn];
    self.tableView.alpha = 1;
    self.suspendBtn.alpha = 1;
    
    @jobs_weakify(self)
    self.objectBlock = ^(id data) {
        @jobs_strongify(self)
        if ([data isKindOfClass:JobsSuspendBtn.class]) {
            JobsSuspendBtn *suspendBtn = (JobsSuspendBtn *)data;
            if (suspendBtn.selected) {
                NSInteger s = [self.tableView numberOfSections];/// 有多少组
                if (s < 1) return;
                NSInteger r = [self.tableView numberOfRowsInSection:s-1];/// 最后一组有多少行
                if (r < 1) return;
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:r - 1 inSection:s - 1];/// 取最后一行数据
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];/// 滚动到最后一行
            }else{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];/// 取第一行数据
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];/// 滚动到第一行
            }
        }
    };
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (_dataMutArr.count) {
        [self.dataMutArr removeAllObjects];
        _dataMutArr = nil;
    }
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —— 一些私有方法
#pragma mark —— BaseViewProtocol
/// 下拉刷新 （子类要进行覆写）
-(void)pullToRefresh{
    [NSObject feedbackGenerator];//震动反馈
    [self endRefreshing:self.tableView];
}
/// 上拉加载更多 （子类要进行覆写）
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
-(UIButton *)userHeadBtn{
    if (!_userHeadBtn) {
        _userHeadBtn = UIButton.new;
        
        _userHeadBtn.normalImage = JobsIMG(@"首页_头像");
        _userHeadBtn.normalTitle = Internationalization(@"");
        @jobs_weakify(self)
        [_userHeadBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            UIViewModel *viewModel = [self configViewModelWithTitle:@"用户信息展示(开发测试专用)" subTitle:nil];
            viewModel.cls = JobsShowObjInfoVC.class;
            viewModel.requestParams = self.readUserInfo;
            [self forceComingToPushVC:viewModel.cls.new
                        requestParams:viewModel];// 测试专用
        }];
        _userHeadBtn.size = CGSizeMake(JobsWidth(32), JobsWidth(32));
        [_userHeadBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                      imageTitleSpace:JobsWidth(1)];
    }return _userHeadBtn;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = AppMainCor_02;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        [self dataLinkByTableView:_tableView];
        _tableView.tableHeaderView = UIView.new;/// 这里接入的就是一个UIView的派生类
        _tableView.tableFooterView = self.tableFooterView;/// 这里接入的就是一个UIView的派生类
        _tableView.separatorColor = HEXCOLOR(0xEEEEEE);
        _tableView.contentInset = UIEdgeInsetsMake(JobsWidth(0),
                                                   JobsWidth(0),
                                                   JobsWidth(100),
                                                   JobsWidth(0));
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
            
            _tableView.ly_emptyView.titleLabTextColor = JobsLightGrayColor;
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

-(UILabel *)tableFooterView{
    if (!_tableFooterView) {
        _tableFooterView = UILabel.new;
        _tableFooterView.text = Internationalization(@"- 没有更多的内容了 -");
        _tableFooterView.font = UIFontWeightRegularSize(12);
        _tableFooterView.textAlignment = NSTextAlignmentCenter;
        _tableFooterView.textColor = HEXCOLOR(0xB0B0B0);
//        _tableFooterView.size = CGSizeMake(JobsMainScreen_WIDTH(), JobsWidth(48));
        [_tableFooterView makeLabelByShowingType:UILabelShowingType_03];
    }return _tableFooterView;
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
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsAppDoor-1"
                                                           subTitle:Internationalization(@"登录注册的第一种表现形式")];
            viewModel.cls = JobsAppDoorVC.class;
            viewModel.requestParams = @(JobsAppDoorBgType_video);
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsAppDoor-2"
                                                           subTitle:Internationalization(@"登录注册的第二种表现形式")];
            viewModel.cls = JobsAppDoorVC_Style2.class;
            viewModel.requestParams = @(JobsAppDoorBgType_video);
            [_dataMutArr addObject:viewModel];
        }

        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"TransparentRegion"
                                                           subTitle:Internationalization(@"镂空特效")];
            viewModel.cls = TransparentRegionVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"Douyin_ZFPlayer_1"
                                                           subTitle:Internationalization(@"播放效果 1")];
            viewModel.cls = Douyin_ZFPlayerVC_1.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"Douyin_ZFPlayer_2"
                                                           subTitle:Internationalization(@"播放效果 2")];
            viewModel.cls = Douyin_ZFPlayerVC_2.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsComment"
                                                           subTitle:Internationalization(@"📃评论功能")];
            viewModel.cls = JobsCommentVC.class;
            [_dataMutArr addObject:viewModel];
        }
    
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsSearch"
                                                           subTitle:Internationalization(@"🔍搜索功能")];
            viewModel.cls = JobsSearchVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"ShadowTBVCell"
                                                           subTitle:nil];
//            viewModel.cls =
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsShooting"
                                                           subTitle:Internationalization(@"📹拍摄功能")];
//            viewModel.cls =
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"DynamicView"
                                                           subTitle:Internationalization(@"gif图片读取")];
            viewModel.cls = DynamicViewTestVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"Progress"
                                                           subTitle:Internationalization(@"进度条")];
            viewModel.cls = JobsProgressVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"IrregularView"
                                                           subTitle:Internationalization(@"不规则的按钮")];
            viewModel.cls = TestIrregularViewTestVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsTimer"
                                                           subTitle:Internationalization(@"☀️时间模块")];
            viewModel.cls = JobsTimerVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"NSTimerManagerTestVC"
                                                           subTitle:Internationalization(@"🌛NSTimerManager模块测试")];
            viewModel.cls = NSTimerManagerTestVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsIMShowVC"
                                                           subTitle:Internationalization(@"IM模块")];
            viewModel.cls = JobsIMShowVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"TestLabelVC"
                                                           subTitle:Internationalization(@"Label的科学管理")];
            viewModel.cls = TestLabelVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsLaunchVC"
                                                           subTitle:Internationalization(@"App启动广告模块")];
            viewModel.cls = JobsLaunchVC.class;
            viewModel.requestParams = @(JobsLaunchBgType_video);
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsDropDownListVC"
                                                           subTitle:Internationalization(@"下拉列表")];
            viewModel.cls = JobsDropDownListVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"YTKNetworkStudyVC"
                                                           subTitle:Internationalization(@"探究猿题库网络框架（YTKNetwork）")];
            viewModel.cls = YTKNetworkStudyVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"CoreTextLearningVC"
                                                           subTitle:Internationalization(@"探究CoreText")];
            viewModel.cls = CoreTextLearningVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JXCategoryPopupVC"
                                                           subTitle:Internationalization(@"JXCategoryView+PopupView")];
            viewModel.cls = JXCategoryPopupVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"UITableViewCellEditorVC"
                                                           subTitle:Internationalization(@"替换系统UITableViewCell编辑状态下前面的按钮UI样式，及其一部分逻辑")];
            viewModel.cls = UITableViewCellEditorVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsSettingGestureVC"
                                                           subTitle:Internationalization(@"设置手势密码")];
            viewModel.cls = JobsSettingGestureVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsTestVC"
                                                           subTitle:Internationalization(@"进行测试的一个控制器")];
            viewModel.cls = JobsTestVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"IntervalTBVCellShow"
                                                           subTitle:Internationalization(@"UITableViewCell间隔")];
            viewModel.cls = IntervalTBVCellShow.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"CXBVC"
                                                           subTitle:Internationalization(@"程肖斌自研科技")];
            viewModel.cls = CXBVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"OCDynamicRegisterVC"
                                                           subTitle:Internationalization(@"OC动态添加类、方法列表、属性列表")];
            viewModel.cls = OCDynamicRegisterVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JXCategoryViewWithHeaderViewVC"
                                                           subTitle:Internationalization(@"JXCategoryView下拉放大头部视图")];
            viewModel.cls = JXCategoryViewWithHeaderViewVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"UILabelWordRotatingVC"
                                                           subTitle:Internationalization(@"UILabel文字旋转")];
            viewModel.cls = UILabelWordRotatingVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JXCategoryViewVerticalShowVC"
                                                           subTitle:Internationalization(@"JXCategoryView垂直表达")];
            viewModel.cls = JXCategoryViewVerticalShowVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"JobsVerticalMenuVC"
                                                           subTitle:Internationalization(@"竖形菜单选择功能")];
            viewModel.cls = JobsVerticalMenuVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"TestBaseLabelVC"
                                                           subTitle:Internationalization(@"测试 -BaseLabel-")];
            viewModel.cls = TestBaseLabelVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"RandomTestVC"
                                                           subTitle:Internationalization(@"随机数测试模块")];
            viewModel.cls = RandomTestVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = [self configViewModelWithTitle:@"CustomTableViewCellVC"
                                                           subTitle:Internationalization(@"自定义UITableViewCell内置控件距离并添加复制按钮")];
            viewModel.cls = CustomTableViewCellVC.class;
            [_dataMutArr addObject:viewModel];
        }
        
//        {
//            UIViewModel *viewModel = [self configViewModelWithTitle:@"ProtocolKitVC"
//                                                           subTitle:Internationalization(@"Objective-C中实现协议扩展")];
//            viewModel.cls = ProtocolKitVC.class;
//            [_dataMutArr addObject:viewModel];
//        }
        
    }return _dataMutArr;
}

@end
