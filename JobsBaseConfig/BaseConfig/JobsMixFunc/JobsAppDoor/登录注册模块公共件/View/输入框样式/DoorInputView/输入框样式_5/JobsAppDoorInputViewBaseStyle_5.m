//
//  JobsAppDoorInputViewBaseStyle_5.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "JobsAppDoorInputViewBaseStyle_5.h"

@interface JobsAppDoorInputViewBaseStyle_5 ()
// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)ZYTextField *textField;
@property(nonatomic,strong)UIButton *authCodeBtn;
@property(nonatomic,strong)UIButton *securityModeBtn;
// Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;
@property(nonatomic,strong)ButtonTimerConfigModel *btnTimerConfigModel;

@end

@implementation JobsAppDoorInputViewBaseStyle_5

-(void)dealloc{
    [_authCodeBtn timerDestroy];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    // 指定描边
    [UIView setBorderWithView:self
                  borderColor:RGBA_COLOR(162, 162, 162, 0.2f)
                  borderWidth:1
                   borderType:UIBorderSideTypeBottom];
}
#pragma mark —— 一些私有方法
-(void)configTextField{
    _textField.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
    _textField.background = self.doorInputViewBaseStyleModel.background;
    _textField.keyboardType = self.doorInputViewBaseStyleModel.keyboardType;
    _textField.textColor = self.doorInputViewBaseStyleModel.ZYtextColor;
    _textField.placeHolderAlignment = self.doorInputViewBaseStyleModel.placeHolderAlignment;
    _textField.placeHolderOffset = self.doorInputViewBaseStyleModel.placeHolderOffset;
    _textField.leftViewOffsetX = self.doorInputViewBaseStyleModel.leftViewOffsetX;
    _textField.offset = self.doorInputViewBaseStyleModel.offset;
    _textField.objBindingParams = _textField.placeholder;
    _textField.placeholderColor = self.doorInputViewBaseStyleModel.placeholderColor;
    _textField.placeholderFont = self.doorInputViewBaseStyleModel.placeholderFont;
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(KWidth(305), KWidth(14 + 36 + 4));
}
// 外层数据渲染
-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel;
    if (self.doorInputViewBaseStyleModel) {
        self.titleLab.alpha = 1;
        switch (self.style_5) {
            case InputViewStyle_5_1:{
                self.authCodeBtn.alpha = 1;
            }break;
            case InputViewStyle_5_2:{
                
            }break;
            default:
                break;
        }
        self.textField.alpha = 1;
        [self configTextField];
    }
}
#pragma mark —— JobsDoorInputViewProtocol
-(ZYTextField *)getTextField{
    return self.textField;
}

-(NSString *)getTextFieldValue{
    return self.textField.text;
}
#pragma mark —— lazyLoad
-(UIButton *)securityModeBtn{
    if (!_securityModeBtn) {
        _securityModeBtn = UIButton.new;
        [_securityModeBtn setImage:self.doorInputViewBaseStyleModel.selectedSecurityBtnIMG
                          forState:UIControlStateNormal];
        [_securityModeBtn setImage:self.doorInputViewBaseStyleModel.unSelectedSecurityBtnIMG
                          forState:UIControlStateSelected];
        @weakify(self)
        [[_securityModeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            self.textField.secureTextEntry = x.selected;
        }];
        [self addSubview:_securityModeBtn];
        [_securityModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(40);
        }];
    }return _securityModeBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.doorInputViewBaseStyleModel.titleLabStr;
        _titleLab.textColor = self.doorInputViewBaseStyleModel.titleStrCor;
        _titleLab.font = self.doorInputViewBaseStyleModel.titleStrFont;
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
        }];
    }return _titleLab;
}

-(ButtonTimerConfigModel *)btnTimerConfigModel{
    if (!_btnTimerConfigModel) {
        _btnTimerConfigModel = ButtonTimerConfigModel.new;
        
        /// 一些通用的设置
        _btnTimerConfigModel.count = 5;
        _btnTimerConfigModel.showTimeType = ShowTimeType_SS;//时间显示风格
        _btnTimerConfigModel.countDownBtnType = TimerStyle_anticlockwise;// 时间方向
        _btnTimerConfigModel.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;// 文本显示类型
        _btnTimerConfigModel.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;//【换行模式】
        
        /// 计时器未开始【静态值】
        _btnTimerConfigModel.layerBorderReadyPlayWidth = 1;
        _btnTimerConfigModel.layerCornerReadyPlayRadius = 18;
        _btnTimerConfigModel.bgReadyPlayCor = KYellowColor;
        _btnTimerConfigModel.layerBorderReadyPlayCor = kClearColor;
        _btnTimerConfigModel.titleReadyPlayCor = kBlackColor;
        _btnTimerConfigModel.titleReadyPlayStr = Title9;
        _btnTimerConfigModel.titleLabelReadyPlayFont = [UIFont systemFontOfSize:KWidth(13)
                                                                         weight:UIFontWeightMedium];
        /// 计时器进行中【动态值】
        _btnTimerConfigModel.bgRunningCor = kCyanColor;
        /// 计时器结束【静态值】
        _btnTimerConfigModel.bgEndCor = kRedColor;
        
    }return _btnTimerConfigModel;
}

-(UIButton *)authCodeBtn{
    if (!_authCodeBtn) {
        _authCodeBtn = [UIButton.alloc initWithConfig:self.btnTimerConfigModel];
        @weakify(self)
        [_authCodeBtn actionBlockTimerRunning:^(id data) {
            @strongify(self)
        }];
        
        [_authCodeBtn actionBlockTimerFinish:^(id data) {
            @strongify(self)
        }];

        [[_authCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            [x startTimer];//选择时机、触发启动
        }];
        
        [self addSubview:_authCodeBtn];
        [_authCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-KWidth(50));
            make.bottom.equalTo(self.textField);
            make.size.mas_equalTo(CGSizeMake(KWidth(78), KWidth(25)));
        }];
        
        [UIView cornerCutToCircleWithView:_authCodeBtn
                          andCornerRadius:25 / 2];
        
//        [UIView appointCornerCutToCircleWithTargetView:_countDownBtn
//                                     byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
//                                           cornerRadii:CGSizeMake(_countDownBtn.height / 2, _countDownBtn.height / 2)];

    }return _authCodeBtn;
}

-(ZYTextField *)textField{
    if (!_textField) {
        _textField = ZYTextField.new;
        _textField.delegate = self;
        @weakify(self)
        [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            self.securityModeBtn.hidden = ![NSString isNullString:x] || !self.doorInputViewBaseStyleModel.isShowSecurityBtn;
            if (self.viewBlock) self.viewBlock(self->_textField);
        }];

        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab);
            make.top.equalTo(self.titleLab.mas_bottom);
            make.bottom.equalTo(self).offset(-KWidth(8));
            
            switch (self.style_5) {
                case InputViewStyle_5_1:{
                    make.right.equalTo(self.authCodeBtn.mas_left);
                }break;
                case InputViewStyle_5_2:{
                    make.right.equalTo(self);
                }break;
                default:
                    break;
            }
            
        }];
    }return _textField;
}

@end
