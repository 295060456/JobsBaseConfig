//
//  JobsVerticalMenuVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/15.
//

#import "JobsVerticalMenuVC.h"

extern AppDelegate *appDelegate;
@interface JobsVerticalMenuVC ()
/// UI
@property(nonatomic,strong)UITableView *tableView;///  左侧的标题
@property(nonatomic,strong)UICollectionView *collectionView; /// 右侧的内容
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)ThreeClassCell *tempCell;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
/// Data
@property(nonatomic,strong)NSMutableArray *leftDataArray;
@property(nonatomic,strong)NSMutableArray <GoodsClassModel *>*rightDataArray;
@property(nonatomic,strong)GoodsClassModel *currentSelectModel;

@end

@implementation JobsVerticalMenuVC

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
    
    self.viewModel.backBtnTitleModel.text = @"";
    self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
    self.viewModel.textModel.text = Internationalization(@"竖形菜单选择功能");
    self.viewModel.textModel.font = notoSansBold(16);

    self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navigationBar.jobsVisible = YES;
    
    self.editBtn.alpha = 1;
    self.tableView.alpha = 1;
    self.collectionView.alpha = 1;
    [self getLeftData];
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
-(void)getLeftData{
    /// 这里可以调用接口去获取一级目录分类的数据
    for (int i = 0; i < 20; i++){
        [self.leftDataArray addObject:[self createOneModel:i]];
    }
    [self.tableView reloadData];
    if (self.leftDataArray.count > 0){
        @jobs_weakify(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            @jobs_strongify(self)
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath
                                        animated:NO
                                  scrollPosition:UITableViewScrollPositionNone];
            if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
                [self.tableView.delegate tableView:self.tableView
                           didSelectRowAtIndexPath:indexPath];
            }
        });
    }
}
/// 初始化数据
-(int)getRandomNumber:(int)from
                   to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}
/// 预算高度
-(CGFloat)getCellHeight:(NSMutableArray *)dataArray{
    //获取cell 的高度
    return [self.tempCell getCollectionHeight:dataArray];
}
/// 根据一级目录的id 获取二三级的分类数据
-(void)getGoodsClassWithPid:(NSString *)pId{
    [self.rightDataArray removeAllObjects];
    
    GoodsClassModel *model = GoodsClassModel.new;
    model.name = @"banner";
    [self.rightDataArray addObject:model];
    for (int i = 0; i < 10; i++){
        [self.rightDataArray addObject:[self createTwoModel:i]];
    }
    [self.collectionView reloadData];
    if (self.rightDataArray.count){
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionTop
                                            animated:NO];
    }
}

-(GoodsClassModel *)createOneModel:(int)iflag{
    GoodsClassModel *model = GoodsClassModel.new;
    model.idField = [NSString stringWithFormat:@"%d", iflag];
    model.pid = @"0";
    model.name = [NSString stringWithFormat:@"一级目录 %d", iflag];
    return model;
}

-(GoodsClassModel *)createTwoModel:(int)iFlag{
    GoodsClassModel *model = GoodsClassModel.new;
    model.idField = [NSString stringWithFormat:@"%d", iFlag];
    model.pid = [NSString stringWithFormat:@"%d", iFlag];
    model.name = [NSString stringWithFormat:@"随机-%d", iFlag];
    NSMutableArray *arr = NSMutableArray.array;
    int end = [self getRandomNumber:3 to:9];
    for (int i = 0; i < end; i++){
        [arr addObject:[self createThreeModel:i]];
    }
    model.childrenList = arr;
    return model;
}

