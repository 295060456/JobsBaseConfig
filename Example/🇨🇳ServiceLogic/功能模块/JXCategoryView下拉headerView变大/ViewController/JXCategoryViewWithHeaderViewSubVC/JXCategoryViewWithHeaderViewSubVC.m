//
//  JXCategoryViewWithHeaderViewVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/10.
//

#import "JXCategoryViewWithHeaderViewVC.h"

@interface JXCategoryViewWithHeaderViewSubVC (){
    BaiShaETProjVIPSubCVCell_01 *cell01;
    BaiShaETProjVIPSubCVCell_02 *cell02;
    BaiShaETProjVIPSubCVCell_03 *cell03;
    BaiShaETProjVIPSubCVCell_04 *cell04;
    BaiShaETProjVIPSubCVCell_05 *cell05;
}
/// UI
@property(nonatomic,strong)BaiShaETProjChoiceStadiumView *choiceStadiumView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;
// Data
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*dataMutArr;
@property(nonatomic,strong)NSMutableArray <NSMutableArray <UICollectionViewCell *>*>*cvcellMutArr;

@end

@implementation JXCategoryViewWithHeaderViewSubVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    //    [NSNotificationCenter.defaultCenter removeObserver:self];
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
        self.viewModel.textModel.text = Internationalization(@"");
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
    
    self.view.backgroundColor = JobsRandomColor;
    
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navigationBar.jobsVisible = NO;
    
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    self.popupParameter.dragEnable = YES;
    self.popupParameter.disuseBackgroundTouchHide = NO;
    [self.choiceStadiumView tf_showSlide:self.view
                               direction:PopupDirectionBottom
                              popupParam:self.popupParameter];
}
/// 部署策略
-(UICollectionViewCell *)planAtIndexPath:(nonnull NSIndexPath *)indexPath
                                  block1:(JobsReturnIDByVoidBlock)block1
                                  block2:(JobsReturnIDByVoidBlock)block2
                                  block3:(JobsReturnIDByVoidBlock)block3
                                  block4:(JobsReturnIDByVoidBlock)block4
                                  block5:(JobsReturnIDByVoidBlock)block5{
    if (indexPath.section == 0) {
        if (block1) return block1();
    }else if (indexPath.section == 1){
        if (block2) return block2();
    }else if(indexPath.section == 2){
        if (block3) return block3();
    }else if(indexPath.section == 3) {
        if (block4) return block4();
    }else{
        if (block5) return block5();
    }return nil;
}

