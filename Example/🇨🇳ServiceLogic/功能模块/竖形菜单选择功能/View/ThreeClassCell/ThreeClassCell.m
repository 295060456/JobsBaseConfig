//
//  ThreeClassCell.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/15.
//

#import "ThreeClassCell.h"

@interface ThreeClassCell()

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)CGFloat sectionInsetTop;
@property(nonatomic,assign)CGFloat sectionInsetLeft;
@property(nonatomic,assign)CGFloat sectionInsetBottom;
@property(nonatomic,assign)CGFloat sectionInsetRight;
@property(nonatomic,assign)CGFloat minimumLineSpacing;/// 上下行间距
@property(nonatomic,assign)CGFloat minimumInteritemSpacing;/// 左右列间距
@property(nonatomic,strong)NSMutableArray *dataArray;/// 总共有多少个cell
@property(nonatomic,assign)CGFloat itemHeight;/// 一个cell 的高度
@property(nonatomic,assign)NSInteger columns;/// 一行有多少列
@property(nonatomic,assign)NSInteger rowCount;/// 一共有都是行

@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@end

@implementation ThreeClassCell

#pragma mark —— JobsDoorInputViewProtocol
-(UIViewModel *_Nullable)getViewModel{
    return self.viewModel;
}
#pragma mark —— BaseCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    ThreeClassCell *cell = (ThreeClassCell *)[collectionView collectionViewCellClass:ThreeClassCell.class forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerCollectionViewCellClass:ThreeClassCell.class];
        cell = (ThreeClassCell *)[collectionView collectionViewCellClass:ThreeClassCell.class forIndexPath:indexPath];
    }
    
    cell.indexPath = indexPath;
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.columns = 3;
        [self richElementsInCellWithModel:nil];
    }return self;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
    
    self.sectionInsetTop = 15.f;
    self.sectionInsetLeft = 15.f;
    self.sectionInsetBottom = 15.f;
    self.sectionInsetRight = 15.f;
    self.minimumLineSpacing = 15.f;
    self.minimumInteritemSpacing = 15.f;
    self.itemHeight = TreeClassItemCell_Height;

    [self.contentView addSubview:self.collectionView];
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsMainScreen_WIDTH() - TableViewHeight, JobsWidth(1000));
}
#pragma mark —— 一些公有方法
-(CGFloat)getCollectionHeight:(NSMutableArray *)dataArray{
    self.dataArray = dataArray;
    NSInteger a = self.dataArray.count % self.columns;
    self.rowCount = a ? (self.dataArray.count / self.columns) + 1 : self.dataArray.count / self.columns;
    CGFloat collectionHeight = (self.rowCount * self.itemHeight) + ((self.rowCount - 1) * self.minimumLineSpacing) + self.sectionInsetTop + self.sectionInsetBottom;
    self.collectionView.height = collectionHeight;
    return collectionHeight;
}

-(void)reloadData{
    [self.collectionView reloadData];
}
#pragma mark —— lazyLoad
-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = UICollectionViewFlowLayout.new;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = self.minimumInteritemSpacing;
        _flowLayout.minimumLineSpacing = self.minimumLineSpacing;
        _flowLayout.sectionInset = UIEdgeInsetsMake(self.sectionInsetTop,
                                                    self.sectionInsetLeft,
                                                    self.sectionInsetBottom,
                                                    self.sectionInsetRight);
    }return _flowLayout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView){
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectMake(10,
                                                                           0,
                                                                           self.frame.size.width - 20.f,
                                                                           self.frame.size.height)
                                           collectionViewLayout:self.flowLayout];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.layer.backgroundColor = UIColor.whiteColor.CGColor;
        _collectionView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.08].CGColor;
        _collectionView.layer.shadowOffset = CGSizeMake(0, 0);
        _collectionView.layer.shadowOpacity = 1;
        _collectionView.layer.shadowRadius = 5;
        _collectionView.layer.masksToBounds = NO;

        self.flowLayout.itemSize = CGSizeMake((_collectionView.width - self.sectionInsetLeft - self.sectionInsetRight - ((self.columns - 1) * self.minimumInteritemSpacing)) / self.columns,
                                              self.itemHeight);

        [_collectionView registerCollectionViewCellClass:TreeClassItemCell.class];
    }return _collectionView;
}
#pragma mark —— UICollectionViewDelegate,UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TreeClassItemCell *cell = [TreeClassItemCell cellWithCollectionView:self.collectionView forIndexPath:indexPath];
    GoodsClassModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell richElementsInCellWithModel:model];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.objectBlock) self.objectBlock([self.dataArray objectAtIndex:indexPath.row]);
}

@end
