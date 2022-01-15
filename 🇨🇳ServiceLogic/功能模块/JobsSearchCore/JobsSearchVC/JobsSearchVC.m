//
//  JobsSearchVC.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/2.
//

#import "JobsSearchVC.h"

@interface JobsSearchVC ()
/// UI
@property(nonatomic,strong)UIButton *scanBtn;
@property(nonatomic,strong)JobsSearchTableView *tableView;
@property(nonatomic,strong)JobsSearchBar *jobsSearchBar;
@property(nonatomic,strong)JobsSearchResultDataListView *jobsSearchResultDataListView;
/// Data
@property(nonatomic,strong)NSMutableArray <NSString *>*sectionTitleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*hotSearchMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*historySearchMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*searchResDataMutArr;
@property(nonatomic,strong)UIColor *bgColour;
@property(nonatomic,assign)NSString *titleStr;//标题
@property(nonatomic,assign)CGRect tableViewRect;
@property(nonatomic,assign)CGFloat gk_navigationBarHeight;
@property(nonatomic,assign)HotSearchStyle hotSearchStyle;

@end

@implementation JobsSearchVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)loadView{
    [super loadView];
    self.setupNavigationBarHidden = YES;
    self.isHiddenNavigationBar = YES;
    self.isOpenLetterCase = YES;//模糊查询时，是否开启输入字母大小写检测？默认开启
    self.gk_interactivePopDisabled = NO;
    self.gk_fullScreenPopDisabled = NO;
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    
//    {// 外界推得时候这么写
//        [self comingToPushVC:CasinoOpenAccountVC.new
//                withNavTitle:Internationalization(@"Open an account")];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGKNav];
    self.getTabBar.hidden = YES;
    
    if (![NSString isNullString:self.viewModel.text]) {
        self.gk_navLeftBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:self.backBtnCategory];
        self.gk_navRightBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:self.scanBtn];
    }
    self.tableView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark —— 一些私有化方法
/// 逐字搜索功能
-(void)searchByString:(NSString *)string{
    //每次都清数据
    [self.searchResDataMutArr removeAllObjects];
    [self.jobsSearchResultDataListView.searchResDataMutArr removeAllObjects];
    //在此可以网络请求
    //也可以对本地的一个数据库文件进行遍历
    NSDictionary *dic = @"假数据".readLocalFileWithName;
    NSArray *arr = dic[@"data"];
    for (NSString *str in arr) {
        if (self.isOpenLetterCase ? [str.lowercaseString containsString:string.lowercaseString] : [str containsString:string]) {
            [self.searchResDataMutArr addObject:str];
        }
    }
    self.jobsSearchResultDataListView.searchResDataMutArr = self.searchResDataMutArr;
    [self.jobsSearchResultDataListView.tableView reloadData];
}
/// 点击自己 自己移除自己的最正确做法，直接置nil 是不成功的
-(void)deallocJobsSearchResultDataListView{
    [_jobsSearchResultDataListView removeFromSuperview];
    _jobsSearchResultDataListView = nil;
}

-(void)cancelBtnEvent{
    if (![NSString isNullString:self.titleStr]) {
        if (self.tableView.mj_y == self.gk_navigationBar.mj_y) {
            [self goUpAndDown:NO];
        }
    }else{
        if (self.tableView.mj_y == 0) {
            [self goUpAndDown:NO];
        }
    }
}

-(void)goUpAndDown:(BOOL)isUpAndDown{
    /*
     *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
     *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
     *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
     *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
     *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
     *    dampingRatio 阻尼
     *    velocity 速度
     */
    @jobs_weakify(self)
    [UIView animateWithDuration:1
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:20
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        @jobs_strongify(self)
        if (isUpAndDown) {//顶上去
            if (![NSString isNullString:self.titleStr]) {
                self.gk_navigationBar.mj_h = 0;
                self.gk_navBarAlpha = 0;
                
                self.tableView.mj_y = self.gk_navigationBar.mj_y;
            }else{
                self.tableView.mj_y = 0;
            }
        }else{//正常状态
            if (![NSString isNullString:self.titleStr]) {
                self.gk_navigationBar.alpha = 1;
                self.gk_navigationBar.mj_h = self.gk_navigationBarHeight;
            }
            self.tableView.mj_y = self.tableViewRect.origin.y;
        }
    } completion:nil];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            switch (self.hotSearchStyle) {
                case HotSearchStyle_1:{
                    return [JobsSearchShowHotwordsTBVCell cellHeightWithModel:nil];
                }break;
                case HotSearchStyle_2:{
                    return [TableViewCell cellHeightWithModel:self.hotSearchMutArr];
                }break;
                    
                default:{
                    return 0;
                }break;
            }
        }break;
        case 1:{
            return [JobsSearchShowHistoryDataTBVCell cellHeightWithModel:nil];
        }break;
        default:
            return 0;
            break;
    }
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    JobsSearchShowHistoryDataTBVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.jobsSearchBar.getTextField.text = cell.textLabel.text;
}