-(CGSize)planSizeAtIndexPath:(nonnull NSIndexPath *)indexPath
                      block1:(JobsReturnCGSizeByVoidBlock)block1
                      block2:(JobsReturnCGSizeByVoidBlock)block2
                      block3:(JobsReturnCGSizeByVoidBlock)block3
                      block4:(JobsReturnCGSizeByVoidBlock)block4
                      block5:(JobsReturnCGSizeByVoidBlock)block5{
    if (indexPath.section == 0) {
        if (block1) return block1();
    }else if(indexPath.section == 1){
        if (block2) return block2();
    }else if(indexPath.section == 2){
        if (block3) return block3();
    }else if(indexPath.section == 3){
        if (block4) return block4();
    }else{
        if (block5) return block5();
    }return CGSizeZero;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.cvcellMutArr.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    @jobs_weakify(self)
    return [self planAtIndexPath:indexPath
                          block1:^{
        @jobs_strongify(self)
        self->cell01 = (BaiShaETProjVIPSubCVCell_01 *)self.cvcellMutArr[indexPath.section][indexPath.item];
        [self->cell01 richElementsInCellWithModel:nil];
        return self->cell01;
    }block2:^{
        @jobs_strongify(self)
        self->cell02 = (BaiShaETProjVIPSubCVCell_02 *)self.cvcellMutArr[indexPath.section][indexPath.item];
        [self->cell02 richElementsInCellWithModel:nil];
        return self->cell02;
    }block3:^{
        @jobs_strongify(self)
        self->cell03 = (BaiShaETProjVIPSubCVCell_03 *)self.cvcellMutArr[indexPath.section][indexPath.item];
        [self->cell03 richElementsInCellWithModel:nil];
        return self->cell03;
    }block4:^{
        @jobs_strongify(self)
        self->cell04 = (BaiShaETProjVIPSubCVCell_04 *)self.cvcellMutArr[indexPath.section][indexPath.item];
        [self->cell04 richElementsInCellWithModel:nil];
        return self->cell04;
    }block5:^id{
        @jobs_strongify(self)
        self->cell05 = (BaiShaETProjVIPSubCVCell_05 *)self.cvcellMutArr[indexPath.section][indexPath.item];
        [self->cell05 richElementsInCellWithModel:nil];
        return self->cell05;
    }];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.cvcellMutArr[section].count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind.isEqualToString(UICollectionElementKindSectionFooter)) {
        if (indexPath.section == self.cvcellMutArr.count - 1) {
            BaiShaETProjVIPSubCVFooterView *footerView = [collectionView UICollectionElementKindSectionFooterClass:BaiShaETProjVIPSubCVFooterView.class
                                                                                                      forIndexPath:indexPath];
            
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.textModel.text = Internationalization(@"查看VIP規則");
            
            [footerView richElementsInViewWithModel:viewModel];
            
            return footerView;
        }else return nil;
    }else{
        BaseCollectionReusableView *collectionReusableView = [collectionView UICollectionElementKindSectionHeaderClass:BaseCollectionReusableView.class
                                                                                                          forIndexPath:indexPath];
        
        return collectionReusableView;
    }
}
#pragma mark —— UICollectionViewDelegate
/// 允许选中时，高亮
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
/// 高亮完成后回调
-(void)collectionView:(UICollectionView *)collectionView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
/// 由高亮转成非高亮完成时的回调
-(void)collectionView:(UICollectionView *)collectionView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
/// 设置是否允许选中
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
/// 设置是否允许取消选中
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
/// 选中操作
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
/// 取消选中操作
-(void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
#pragma mark —— UICollectionViewDelegateFlowLayout
/// Footer 大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    if (section == self.cvcellMutArr.count - 1) {
        return [BaiShaETProjVIPSubCVFooterView collectionReusableViewSizeWithModel:nil];
    }else return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self planSizeAtIndexPath:indexPath
                              block1:^CGSize{
        return [BaiShaETProjVIPSubCVCell_01 cellSizeWithModel:nil];
    }block2:^CGSize{
        return [BaiShaETProjVIPSubCVCell_02 cellSizeWithModel:nil];
    }block3:^CGSize{
        return [BaiShaETProjVIPSubCVCell_03 cellSizeWithModel:nil];
    }block4:^CGSize{
        return [BaiShaETProjVIPSubCVCell_04 cellSizeWithModel:nil];
    }block5:^CGSize{
        return [BaiShaETProjVIPSubCVCell_05 cellSizeWithModel:nil];
    }];
}
/// 定义的是元素垂直之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return JobsWidth(12);
    }return 0;
}
/// 定义的是元素水平之间的间距。Api自动计算一行的Cell个数，只有当间距小于此定义的最小值时才会换行，最小执行单元是Section（每个section里面的样式是统一的）
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return JobsWidth(15);
    }return 0;
}
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return jobsSameEdgeInset(JobsWidth(8));
}
#pragma mark —— lazyLoad
-(BaiShaETProjChoiceStadiumView *)choiceStadiumView{
    if (!_choiceStadiumView) {
        _choiceStadiumView = BaiShaETProjChoiceStadiumView.new;
        _choiceStadiumView.size = [BaiShaETProjChoiceStadiumView viewSizeWithModel:nil];
        [_choiceStadiumView richElementsInViewWithModel:nil];
    }return _choiceStadiumView;
}

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = UICollectionViewFlowLayout.new;
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }return _layout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero
                                           collectionViewLayout:self.layout];
        _collectionView.backgroundColor = RGB_SAMECOLOR(246);
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, JobsBottomSafeAreaHeight() + JobsTabBarHeight(nil), 0);
        [self dataLinkByCollectionView:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerCollectionViewClass];
        [self.scrollView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _collectionView;
}

-(NSMutableArray <NSMutableArray<UICollectionViewCell *>*>*)cvcellMutArr{
    if (!_cvcellMutArr) {
        _cvcellMutArr = NSMutableArray.array;

        {
            NSMutableArray <UICollectionViewCell *>*mutArr = NSMutableArray.array;
            [mutArr addObject:[BaiShaETProjVIPSubCVCell_01 cellWithCollectionView:self.collectionView forIndexPath:[self myIndexPath:(JobsIndexPath){0,0}]]];
            [_cvcellMutArr addObject:mutArr];
        }
        
        {
            NSMutableArray <UICollectionViewCell *>*mutArr = NSMutableArray.array;
            for (int i = 0; i < 6; i++) {
                [mutArr addObject:[BaiShaETProjVIPSubCVCell_02 cellWithCollectionView:self.collectionView forIndexPath:[self myIndexPath:(JobsIndexPath){1,i}]]];
            }
            [_cvcellMutArr addObject:mutArr];
        }
        
        {
            NSMutableArray <UICollectionViewCell *>*mutArr = NSMutableArray.array;
            [mutArr addObject:[BaiShaETProjVIPSubCVCell_03 cellWithCollectionView:self.collectionView forIndexPath:[self myIndexPath:(JobsIndexPath){2,0}]]];
            [_cvcellMutArr addObject:mutArr];
        }
        
        {
            NSMutableArray <UICollectionViewCell *>*mutArr = NSMutableArray.array;
            [mutArr addObject:[BaiShaETProjVIPSubCVCell_04 cellWithCollectionView:self.collectionView forIndexPath:[self myIndexPath:(JobsIndexPath){3,0}]]];
            [_cvcellMutArr addObject:mutArr];
        }
        
        {
            NSMutableArray <UICollectionViewCell *>*mutArr = NSMutableArray.array;
            [mutArr addObject:[BaiShaETProjVIPSubCVCell_05 cellWithCollectionView:self.collectionView forIndexPath:[self myIndexPath:(JobsIndexPath){4,0}]]];
            [_cvcellMutArr addObject:mutArr];
        }
        
    }return _cvcellMutArr;
}

-(NSMutableArray<UIViewModel *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
    }return _dataMutArr;
}

@end
