//
//  JobsCVCell.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/16.
//

#import "JobsCVCell.h"

@interface JobsCVCell ()
/// UI
@property(nonatomic,strong)UIButton *btn;

@end

@implementation JobsCVCell

@synthesize viewModel = _viewModel;

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
    [collectionView registerCollectionViewCellClass:JobsCVCell.class];
    JobsCVCell *cell = (JobsCVCell *)[collectionView collectionViewCellClass:JobsCVCell.class forIndexPath:indexPath];
    if (!cell) {
        cell = (JobsCVCell *)[collectionView collectionViewCellClass:JobsCVCell.class forIndexPath:indexPath];
    }
    cell.indexPath = indexPath;
    return cell;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
    self.btn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsWidth(106), JobsWidth(30));
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"");
//}

#pragma mark —— 一些公有方法
-(UIButton *)getBtn{
    return _btn;
}
#pragma mark —— lazyLoad
-(UIButton *)btn{
    if (!_btn) {
        _btn = UIButton.new;
        _btn.enabled = NO;
        [self.contentView addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    _btn.selected = self.viewModel.jobsSelected;
    _btn.normalImage = self.viewModel.image;
    _btn.normalTitleColor = self.viewModel.textModel.textCor ? : JobsBlueColor;
    _btn.backgroundColor = _btn.selected ? (self.viewModel.bgSelectedCor ? : JobsYellowColor) : (self.viewModel.bgCor ? : JobsCyanColor);
    _btn.normalTitle = self.viewModel.textModel.text;
    _btn.titleFont = self.viewModel.textModel.font ? : notoSansRegular(12);
    [_btn layoutButtonWithEdgeInsetsStyle:self.viewModel.buttonEdgeInsetsStyle
                          imageTitleSpace:self.viewModel.imageTitleSpace];
    [_btn cornerCutToCircleWithCornerRadius:self.viewModel.layerCornerRadius ? : JobsWidth(8)];
    
    return _btn;
}

@end
