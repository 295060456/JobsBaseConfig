//
//  JobsWalletVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/7/6.
//

#import "JobsWalletVC.h"

@interface JobsWalletVC ()
/// UI
@property(nonatomic,strong)UICollectionView *collectionView;
/// Data
@property(nonatomic,strong)TMSCollectionViewLayout *tms_layout;
@property(nonatomic,strong)NSMutableArray <NSMutableArray <UIViewModel *>*>*dataSourceMutArr;/// Cell的数据源
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*sectionHeaderDataSource;/// sectionHeader的数据源
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*sectionFooterDataSource;/// sectionFooter的数据源

@end

@implementation JobsWalletVC

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    NSLog(@"%@",JobsLocalFunc);
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
        self.viewModel.textModel.text = Internationalization(@"JobsWallet");
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
    self.gk_navigationBar.jobsVisible = YES;
    [self setGKNav];
    [self setGKNavBackBtn];
    self.view.backgroundColor = JobsOrangeColor;
    self.collectionView.alpha = 1;
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

#pragma mark —— UICollectionViewDelegate,UICollectionViewDataSource
-(CGFloat)collectionView:(UICollectionView *)collectionView
resuableHeaderViewHeightForIndexPath:(NSIndexPath *)indexPath {
//    return indexPath.section == 0 ? 30 : 0;
    if (indexPath.section == self.dataSourceMutArr.count - 1) {
        JobsWidth(45);
    }return JobsWidth(30);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView
resuableFooterViewHeightForIndexPath:(NSIndexPath *)indexPath {
//    return 30;
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSourceMutArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    NSArray *sectionArray = self.dataSourceMutArr[section];
    return sectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataSourceMutArr.count - 1) {
        JobsBtnStyleCVCell *cell = [collectionView collectionViewCellClass:JobsBtnStyleCVCell.class forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataSourceMutArr[indexPath.section][indexPath.item]];
        return cell;
    }else{
        BaiShaETProjBankAccMgmtCVCell *cell = [collectionView collectionViewCellClass:BaiShaETProjBankAccMgmtCVCell.class forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataSourceMutArr[indexPath.section][indexPath.item]];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataSourceMutArr enumerateObjectsUsingBlock:^(NSArray *sectionArray,
                                                        NSUInteger idx,
                                                        BOOL * _Nonnull stop) {
        [sectionArray enumerateObjectsUsingBlock:^(UIViewModel *model,
                                                   NSUInteger idx,
                                                   BOOL * _Nonnull stop) {
            if (indexPath.item != idx) {
                model.jobsSelected = NO;
            } else {
                model.jobsSelected = !model.jobsSelected;
                if (indexPath.item != sectionArray.count - 1) {
                    [self.tms_layout didClickWithIndexPath:indexPath isExpand:model.jobsSelected];
                } else {
                    [self.tms_layout didClickWithIndexPath:indexPath isExpand:NO];
                }
            }
        }];
    }];
    [collectionView reloadData];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    TMSWalletCollectionReusableView *reusableView = nil;
    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(TMSWalletCollectionReusableView.class) forIndexPath:indexPath];
    if (kind == TMSCollectionViewSectionHeader) {

        UIViewModel *viewModel = self.sectionHeaderDataSource[indexPath.section];
        viewModel.textModel.text = [NSString stringWithFormat:@"Section Header:%zd-%zd", indexPath.section, indexPath.item];
        [reusableView richElementsInViewWithModel:viewModel];
    }

    if (kind == TMSCollectionViewSectionFooter) {
        
        UIViewModel *viewModel = self.sectionFooterDataSource[indexPath.section];
        viewModel.textModel.text = [NSString stringWithFormat:@"Section Header:%zd-%zd", indexPath.section, indexPath.item];
        [reusableView richElementsInViewWithModel:viewModel];
        
    }return reusableView;
}
#pragma mark —— lazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:self.tms_layout];
        _collectionView.backgroundColor = JobsClearColor;
        
        {
//            [_collectionView registerCollectionElementKindSectionHeaderClass:TMSWalletCollectionReusableView.class];
//            [_collectionView registerCollectionElementKindSectionFooterClass:TMSWalletCollectionReusableView.class];
//            [_collectionView registerCollectionViewCellClass:TMSWalletCollectionViewCell.class];
            
            [_collectionView registerCollectionViewClass];
            [_collectionView registerCollectionViewCellClass:BaiShaETProjBankAccMgmtCVCell.class];
          
            [_collectionView registerClass:TMSWalletCollectionReusableView.class
                forSupplementaryViewOfKind:TMSCollectionViewSectionHeader
                       withReuseIdentifier:NSStringFromClass(TMSWalletCollectionReusableView.class)];
            [_collectionView registerClass:TMSWalletCollectionReusableView.class
                forSupplementaryViewOfKind:TMSCollectionViewSectionFooter
                       withReuseIdentifier:NSStringFromClass(TMSWalletCollectionReusableView.class)];
        }

        [self dataLinkByCollectionView:_collectionView];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_collectionView];
        [self fullScreenConstraintTargetView:_collectionView topViewOffset:0];
    }return _collectionView;
}

