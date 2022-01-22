//
//  JobsAppDoorInputViewBaseStyle_1.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyle_1.h"

@interface JobsAppDoorInputViewBaseStyle_1 ()
//UI
@property(nonatomic,strong)UIButton *countDownBtn;
@property(nonatomic,strong)JobsMagicTextField *textField;
//Data
@property(nonatomic,strong)NSString *titleStr_1;
@property(nonatomic,strong)NSString *titleStr_2;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*richLabelDataStringsMutArr;
@property(nonatomic,strong)ButtonTimerConfigModel *btnTimerConfigModel;

@end

@implementation JobsAppDoorInputViewBaseStyle_1

- (instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = kRedColor;
        self.titleStr_1 = @"点击";
        self.titleStr_2 = @"发送验证码";
        [self layerBorderColour:kWhiteColor andBorderWidth:1];
    }return self;
}
#pragma mark —— 一些私有方法
-(void)configTextField{
    _textField.leftView = [UIImageView.alloc initWithImage:self.doorInputViewBaseStyleModel.leftViewIMG];
    _textField.leftViewMode = self.doorInputViewBaseStyleModel.leftViewMode;
    _textField.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
    _textField.keyboardType = self.doorInputViewBaseStyleModel.keyboardType;
    _textField.returnKeyType = self.doorInputViewBaseStyleModel.returnKeyType;
    _textField.keyboardAppearance = self.doorInputViewBaseStyleModel.keyboardAppearance;
    _textField.textColor = self.doorInputViewBaseStyleModel.titleStrCor;
    _textField.useCustomClearButton = self.doorInputViewBaseStyleModel.useCustomClearButton;
    _textField.isShowDelBtn = self.doorInputViewBaseStyleModel.isShowDelBtn;
    _textField.rightViewOffsetX = self.doorInputViewBaseStyleModel.rightViewOffsetX;// 删除按钮的偏移量
    _textField.objBindingParams = self.textFieldInputModel;
    _textField.placeholderColor = self.doorInputViewBaseStyleModel.placeholderColor;
    _textField.placeholderFont = self.doorInputViewBaseStyleModel.placeholderFont;
    _textField.leftViewOffsetX = self.doorInputViewBaseStyleModel.leftViewOffsetX ? :  JobsWidth(17);
    _textField.animationColor = self.doorInputViewBaseStyleModel.animationColor ? : Cor4;
    _textField.placeHolderAlignment = self.doorInputViewBaseStyleModel.placeHolderAlignment ? : PlaceHolderAlignmentLeft;
    _textField.placeHolderOffset = self.doorInputViewBaseStyleModel.placeHolderOffset ? : JobsWidth(20);
    _textField.moveDistance = self.doorInputViewBaseStyleModel.moveDistance ? : JobsWidth(35);
}

-(void)block:(JobsMagicTextField *)textField
       value:(NSString *)value{
    
    self.textFieldInputModel.resString = value;
    self.textFieldInputModel.PlaceHolder = self.doorInputViewBaseStyleModel.placeHolderStr;
    textField.objBindingParams = self.textFieldInputModel;
    
    if (self.viewBlock) self.viewBlock(textField);// 对外统一传出TF
}
/// 倒计时按钮（需要销毁定时器）
-(UIButton *)getCountDownBtn{
    return self.countDownBtn;
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsWidth(345), JobsWidth(30));
}

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel;
    self.countDownBtn.alpha = 1;
    self.textField.alpha = 1;
    [self configTextField];
}
#pragma mark —— JobsDoorInputViewProtocol
-(void)changeTextFieldAnimationColor:(BOOL)toRegisterBtnSelected{
    self.textField.animationColor = toRegisterBtnSelected ? Cor4 : Cor4;
}

-(JobsMagicTextField *_Nullable)getTextField{
    return _textField;
}

-(NSString *_Nullable)getTextFieldValue{
    return _textField.text;
}
#pragma mark —— lazyLoad
-(ButtonTimerConfigModel *)btnTimerConfigModel{
    if (!_btnTimerConfigModel) {
        _btnTimerConfigModel = ButtonTimerConfigModel.new;
        
        /// 一些通用的设置
        _btnTimerConfigModel.count = 50;
        _btnTimerConfigModel.showTimeType = ShowTimeType_SS;//时间显示风格
        _btnTimerConfigModel.countDownBtnType = TimerStyle_anticlockwise;// 时间方向
        _btnTimerConfigModel.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;//
        _btnTimerConfigModel.labelShowingType = UILabelShowingType_05;//【换行模式】
        
        /// 计时器未开始【静态值】
        _btnTimerConfigModel.readyPlayValue.layerBorderWidth = 1;
        _btnTimerConfigModel.readyPlayValue.layerCornerRadius = JobsWidth(18);
        _btnTimerConfigModel.readyPlayValue.bgCor = KYellowColor;
        _btnTimerConfigModel.readyPlayValue.layerBorderColour = kClearColor;
        _btnTimerConfigModel.readyPlayValue.textCor = kBlackColor;
        _btnTimerConfigModel.readyPlayValue.text = Title9;
        _btnTimerConfigModel.readyPlayValue.font = [UIFont systemFontOfSize:JobsWidth(13)
                                                                               weight:UIFontWeightMedium];
        /// 计时器进行中【动态值】
        _btnTimerConfigModel.runningValue.bgCor = kCyanColor;
        _btnTimerConfigModel.runningValue.text = Internationalization(Title12);
        /// 计时器结束【静态值】
        _btnTimerConfigModel.endValue.bgCor = KYellowColor;
        
    }return _btnTimerConfigModel;
}

-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [UIButton.alloc initWithConfig:self.btnTimerConfigModel];
        
        BtnClickEvent(_countDownBtn, {
            [x startTimer];//选择时机、触发启动
//            NSLog(@"SSSSS = 获取验证码");
            if (self.viewBlock) self.viewBlock(x);
        })
        
        [_countDownBtn actionBlockTimerRunning:^(TimerProcessModel *data) {
            @jobs_strongify(self)
        }];

        [self addSubview:_countDownBtn];
        [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-JobsWidth(10));
            make.top.equalTo(self).offset(JobsWidth(8));
            make.bottom.equalTo(self).offset(-JobsWidth(8));
            make.width.mas_equalTo(JobsWidth(80));
        }];
        
    }return _countDownBtn;
}

-(NSMutableArray<RichTextConfig *> *)richLabelDataStringsMutArr{
    if (!_richLabelDataStringsMutArr) {
        _richLabelDataStringsMutArr = NSMutableArray.array;
        
        RichTextConfig *config_01 = RichTextConfig.new;
        config_01.font = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightMedium];
        config_01.cor = kBlueColor;
        config_01.targetString = self.titleStr_1;
        
        RichTextConfig *config_02 = RichTextConfig.new;
        config_02.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightMedium];
        config_02.cor = kRedColor;
        config_02.targetString = self.titleStr_2;
        
        [_richLabelDataStringsMutArr addObject:config_01];
        [_richLabelDataStringsMutArr addObject:config_02];
        
    }return _richLabelDataStringsMutArr;
}

-(JobsMagicTextField *)textField{
    if (!_textField) {
        _textField = JobsMagicTextField.new;
        _textField.delegate = self;
        @jobs_weakify(self)
        [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @jobs_strongify(self)
            NSLog(@"MMM = %@",x);
            [self block:self->_textField
                  value:x];
        }];
        
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(self.countDownBtn.mas_left);
        }];
    }return _textField;
}

@end