-(NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 1;
        }break;
        case 1:{
            return self.historySearchMutArr.count;
        }break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{/// 热门搜索
            switch (self.hotSearchStyle) {
                case HotSearchStyle_1:{
                    JobsSearchShowHotwordsTBVCell *cell = [JobsSearchShowHotwordsTBVCell cellWithTableView:tableView];
                    cell.indexPath = indexPath;
                    [cell richElementsInCellWithModel:self.hotSearchMutArr];
                    
                    @jobs_weakify(self)
                    /// 点击的哪个btn？
                    [cell actionViewBlock:^(UIButton *data) {
                        @jobs_strongify(self)
                        self.jobsSearchBar.getTextField.text = data.titleLabel.text;
                        self.jobsSearchResultDataListView.alpha = 1;
                    }];
                    return cell;
                }break;
                case HotSearchStyle_2:{
                    TableViewCell *cell = [TableViewCell cellWithTableView:tableView];
                    cell.indexPath = indexPath;
                    [cell richElementsInCellWithModel:self.hotSearchMutArr];
                    return cell;
                }break;
                    
                default:{
                    return UITableViewCell.new;
                }break;
            }
        }break;
        case 1:{/// 搜索历史
            JobsSearchShowHistoryDataTBVCell *cell = [JobsSearchShowHistoryDataTBVCell cellWithTableView:tableView];
            cell.indexPath = indexPath;
            [cell richElementsInCellWithModel:self.historySearchMutArr[indexPath.row]];
            return cell;
        }break;
        default:
            return UITableViewCell.new;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitleMutArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return [JobsSearchTableViewHeaderView viewHeightWithModel:nil];
}

-(UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    JobsSearchTableViewHeaderView *header = [JobsSearchTableViewHeaderView.alloc initWithReuseIdentifier:NSStringFromClass(JobsSearchTableViewHeaderView.class)];
    [header richElementsInViewWithModel:self.sectionTitleMutArr[section]];
    if (section == 1) {
        header.getDelBtn.visible = YES;
        @jobs_weakify(self)
        [header actionViewBlock:^(id data) {
            @jobs_strongify(self)
            [self.view endEditing:YES];
            [self.tableView ww_foldSection:section fold:![self.tableView ww_isSectionFolded:section]];//设置可折叠
            /// 删除历史过往记录
            [self.historySearchMutArr removeAllObjects];
            
            UserDefaultModel *userDefaultModel = UserDefaultModel.new;
            userDefaultModel.key = @"JobsSearchHistoryData";
            userDefaultModel.obj = self.historySearchMutArr;
            
            [NSUserDefaults updateWithModel:userDefaultModel];
            
            if (self.historySearchMutArr.count == 0) {
                [self.sectionTitleMutArr removeAllObjects];
                self->_sectionTitleMutArr = nil;
            }
            
            [self.tableView reloadData];
        }];
    }

    self.scrollViewClass = JobsSearchTableView.class;//这一属性决定UITableViewHeaderFooterView是否悬停
    return header;
    
//    {
//        Class headerClass = self.isHoveringHeaderView ? JobsSearchHoveringHeaderView.class : JobsSearchTableViewHeaderView.class;
//        UIView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerClass)];
//        return header;
//    }

}
/// cell的生命周期:将要出现的cell【实现以下方法,以替换系统默认的右侧小箭头】
/// @param tableView tableView
/// @param cell willDisplayCell
/// @param indexPath forRowAtIndexPath
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.img = KIMG(@"删除");
    @jobs_weakify(self)
    [cell customAccessoryView:^(id data) {
        @jobs_strongify(self)
        JobsSearchShowHistoryDataTBVCell *cell = (JobsSearchShowHistoryDataTBVCell *)data;

        [self.historySearchMutArr removeObjectAtIndex:cell.indexPath.row];

        UserDefaultModel *userDefaultModel = UserDefaultModel.new;
        userDefaultModel.key = @"JobsSearchHistoryData";
        userDefaultModel.obj = self.historySearchMutArr;
        
        [NSUserDefaults updateWithModel:userDefaultModel];
        
        if (self.historySearchMutArr.count == 0) {
            [self.sectionTitleMutArr removeAllObjects];
            self->_sectionTitleMutArr = nil;
        }
        
        [self.tableView reloadData];
    }];
}
#pragma mark —— lazyLoad
-(JobsSearchTableView *)tableView{
    if (!_tableView) {
        _tableView = JobsSearchTableView.new;
        _tableView.backgroundColor = self.bgColour;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.jobsSearchBar;
        _tableView.tableFooterView = UIView.new;
        _tableView.ww_foldable = YES;//设置可折叠
        
        [_tableView registerClass:JobsSearchTableViewHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(JobsSearchTableViewHeaderView.class)];
        
        @jobs_weakify(self)
        [_tableView actionViewBlock:^(id data) {
            @jobs_strongify(self)
            [self.view endEditing:YES];
        }];

        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (self.gk_navBarAlpha &&
                !self.gk_navigationBar.hidden &&
                [NSString isNullString:self.titleStr]) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view);
            }
            make.bottom.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        self.tableViewRect = _tableView.frame;
    }return _tableView;
}

