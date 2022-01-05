//
//  CasinoUpgradeContentView.m
//  Casino
//
//  Created by Jobs on 2021/12/25.
//

#import "CasinoUpgradeContentView.h"

@interface CasinoUpgradeContentView ()
/// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *sureBtn;
/// Data

@end

@implementation CasinoUpgradeContentView

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
-(void)richElementsInViewWithModel:(id _Nullable)model{
    self.titleLab.alpha = 1;
    self.cancelBtn.alpha = 1;
    self.sureBtn.alpha = 1;
}
//具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsWidth(290), JobsWidth(133));
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightMedium];
        _titleLab.textColor = HEXCOLOR(0x524740);
        _titleLab.text = Internationalization(@"The existing new version needs to be updated. Are you sure to download it?");
        _titleLab.numberOfLines = 0;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(JobsWidth(5));
        }];
    }return _titleLab;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        [_cancelBtn normalTitle:Internationalization(@"Cancel")];
        [_cancelBtn normalTitleColor:HEXCOLOR(0x502600)];
        [_cancelBtn titleFont:[UIFont systemFontOfSize:JobsWidth(14) weight:UIControlStateNormal]];
        BtnClickEvent(_cancelBtn, if(self.viewBlock) self.viewBlock(x););
        [_cancelBtn normalBackgroundImage:KIMG(@"弹窗取消按钮背景图")];
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(110), JobsWidth(44)));
            make.left.equalTo(self).offset(JobsWidth(20));
            make.bottom.equalTo(self).offset(-JobsWidth(20));
        }];
    }return _cancelBtn;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        [_sureBtn normalTitle:Internationalization(@"Sure")];
        [_sureBtn normalTitleColor:HEXCOLOR(0x502600)];
        [_sureBtn titleFont:[UIFont systemFontOfSize:JobsWidth(14) weight:UIControlStateNormal]];
        BtnClickEvent(_sureBtn, if(self.viewBlock) self.viewBlock(x););
        [_sureBtn normalBackgroundImage:KIMG(@"弹窗确定按钮背景图")];
        [self addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(110), JobsWidth(44)));
            make.right.equalTo(self).offset(JobsWidth(-20));
            make.bottom.equalTo(self).offset(-JobsWidth(20));
        }];
    }return _sureBtn;
}

@end
