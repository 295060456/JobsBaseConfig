//
//  JobsLeftRightLab.m
//  Casino
//
//  Created by Jobs on 2021/12/6.
//

#import "JobsLeftRightLab.h"

@interface JobsLeftRightLab (){
    CGFloat leftTextWidth;
    CGFloat rightTextWidth;
}
// UI
@property(nonatomic,strong)UIButton *leftBtn;// 用Button的目的是可以兼容承接图片
@property(nonatomic,strong)UIButton *rightBtn;// 用Button的目的是可以兼容承接图片
// Data
@property(nonatomic,strong)JobsLeftRightLabModel *leftRightLabModel;

@end

@implementation JobsLeftRightLab

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(JobsLeftRightLabModel *_Nullable)model{
    self.leftRightLabModel = model;
    [self textWidth];
    if (model) {
        [self.leftBtn buttonAutoFontByWidth];
        [self.rightBtn buttonAutoFontByWidth];
    }
    
}
//具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsLeftRightLabModel *_Nullable)model{
    CGFloat H = [model.upLabText getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                calcLabelHeight_Width:CalcLabelHeight
                                                                                 font:model.upLabFont
                                                         boundingRectWithHeight_Width:(JobsWidth(119) + model.space)];
    
    return CGSizeMake(JobsWidth(119) + model.space, H);
}

-(void)textWidth{
    leftTextWidth = [self.leftRightLabModel.upLabText getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                                     calcLabelHeight_Width:CalcLabelWidth
                                                                                                      font:self.leftRightLabModel.upLabFont
                                                                              boundingRectWithHeight_Width:[JobsLeftRightLab viewSizeWithModel:nil].height];
    
    rightTextWidth = [self.leftRightLabModel.downLabText getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                                        calcLabelHeight_Width:CalcLabelWidth
                                                                                                         font:self.leftRightLabModel.downLabFont
                                                                                 boundingRectWithHeight_Width:[JobsLeftRightLab viewSizeWithModel:nil].height];
    
    leftTextWidth = self.leftRightLabModel.rate == 0.5 ? leftTextWidth : [JobsLeftRightLab viewSizeWithModel:nil].width * self.leftRightLabModel.rate;
    rightTextWidth = self.leftRightLabModel.rate == 0.5 ? rightTextWidth : [JobsLeftRightLab viewSizeWithModel:nil].width * (1 - self.leftRightLabModel.rate);
}
#pragma mark —— lazyLoad
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = UIButton.new;
        _leftBtn.titleLabel.textAlignment = self.leftRightLabModel.upLabTextAlignment;
        [_leftBtn normalTitle:self.leftRightLabModel.upLabText];
        [_leftBtn normalImage:self.leftRightLabModel.upLabImage];
        [_leftBtn normalTitleColor:self.leftRightLabModel.upLabTextCor];
        [_leftBtn normalBackgroundImage:self.leftRightLabModel.upLabBgImage];
        _leftBtn.backgroundColor = self.leftRightLabModel.upLabBgCor;
        _leftBtn.titleLabel.font = self.leftRightLabModel.upLabFont;
        [self addSubview:_leftBtn];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.width.mas_equalTo(leftTextWidth);
        }];
    }return _leftBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = UIButton.new;
        _rightBtn.titleLabel.textAlignment = self.leftRightLabModel.downLabTextAlignment;
        [_rightBtn normalTitle:self.leftRightLabModel.downLabText];
        [_rightBtn normalImage:self.leftRightLabModel.downLabImage];
        [_rightBtn normalTitleColor:self.leftRightLabModel.downLabTextCor];
        [_rightBtn normalBackgroundImage:self.leftRightLabModel.downLabBgImage];
        _rightBtn.backgroundColor = self.leftRightLabModel.downLabBgCor;
        _rightBtn.titleLabel.font = self.leftRightLabModel.downLabFont;
        [self addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.left.equalTo(self.leftBtn.mas_right).offset(self.leftRightLabModel.space);
        }];
    }return _rightBtn;
}

@end
