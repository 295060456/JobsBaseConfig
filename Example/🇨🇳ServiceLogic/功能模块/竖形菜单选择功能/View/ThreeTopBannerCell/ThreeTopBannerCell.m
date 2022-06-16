//
//  ThreeTopBannerCell.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/15.
//

#import "ThreeTopBannerCell.h"

@interface ThreeTopBannerCell()

@property(nonatomic,strong)UIImageView *imgView;

@end

@implementation ThreeTopBannerCell
#pragma mark —— UILocationProtocol
UILocationProtocol_synthesize

#pragma mark —— JobsDoorInputViewProtocol
-(UIViewModel *_Nullable)getViewModel{
    return self.viewModel;
}
#pragma mark —— BaseCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    ThreeTopBannerCell *cell = (ThreeTopBannerCell *)[collectionView collectionViewCellClass:ThreeTopBannerCell.class forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerCollectionViewCellClass:ThreeTopBannerCell.class];
        cell = (ThreeTopBannerCell *)[collectionView collectionViewCellClass:ThreeTopBannerCell.class forIndexPath:indexPath];
    }
    
    cell.indexPath = indexPath;
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.jobsRect = frame;
    }return self;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
    self.imgView.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsWidth(343), JobsWidth(160));
}
#pragma mark —— lazyLoad
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = UIImageView.new;
        _imgView.image = KIMG(@"滚动广告的临时占位图");
        _imgView.frame = CGRectMake(10,
                                    ThreeTopBannerCell_addHeight,
                                    self.jobsRect.size.width - 20,
                                    self.jobsRect.size.height - ThreeTopBannerCell_addHeight);
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.backgroundColor = [UIColor orangeColor];
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
    }return _imgView;
}

@end
