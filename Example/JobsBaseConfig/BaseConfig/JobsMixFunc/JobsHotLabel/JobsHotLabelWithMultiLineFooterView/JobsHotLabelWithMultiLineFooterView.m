//
//  JobsHotLabelWithMultiLineFooterView.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/25.
//

#import "JobsHotLabelWithMultiLineFooterView.h"

@interface JobsHotLabelWithMultiLineFooterView ()

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation JobsHotLabelWithMultiLineFooterView

@synthesize viewModel = _viewModel;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}
//由具体的子类进行覆写
+(CGSize)viewSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeZero;
}
//由具体的子类进行覆写
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    self.backgroundColor = self.viewModel.bgCor;
    self.titleLab.alpha = 1;
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.viewModel.textModel.text;
        _titleLab.font = self.viewModel.textModel.font;
        _titleLab.textColor = self.viewModel.textModel.textCor;
        _titleLab.textAlignment = self.viewModel.textModel.textAlignment;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _titleLab;
}


@end
