//
//  JobsUpDownLab.m
//  Casino
//
//  Created by Jobs on 2021/12/6.
//

#import "JobsUpDownLab.h"

@interface JobsUpDownLab ()
// UI
@property(nonatomic,strong)UIButton *upBtn;// 用Button的目的是可以兼容承接图片
@property(nonatomic,strong)UIButton *downBtn;// 用Button的目的是可以兼容承接图片
// Data
@property(nonatomic,strong)JobsUpDownLabModel *upDownLabModel;

@end

@implementation JobsUpDownLab

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(JobsUpDownLabModel *_Nullable)model{
    self.upDownLabModel = model;
    if (model) {
        [self.upBtn buttonAutoFontByWidth];
        [self.downBtn buttonAutoFontByWidth];
    }
}
//具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(KWidth(37), KWidth(35) + model.space);
}
#pragma mark —— lazyLoad
-(UIButton *)upBtn{
    if (!_upBtn) {
        _upBtn = UIButton.new;
        _upBtn.titleLabel.textAlignment = self.upDownLabModel.upLabTextAlignment;
        [_upBtn normalTitle:self.upDownLabModel.upLabText];
        [_upBtn normalImage:self.upDownLabModel.upLabImage];
        [_upBtn normalTitleColor:self.upDownLabModel.upLabTextCor];
        [_upBtn normalBackgroundImage:self.upDownLabModel.upLabBgImage];
        _upBtn.backgroundColor = self.upDownLabModel.upLabBgCor;
        _upBtn.titleLabel.font = self.upDownLabModel.upLabFont;
        [self addSubview:_upBtn];
        [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(self.viewSize.height * self.upDownLabModel.rate);
        }];
        [self layoutIfNeeded];
        NSLog(@"");
    }return _upBtn;
}

-(UIButton *)downBtn{
    if (!_downBtn) {
        _downBtn = UIButton.new;
        _downBtn.titleLabel.textAlignment = self.upDownLabModel.downLabTextAlignment;
        [_downBtn normalTitle:self.upDownLabModel.downLabText];
        [_downBtn normalImage:self.upDownLabModel.downLabImage];
        [_downBtn normalTitleColor:self.upDownLabModel.downLabTextCor];
        [_downBtn normalBackgroundImage:self.upDownLabModel.downLabBgImage];
        _downBtn.backgroundColor = self.upDownLabModel.downLabBgCor;
        _downBtn.titleLabel.font = self.upDownLabModel.downLabFont;
        [self addSubview:_downBtn];
        [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.upBtn.mas_bottom).offset(self.upDownLabModel.space);
            make.bottom.left.right.equalTo(self);
        }];
        [self layoutIfNeeded];
        NSLog(@"");
    }return _downBtn;
}

@end