-(JobsSearchBar *)jobsSearchBar{
    if (!_jobsSearchBar) {
        _jobsSearchBar = JobsSearchBar.new;
        _jobsSearchBar.size = [JobsSearchBar viewSizeWithModel:nil];
        [_jobsSearchBar richElementsInViewWithModel:nil];
//        @jobs_weakify(self)
//        [_jobsSearchBar actionViewBlock:^(id data) {
//
//        }];
        
        
//        [_jobsSearchBar actionBlockJobsSearchBar:^(id data,//方法名
//                                                   id data2) {//值
//            NSLog(@"HHH data = %@,data2 = %@",data,data2);
//            if ([data isKindOfClass:NSString.class]) {
//                NSString *str = (NSString *)data;
//                if ([str isEqualToString:@"textFieldShouldEndEditing:"]) {//正常位
//                    NSLog(@"textFieldShouldEndEditing:");
//                    /*
//                     *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
//                     *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
//                     *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
//                     *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
//                     *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
//                     *    dampingRatio 阻尼
//                     *    velocity 速度
//                     */
//                    [UIView animateWithDuration:1
//                                          delay:0
//                         usingSpringWithDamping:1
//                          initialSpringVelocity:20
//                                        options:UIViewAnimationOptionCurveEaseInOut
//                                     animations:^{
//                        @jobs_strongify(self)
//                        self->_jobsSearchBar.textField.frame = CGRectMake(10,
//                                                                   10,
//                                                                   JobsSCREEN_WIDTH - 20,
//                                                                   self->_jobsSearchBar.mj_h - 20);
//                        self->_jobsSearchBar.cancelBtn.frame = CGRectMake(JobsSCREEN_WIDTH - 10,
//                                                                          10,
//                                                                          0,
//                                                                          0);
//                    } completion:^(BOOL finished) {
//
//                    }];
//                }
//                else if([str isEqualToString:@"textFieldShouldBeginEditing:"]){//编辑期
//                    NSLog(@"textFieldShouldBeginEditing:");
//                    /*
//                     *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
//                     *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
//                     *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
//                     *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
//                     *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
//                     *    dampingRatio 阻尼
//                     *    velocity 速度
//                     */
//                    [UIView animateWithDuration:1
//                                          delay:0
//                         usingSpringWithDamping:1
//                          initialSpringVelocity:20
//                                        options:UIViewAnimationOptionCurveEaseInOut
//                                     animations:^{
//                        @jobs_strongify(self)
//                        self->_jobsSearchBar.textField.frame = CGRectMake(10,
//                                                                   10,
//                                                                   JobsSCREEN_WIDTH - 20 - 80 - 10,
//                                                                   self->_jobsSearchBar.mj_h - 20);
//
//                        self->_jobsSearchBar.cancelBtn.frame = CGRectMake(JobsSCREEN_WIDTH - 80 - 10,
//                                                                          10,
//                                                                          80,
//                                                                          self->_jobsSearchBar.mj_h - 20);
//                    } completion:^(BOOL finished) {
//
//                    }];
//                }
//                else if ([str isEqualToString:@"textFieldDidEndEditing:"]){
//                    NSLog(@"textFieldDidEndEditing:");
//                    @jobs_strongify(self)
//                    [self.historySearchMutArr removeAllObjects];
//
//                    NSArray *jobsSearchHistoryDataArr = (NSArray *)[NSUserDefaults readWithKey:@"JobsSearchHistoryData"];
//                    self->_historySearchMutArr = [NSMutableArray arrayWithArray:jobsSearchHistoryDataArr];
//
//                    [self.sectionTitleMutArr removeAllObjects];
//                    self->_sectionTitleMutArr = nil;
//                    [self.tableView reloadData];
//
//                    [self goUpAndDown:YES];
//                }
//                else if ([str isEqualToString:@"cancelBtn"]){//取消按钮点击事件
//                    NSLog(@"cancelBtn");
//                    @jobs_strongify(self)
//                    [self.view endEditing:YES];
//                    [self cancelBtnEvent];
//                    [self deallocJobsSearchResultDataListView];
//                }
//                else if ([str isEqualToString:@"textField:shouldChangeCharactersInRange:replacementString:"]){
//                    NSLog(@"textField:shouldChangeCharactersInRange:replacementString:");
//                    //正向输入的非零字符
//                    //正在编辑ing
//                    if ([data2 isKindOfClass:NSString.class]) {
//                        NSString *text = (NSString *)data2;
//                        [self searchByString:(NSString *)text];
//                    }
//
//                    [self goUpAndDown:YES];
//                }
//                else{}
//            }
//        }];
    }return _jobsSearchBar;
}