-(TMSCollectionViewLayout *)tms_layout{
    if (!_tms_layout) {
        _tms_layout = TMSCollectionViewLayout.new;
        _tms_layout.padding = 15;
        _tms_layout.layout_delegate = self;
    }return _tms_layout;
}

-(NSMutableArray<NSMutableArray<UIViewModel *> *> *)dataSourceMutArr{
    if (!_dataSourceMutArr) {
        _dataSourceMutArr = NSMutableArray.array;
        {
            NSMutableArray *dataMutArr = NSMutableArray.array;
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"上海银行");
                viewModel.subTextModel.text = Internationalization(@"**** 7895");
                viewModel.image = JobsIMG(@"第一银行");
                [dataMutArr addObject:viewModel];
            }
            
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"国泰世华");
                viewModel.subTextModel.text = Internationalization(@"**** 2345");
                viewModel.image = JobsIMG(@"国泰世华");
                [dataMutArr addObject:viewModel];
            }
            
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"台湾银行");
                viewModel.subTextModel.text = Internationalization(@"**** 7654");
                viewModel.image = JobsIMG(@"台湾银行");
                [dataMutArr addObject:viewModel];
            }
            [_dataSourceMutArr addObject:dataMutArr];
        }
        
        {
            NSMutableArray *dataMutArr = NSMutableArray.array;
            {
                UIViewModel *viewModel = UIViewModel.new;
                viewModel.textModel.text = Internationalization(@"＋添加新的銀行卡");
                viewModel.textModel.font = notoSansRegular(16);
                viewModel.textModel.textCor = HEXCOLOR(0x757575);
                [dataMutArr addObject:viewModel];
            }
            [_dataSourceMutArr addObject:dataMutArr];
        }
    }return _dataSourceMutArr;
}

-(NSMutableArray<UIViewModel *> *)sectionHeaderDataSource{
    if (!_sectionHeaderDataSource) {
        _sectionHeaderDataSource = NSMutableArray.array;
        for (id data in self.dataSourceMutArr) {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.textModel.text = Internationalization(@"我是头部");
            [_sectionHeaderDataSource addObject:viewModel];
        }
    }return _sectionHeaderDataSource;
}

-(NSMutableArray<UIViewModel *> *)sectionFooterDataSource{
    if (!_sectionFooterDataSource) {
        _sectionFooterDataSource = NSMutableArray.array;
        for (id data in self.dataSourceMutArr) {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.textModel.text = Internationalization(@"我是尾部");
            [_sectionFooterDataSource addObject:viewModel];
        }
    }return _sectionFooterDataSource;
}

@end