-(GoodsClassModel *)createThreeModel:(int)iflag{
    GoodsClassModel *model = GoodsClassModel.new;
    model.idField = [NSString stringWithFormat:@"%d", iflag];
    model.pid = [NSString stringWithFormat:@"%d", iflag];
    model.name = [NSString stringWithFormat:@"三级目录 %d", iflag];
    return model;
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return self.leftDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftCell *cell = [LeftCell cellWithTableView:tableView];
    
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.textModel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    [cell richElementsInCellWithModel:viewModel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LeftCell cellHeightWithModel:nil];
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    GoodsClassModel *model = [self.leftDataArray objectAtIndex:indexPath.row];
    self.currentSelectModel = model;
    [self getGoodsClassWithPid:model.idField];
}
#pragma mark —— UICollectionViewDelegate,UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    id model = [self.rightDataArray objectAtIndex:indexPath.section];
    if ([model isKindOfClass:NSString.class]){
        ThreeTopBannerCell *cell = [ThreeTopBannerCell cellWithCollectionView:collectionView forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.currentSelectModel];
        return cell;
    }else{ //goodsclassmodel
        ThreeClassCell *cell = [ThreeClassCell cellWithCollectionView:collectionView forIndexPath:indexPath];
        
        GoodsClassModel *model = [self.rightDataArray objectAtIndex:indexPath.section];
        [cell getCollectionHeight:(NSMutableArray *)model.childrenList];
        [cell richElementsInCellWithModel:nil];
        [cell reloadData];
        @jobs_weakify(self)
        [cell actionObjectBlock:^(GoodsClassModel *model) {
            @jobs_strongify(self)
            NSLog(@"pid : %@", self.currentSelectModel.idField);
            NSLog(@"选中id : %@", model.idField);
        }];return cell;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.rightDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *headerView = [collectionView UICollectionElementKindSectionHeaderClass:UICollectionReusableView.class
                                                                                            forIndexPath:indexPath];
        UILabel *label = [headerView viewWithTag:666];
        if (!label){
            label = UILabel.new;
            label.frame = CGRectMake(10,
                                     20,
                                     headerView.width - 20.f,
                                     17.f);
            label.font = [UIFont systemFontOfSize:12.f];
            label.textColor = UIColor.grayColor;
            label.tag = 666;
            [headerView addSubview:label];
        }
        
        GoodsClassModel *rightModel = [self.rightDataArray objectAtIndex:indexPath.section];
        label.text = rightModel.name ? : @"";
        
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        // 底部视图
        UICollectionReusableView *footView = [collectionView UICollectionElementKindSectionFooterClass:UICollectionReusableView.class
                                                                                          forIndexPath:indexPath];
        return footView;
    }return nil;
}

- (CGSize)collectionView:(UICollectionView*)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    return section ? CGSizeMake(self.collectionView.width, 40.f) : CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    return section == self.rightDataArray.count ? CGSizeMake(CGRectGetWidth(self.collectionView.frame), 40.f) : CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    /// 比例是 宽高 53:18
    return indexPath.section ? CGSizeMake(self.collectionView.width, [self getCellHeight:(NSMutableArray *)[self.rightDataArray objectAtIndex:indexPath.section].childrenList]) : CGSizeMake(self.collectionView.width, ((self.collectionView.width - 20) * 18.f / 53.f ) + ThreeTopBannerCell_addHeight);
}
#pragma mark —— lazyLoad
-(UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = UIButton.new;
        _editBtn.backgroundColor = UIColor.yellowColor;
        _editBtn.normalTitle = Internationalization(@"编辑");
        _editBtn.normalTitleColor = HEXCOLOR(0xB0B0B0);
        _editBtn.titleFont = notoSansRegular(12);
        _editBtn.normalImage = KIMG(@"编辑");
        [_editBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:JobsWidth(5.75)];
        BtnClickEvent(_editBtn, {
            toast(Internationalization(@"编辑"));
        })
        [self.view addSubview:_editBtn];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-JobsTabBarHeight(appDelegate.tabBarVC));
            make.size.mas_equalTo(CGSizeMake(TableViewHeight, EditBtnHeight));
        }];
    }return _editBtn;
}

-(UITableView *)tableView{
    if (!_tableView){
        _tableView = UITableView.initWithStylePlain;
        _tableView.backgroundColor = UIColor.redColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0,
                                      JobsTopSafeAreaHeight() + JobsStatusBarHeight(),
                                      TableViewHeight,
                                      JobsMainScreen_HEIGHT() - JobsTopSafeAreaHeight() - JobsStatusBarHeight() - JobsTabBarHeight(appDelegate.tabBarVC) - EditBtnHeight);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }return _tableView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = UICollectionViewFlowLayout.new;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }return _flowLayout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView){
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectMake(self.tableView.right,
                                                                           self.tableView.top,
                                                                           JobsMainScreen_WIDTH() - self.tableView.width,
                                                                           self.tableView.height + EditBtnHeight)
                                           collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColor.blueColor;
        _collectionView.alwaysBounceVertical = YES;

        [_collectionView registerCollectionViewCellClass:ThreeTopBannerCell.class];
        [_collectionView registerCollectionViewCellClass:ThreeClassCell.class];
        [_collectionView registerCollectionElementKindSectionHeaderClass:UICollectionReusableView.class];
        [_collectionView registerCollectionElementKindSectionFooterClass:UICollectionReusableView.class];
        
        [self.view addSubview:_collectionView];
    }return _collectionView;
}

-(ThreeClassCell *)tempCell{
    if (!_tempCell){
        _tempCell = ThreeClassCell.new;
        _tempCell.frame = CGRectMake(0,
                                     0,
                                     [ThreeClassCell cellSizeWithModel:nil].width,
                                     [ThreeClassCell cellSizeWithModel:nil].height);
    }return _tempCell;
}

-(NSMutableArray *)leftDataArray{
    if (!_leftDataArray) {
        _leftDataArray = NSMutableArray.array;
    }return _leftDataArray;
}

-(NSMutableArray<GoodsClassModel *> *)rightDataArray{
    if (!_rightDataArray) {
        _rightDataArray = NSMutableArray.array;
    }return _rightDataArray;
}

@end
