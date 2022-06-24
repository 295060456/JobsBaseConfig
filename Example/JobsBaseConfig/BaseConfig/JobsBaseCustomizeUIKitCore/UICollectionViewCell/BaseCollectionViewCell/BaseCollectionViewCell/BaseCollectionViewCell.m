//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "BaseCollectionViewCell.h"

@interface BaseCollectionViewCell ()
/// UI
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *bgBtn;

@end

@implementation BaseCollectionViewCell

@synthesize viewModel = _viewModel;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self richElementsInCellWithModel:nil];
    }return self;
}
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

-(UITextView *)getTextView{
    return self.textView;
}

-(UIButton *)getBgBtn{
    return self.bgBtn;
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
    BOOL A = model.bgImage || model.image;
    BOOL B = (![model.textModel.text isEqualToString:Internationalization(TextModelDataString)] && model.textModel.text) || model.textModel.attributedText;

    if (A) {
        self.bgBtn.jobsVisible = A;
        return;
    }
    /// 如果有文字（普通文本 或者富文本）则只显示这个文字（普通文本 或者富文本），并铺满
    if (B) {
        self.textView.jobsVisible = B;
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
-(UIButton *)bgBtn{
    if (!_bgBtn) {
        _bgBtn = UIButton.new;
        _bgBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:_bgBtn];
        [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    _bgBtn.normalImage = self.viewModel.image;
    _bgBtn.normalTitle = self.viewModel.textModel.text;
    _bgBtn.normalBackgroundImage = self.viewModel.bgImage;
    _bgBtn.normalAttributedTitle = self.viewModel.textModel.attributedText;
    _bgBtn.normalTitleColor = self.viewModel.textModel.textCor;
    
    _bgBtn.selectedImage = self.viewModel.selectedImage;
    _bgBtn.selectedTitle = self.viewModel.textModel.selectedText;
    _bgBtn.selectedBackgroundImage = self.viewModel.bgSelectedImage;
    _bgBtn.selectedAttributedTitle = self.viewModel.textModel.selectedAttributedText;
    _bgBtn.selectedTitleColor = self.viewModel.textModel.selectedTextCor;
    
    _bgBtn.titleFont = self.viewModel.textModel.font;
    _bgBtn.titleAlignment = self.viewModel.textModel.textAlignment;
//        _bgBtn.makeNewLineShows = self.viewModel.textModel.lineBreakMode;
    [_bgBtn layoutButtonWithEdgeInsetsStyle:self.viewModel.buttonEdgeInsetsStyle
                            imageTitleSpace:self.viewModel.imageTitleSpace];
    return _bgBtn;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = UITextView.new;
        _textView.font = self.viewModel.textModel.font;
        _textView.textColor = self.viewModel.textModel.textCor;
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
