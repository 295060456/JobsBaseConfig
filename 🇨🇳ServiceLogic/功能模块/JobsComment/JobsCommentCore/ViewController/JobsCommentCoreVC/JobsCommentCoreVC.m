//
//  JobsCommentCoreVC.m
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import "JobsCommentCoreVC.h"

@interface JobsCommentCoreVC ()
/// UI
@property(nonatomic,strong)JobsCommentTitleHeaderView *titleHeaderView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation JobsCommentCoreVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
//        [self loadData];
    }return self;
}

-(void)loadView{
    [super loadView];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.gk_statusBarHidden = YES;
    self.gk_navigationBar.hidden = YES;
    
    self.titleHeaderView.alpha = 1;
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
#pragma mark —— 一些私有方法
/// 装载本地假数据
-(void)loadData{
    NSDictionary *dic = @"CommentData".readLocalFileWithName;
    self.mjModel = [JobsCommentModel mj_objectWithKeyValues:dic[@"data"]];
//    self.yyModel = [MKCommentModel yy_modelWithDictionary:dic[@"data"]];
    NSLog(@"KKK");

    [self dataSource:self.mjModel.listDataArr contentView:self.tableView];
    [self endRefreshing:self.tableView];
}

-(void)delayMethods{
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.pagingEnabled = YES;
}

-(void)二级标题点击事件{
    SYSAlertControllerConfig *config = SYSAlertControllerConfig.new;
    config.isSeparateStyle = YES;
    config.btnTitleArr = @[@"回复",@"复制",@"举报",@"取消"];
    config.alertBtnActionArr = @[@"reply",@"copyIt",@"report",@"cancel"];
    config.targetVC = self;
    config.funcInWhere = self;
    config.animated = YES;
    
    [NSObject showSYSActionSheetConfig:config
                          alertVCBlock:nil
                       completionBlock:nil];
}
#pragma mark —— BaseViewProtocol
/// 下拉刷新 （子类要进行覆写）
-(void)pullToRefresh{
    [self loadData];
}
/// 上拉加载更多 （子类要进行覆写）
-(void)loadMoreRefresh{
    self.tableView.pagingEnabled = NO;
    @jobs_weakify(self)
    [self delay:0.1
          doSth:^(id data) {
        @strongify(self)
        [self delayMethods];
    }];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JobsLoadMoreTBVCell cellHeightWithModel:nil];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self 二级标题点击事件];
}
/// 二级评论
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    JobsFirstCommentModel *firstCommentModel = (JobsFirstCommentModel *)self.mjModel.listDataArr[section];
    JobsFirstCommentCustomCofigModel *customCofigModel = JobsFirstCommentCustomCofigModel.new;
    customCofigModel.childDataArr = firstCommentModel.childDataArr;
    return customCofigModel.firstShonNum;
}
/// 二级评论数据 展示在cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobsFirstCommentModel *firstCommentModel = (JobsFirstCommentModel *)self.mjModel.listDataArr[indexPath.section];//一级评论数据 展示在viewForHeaderInSection
    JobsChildCommentModel *childCommentModel = firstCommentModel.childDataArr[indexPath.row];//二级评论数据 展示在cellForRowAtIndexPath
    
    JobsFirstCommentCustomCofigModel *customCofigModel = JobsFirstCommentCustomCofigModel.new;
    customCofigModel.childDataArr = firstCommentModel.childDataArr;
    
    if (customCofigModel.isFullShow) {
        JobsInfoTBVCell *cell = [JobsInfoTBVCell cellWithTableView:tableView];
        [cell richElementsInCellWithModel:childCommentModel];
//        @weakify(self)
        [cell actionViewBlock:^(id data) {
//            @jobs_strongify(self)
        }];return cell;
    }else{
        if (indexPath.row <= customCofigModel.firstShonNum) {
            // 二级评论展示...
            JobsInfoTBVCell *cell = [JobsInfoTBVCell cellWithTableView:tableView];
            [cell richElementsInCellWithModel:childCommentModel];
//            @weakify(self)
            [cell actionViewBlock:^(id data) {
//                @jobs_strongify(self)
            }];return cell;
        }else{
            // 加载更多...
            JobsLoadMoreTBVCell *cell = [JobsLoadMoreTBVCell cellWithTableView:tableView];
            [cell richElementsInCellWithModel:nil];
            return cell;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mjModel.listDataArr.count;/// 一级评论👌
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{///  👌
    return [JobsCommentPopUpViewForTVH viewHeightWithModel:nil];
}
/// 一级评论数据 展示在viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    JobsFirstCommentModel *firstCommentModel = self.mjModel.listDataArr[section];//一级评论数据 展示在viewForHeaderInSection
    JobsCommentPopUpViewForTVH *header = [JobsCommentPopUpViewForTVH.alloc initWithReuseIdentifier:NSStringFromClass(JobsCommentPopUpViewForTVH.class) withData:firstCommentModel];
    @weakify(self)
    // 一级标题点击事件
    [header actionViewBlock:^(id data) {
        @strongify(self)
        SYSAlertControllerConfig *config = SYSAlertControllerConfig.new;
        config.title = @"牛逼";
        config.message = @"哈哈哈";
        config.isSeparateStyle = NO;
        config.btnTitleArr = @[@"好的"];
        config.alertBtnActionArr = @[@""];
        config.targetVC = self;
        config.funcInWhere = self;
        config.animated = YES;
        
        [NSObject showSYSAlertViewConfig:config
                            alertVCBlock:nil
                         completionBlock:nil];
    }];
    [header actionViewBlock:^(id data) {
//        @strongify(self)
    }];return header;
}
#pragma mark —— lazyLoad
-(JobsCommentTitleHeaderView *)titleHeaderView{
    if (!_titleHeaderView) {
        _titleHeaderView = JobsCommentTitleHeaderView.new;
        @weakify(self)
        [_titleHeaderView actionViewBlock:^(id data) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES
                                     completion:Nil];
        }];
        [self.view addSubview:_titleHeaderView];
        [_titleHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(50);
        }];
    }return _titleHeaderView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        // UITableViewStyleGrouped 取消悬停效果
        _tableView = [UITableView.alloc initWithFrame:CGRectZero
                                                style:UITableViewStyleGrouped];
        _tableView.backgroundColor = HEXCOLOR(0x242A37);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = self.mjRefreshGifHeader;
        _tableView.mj_footer = self.mjRefreshBackNormalFooter;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.mj_footer.hidden = NO;
        _tableView.tableFooterView = UIView.new;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, self.popUpHeight, 0);
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
                                                          titleStr:@"没有评论"
                                                         detailStr:@"来发布第一条吧"];

        @weakify(self)
        _tableView.mj_header = [LOTAnimationMJRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self)
            @weakify(self)
            [self delay:0.1
                  doSth:^(id data) {
                @strongify(self)
                [self pullToRefresh];
            }];
        }];
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.top.equalTo(self.titleHeaderView.mas_bottom);
        }];
    }return _tableView;
}

@end
