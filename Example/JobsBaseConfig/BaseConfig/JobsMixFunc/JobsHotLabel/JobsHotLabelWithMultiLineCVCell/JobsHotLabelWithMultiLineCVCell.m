//
//  JobsHotLabelWithMultiLineCVCell.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/15.
//

#import "JobsHotLabelWithMultiLineCVCell.h"

@interface JobsHotLabelWithMultiLineCVCell ()

@property(nonatomic,strong)UILabel *textLab;

@end

@implementation JobsHotLabelWithMultiLineCVCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }return self;
}
#pragma mark —— JobsDoorInputViewProtocol
-(UIViewModel *_Nullable)getViewModel{
    return self.viewModel;
}
#pragma mark —— BaseCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    JobsHotLabelWithMultiLineCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier(self.class)
                                                                             forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerClass:self.class
           forCellWithReuseIdentifier:reuseIdentifier(self.class)];
        [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier(self.class)
                                                  forIndexPath:indexPath];
    }
    
    cell.indexPath = indexPath;
    return cell;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    [_textLab removeFromSuperview];
    _textLab = nil;
    self.viewModel = model;
    if (self.viewModel) {
        self.textLab.alpha = 1;
    }
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(UIViewModel *_Nullable)model{
    return [UILabel sizeWithText:model.textModel.text
                            font:model.textModel.font
                         maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}
#pragma mark —— lazyLoad
-(UILabel *)textLab{
    if (!_textLab) {
        _textLab = UILabel.new;
        _textLab.backgroundColor = self.viewModel.bgCor;
        _textLab.textColor = self.viewModel.textModel.textCor;
        _textLab.textAlignment = NSTextAlignmentCenter;
        _textLab.text = self.viewModel.textModel.text;
        [self.contentView addSubview:_textLab];
        [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _textLab;
}

@end