-(NSMutableArray<NSString *> *)sectionTitleMutArr{
    if (!_sectionTitleMutArr) {
        _sectionTitleMutArr = NSMutableArray.array;
        [_sectionTitleMutArr addObject:@"热门搜索"];
        if (self.historySearchMutArr.count) {
            [_sectionTitleMutArr addObject:@"搜索历史"];
        }
    }return _sectionTitleMutArr;
}

-(NSMutableArray<NSString *> *)hotSearchMutArr{
    if (!_hotSearchMutArr) {
        _hotSearchMutArr = NSMutableArray.array;
        [_hotSearchMutArr addObject:@"Java"];
        [_hotSearchMutArr addObject:@"Python"];
        [_hotSearchMutArr addObject:@"Objective-C"];
        [_hotSearchMutArr addObject:@"Swift"];
        [_hotSearchMutArr addObject:@"C"];
        [_hotSearchMutArr addObject:@"C++"];
        [_hotSearchMutArr addObject:@"PHP"];
        [_hotSearchMutArr addObject:@"C#"];
        [_hotSearchMutArr addObject:@"Perl"];
        [_hotSearchMutArr addObject:@"Go"];
        [_hotSearchMutArr addObject:@"JavaScript"];
        [_hotSearchMutArr addObject:@"Ruby"];
        [_hotSearchMutArr addObject:@"R"];
        [_hotSearchMutArr addObject:@"MATLAB"];
    }return _hotSearchMutArr;
}

-(NSMutableArray<NSString *> *)historySearchMutArr{
    if (!_historySearchMutArr) {
        NSArray *jobsSearchHistoryDataArr = (NSArray *)[NSUserDefaults readWithKey:@"JobsSearchHistoryData"];
        if (jobsSearchHistoryDataArr) {
            _historySearchMutArr = [NSMutableArray arrayWithArray:jobsSearchHistoryDataArr];
        }else{
            _historySearchMutArr = NSMutableArray.array;
        }
    }return _historySearchMutArr;
}

-(UIButton *)scanBtn{
    if (!_scanBtn) {
        _scanBtn = UIButton.new;
        [_scanBtn normalBackgroundImage:KIMG(@"扫描")];
        BtnClickEvent(_scanBtn, [WHToast toastMsg:@"此功能尚未开发"];);
    }return _scanBtn;
}

-(JobsSearchResultDataListView *)jobsSearchResultDataListView{
    if (!_jobsSearchResultDataListView) {
        _jobsSearchResultDataListView = JobsSearchResultDataListView.new;
        _jobsSearchResultDataListView.backgroundColor = kRedColor;
        @jobs_weakify(self)
        [_jobsSearchResultDataListView actionViewBlock:^(id data) {
            @jobs_strongify(self)

            if ([data isKindOfClass:JobsSearchResultDataListView.class]){//滚动
                NSLog(@"");
            }else if ([data isKindOfClass:NSString.class] &&
                ![NSString isNullString:(NSString *)data]) {
                
                self.jobsSearchBar.getTextField.text = (NSString *)data;//先赋值，最后才存数据
                [self deallocJobsSearchResultDataListView];
                
                [self.view endEditing:YES];//这里结束编辑调用结束完成的协议方法，在此以后才涉及到存历史数据
                
            }else if ([data isKindOfClass:UITapGestureRecognizer.class]) {
                NSLog(@"");
            }else if ([data isKindOfClass:UIScrollView.class]) {//完全停止滚动
                NSLog(@"");
            }else{}
        }];
        
        [self.view addSubview:_jobsSearchResultDataListView];
        [_jobsSearchResultDataListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.jobsSearchBar.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.tableView);
        }];
    }return _jobsSearchResultDataListView;
}

-(UIColor *)bgColour{
    if (!_bgColour) {
        _bgColour = [UIColor colorWithPatternImage:KBuddleIMG(nil, @"Telegram",nil, @"1")];
    }return _bgColour;
}

-(NSMutableArray<NSString *> *)searchResDataMutArr{
    if (!_searchResDataMutArr) {
        _searchResDataMutArr = NSMutableArray.array;
    }return _searchResDataMutArr;
}

@end
