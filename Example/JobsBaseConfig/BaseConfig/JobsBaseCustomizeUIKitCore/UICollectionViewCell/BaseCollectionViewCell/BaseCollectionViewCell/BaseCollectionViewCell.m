//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "BaseCollectionViewCell.h"

@interface BaseCollectionViewCell ()
/// UI
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UITextView *textView;

@end

@implementation BaseCollectionViewCell

@synthesize viewModel = _viewModel;

#pragma mark —— UICollectionViewCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    BaseCollectionViewCell *cell = (BaseCollectionViewCell *)[collectionView collectionViewCellClass:BaseCollectionViewCell.class forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerCollectionViewCellClass:BaseCollectionViewCell.class];
        cell = (JobsHotLabelWithMultiLineCVCell *)[collectionView collectionViewCellClass:BaseCollectionViewCell.class forIndexPath:indexPath];
    }
    
    cell.indexPath = indexPath;
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self richElementsInCellWithModel:nil];
    }return self;
}
#pragma mark —— BaseCellProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeZero;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    /// 如果有图片则只显示这个图片，并铺满
    if (model.bgImage) {
        self.bgImageView.jobsVisible = model.bgImage;
        return;
    }
    /// 如果有文字（普通文本 或者富文本）则只显示这个文字（普通文本 或者富文本），并铺满
    if (model.textModel.text || model.textModel.attributedText) {
        self.textView.jobsVisible = model.textModel.text || model.textModel.attributedText;
        return;
    }
}
#pragma mark —— <UIViewModelProtocol> 协议属性合成set & get方法
@synthesize indexPath = _indexPath;
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(NSIndexPath *)indexPath{
    return _indexPath;
}
@synthesize index = _index;
-(NSInteger)index{
    return _index;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
}
#pragma mark —— lazyLoad
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = UIImageView.new;
        [self.contentView addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    _bgImageView.image = self.viewModel.bgImage;
    return _bgImageView;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = UITextView.new;
        _textView.font = self.viewModel.textModel.font;//notoSansRegular(14);
        _textView.textColor = self.viewModel.textModel.textCor;//HEXCOLOR(0x757575);
        [self.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self layoutIfNeeded];
        NSLog(@"");
    }
//    _textView.attributedText = self.viewModel.textModel.attributedText;
    _textView.text = self.viewModel.textModel.text;
    NSLog(@"textView.text = %@",_textView.text);
    return _textView;
}

@end
