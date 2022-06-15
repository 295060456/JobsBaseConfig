//
//  TreeClassItemCell.m
//  MPMALL
//
//  Created by xixi_wen on 2019/7/5.
//  Copyright © 2019 panduola. All rights reserved.
//

#import "TreeClassItemCell.h"

@interface TreeClassItemCell ()

@property(nonatomic,assign)CGFloat imageWidth;

@end

@implementation TreeClassItemCell
#pragma mark —— UILocationProtocol
UILocationProtocol_synthesize
@synthesize viewModel = _viewModel;

#pragma mark —— JobsDoorInputViewProtocol
-(UIViewModel *_Nullable)getViewModel{
    return self.viewModel;
}
#pragma mark —— BaseCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    TreeClassItemCell *cell = (TreeClassItemCell *)[collectionView collectionViewCellClass:TreeClassItemCell.class forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerCollectionViewCellClass:TreeClassItemCell.class];
        cell = (TreeClassItemCell *)[collectionView collectionViewCellClass:TreeClassItemCell.class forIndexPath:indexPath];
    }
    cell.indexPath = indexPath;
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.jobsRect = frame;
        self.logoImgView.alpha = 1;
        self.nameLabel.alpha = 1;
    }return self;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsWidth(343), JobsWidth(160));
}
#pragma mark —— lazyLoad
-(CGFloat)imageWidth{
    CGFloat imageWidth = 68.f;
    if (self.jobsRect.size.width < imageWidth){
        imageWidth = self.jobsRect.size.width;
    }return imageWidth;
}

-(UIImageView *)logoImgView{
    if (!_logoImgView) {
        _logoImgView = UIImageView.new;
        _logoImgView.size = CGSizeMake(self.imageWidth, self.imageWidth);
        _logoImgView.top = 0;
        _logoImgView.left = (self.jobsRect.size.width - self.imageWidth) / 2.f;
        _logoImgView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImgView.clipsToBounds = YES;
        _logoImgView.backgroundColor = RandomColor;
        [self.contentView addSubview:_logoImgView];
    }return _logoImgView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = UILabel.new;
        _nameLabel.frame = CGRectMake(0, self.logoImgView.bottom + 5.f, self.jobsRect.size.width, 17.f);
        _nameLabel.textAlignment= NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:12.f];
        _nameLabel.textColor = [UIColor blueColor];
        _nameLabel.text = @"口红";
        [self.contentView addSubview:_nameLabel];
    }return _nameLabel;
}

@end
