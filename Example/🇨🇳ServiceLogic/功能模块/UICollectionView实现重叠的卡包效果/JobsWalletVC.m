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
@property(nonatomic,strong)NSMutableArray <NSMutableArray <UIViewModel *>*>*dataSource;

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

    self.viewModel.backBtnTitleModel.text = @"";
    self.viewModel.textModel.text = Internationalization(@"JobsWallet");

    self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.jobsVisible = YES;
    [self setGKNav];
    [self setGKNavBackBtn];
    self.view.backgroundColor = JobsOrangeColor;

    self.collectionView.alpha = 1;

    [self handleDatas];
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
-(void)handleDatas{
    for (NSInteger i = 0; i < 2; i ++) {
        NSMutableArray *tempDataSource = NSMutableArray.array;
        NSInteger maxCount = i == 0 ? 20 : 6;
        for (NSInteger j = 0 ; j < maxCount; j++) {
            UIViewModel *model = UIViewModel.new;
            [tempDataSource addObject:model];
        }
        [self.dataSource addObject:tempDataSource.copy];
    }
    [self.collectionView reloadData];
}
#pragma mark —— UICollectionViewDelegate,UICollectionViewDataSource
-(CGFloat)collectionView:(UICollectionView *)collectionView
resuableHeaderViewHeightForIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 30 : 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView
resuableFooterViewHeightForIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    NSArray *sectionArray = self.dataSource[section];
    return sectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TMSWalletCollectionViewCell *cell = [collectionView collectionViewCellClass:TMSWalletCollectionViewCell.class forIndexPath:indexPath];
    [cell richElementsInViewWithModel:self.dataSource[indexPath.section][indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataSource enumerateObjectsUsingBlock:^(NSArray *sectionArray,
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
        [reusableView setReusableViewTitle:[NSString stringWithFormat:@"Section Header:%zd-%zd", indexPath.section, indexPath.item]];
    }

    if (kind == TMSCollectionViewSectionFooter) {
        [reusableView setReusableViewTitle:[NSString stringWithFormat:@"Section Footer:%zd-%zd", indexPath.section, indexPath.item]];
    }return reusableView;
}
#pragma mark —— lazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:self.tms_layout];
        _collectionView.backgroundColor = JobsClearColor;
        
//        [_collectionView registerCollectionViewClass];
//        [_collectionView registerCollectionElementKindSectionHeaderClass:TMSWalletCollectionReusableView.class];
//        [_collectionView registerCollectionElementKindSectionFooterClass:TMSWalletCollectionReusableView.class];
        [_collectionView registerCollectionViewCellClass:TMSWalletCollectionViewCell.class];
        [_collectionView registerClass:TMSWalletCollectionReusableView.class
            forSupplementaryViewOfKind:TMSCollectionViewSectionHeader
                   withReuseIdentifier:NSStringFromClass(TMSWalletCollectionReusableView.class)];
        [_collectionView registerClass:TMSWalletCollectionReusableView.class
            forSupplementaryViewOfKind:TMSCollectionViewSectionFooter
                   withReuseIdentifier:NSStringFromClass(TMSWalletCollectionReusableView.class)];

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

-(NSMutableArray<NSMutableArray<UIViewModel *> *> *)dataSource{
    if (!_dataSource) {
        _dataSource = NSMutableArray.array;
    }return _dataSource;
}

@end
