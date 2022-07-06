//
//  TMSWalletCollectionViewCell.m
//  TMSWalletCollectionViewLayout
//
//  Created by TmmmS on 2019/8/8.
//  Copyright © 2019 TMS. All rights reserved.
//

#import "TMSWalletCollectionViewCell.h"

@interface TMSWalletCollectionViewCell ()
/// UI
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)TMSWalletModel *walletModel;

@end

@implementation TMSWalletCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = JobsWhiteColor;
        self.contentView.backgroundColor = RandomColor;
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
    }return self;
}
#pragma mark —— BaseCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    [collectionView registerCollectionViewCellClass:TMSWalletCollectionViewCell.class];
    TMSWalletCollectionViewCell *cell = (TMSWalletCollectionViewCell *)[collectionView collectionViewCellClass:TMSWalletCollectionViewCell.class forIndexPath:indexPath];
    if (!cell) {
        cell = (TMSWalletCollectionViewCell *)[collectionView collectionViewCellClass:TMSWalletCollectionViewCell.class forIndexPath:indexPath];
    }
    cell.indexPath = indexPath;
    return cell;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(TMSWalletModel *_Nullable)model{
    self.walletModel = model ? : TMSWalletModel.new;
    self.titleLabel.alpha = 1;
}
#pragma mark —— lazyLoad
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.font = UIFontWeightRegularSize(15);
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(20);
        }];
    }
    _titleLabel.text = [NSString stringWithFormat:@"indexPath:%zd--%zd selected:%@", self.indexPath.section, self.indexPath.row , self.walletModel.isSelected ? @"YES" : @"NO"];
    return _titleLabel;
}

@end

@implementation TMSWalletModel

@end
