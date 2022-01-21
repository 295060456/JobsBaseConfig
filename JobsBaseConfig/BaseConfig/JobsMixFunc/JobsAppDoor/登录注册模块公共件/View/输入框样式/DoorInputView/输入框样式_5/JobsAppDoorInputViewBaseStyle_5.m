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
    [self setBorderWithColor:RGBA_COLOR(162, 162, 162, 0.2f)
                 borderWidth:1
                  borderType:UIBorderSideTypeBottom];
}
#pragma mark —— 一些私有方法
-(void)configTextField{
    _textField.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
    _textField.background = self.doorInputViewBaseStyleModel.background;
    _textField.keyboardType = self.doorInputViewBaseStyleModel.keyboardType;
    _textField.textColor = self.doorInputViewBaseStyleModel.ZYtextColor;
    _textField.useCustomClearButton = self.doorInputViewBaseStyleModel.useCustomClearButton;
    _textField.isShowDelBtn = self.doorInputViewBaseStyleModel.isShowDelBtn;
    _textField.rightViewOffsetX = self.doorInputViewBaseStyleModel.rightViewOffsetX;// 删除按钮的偏移量
    _textField.placeHolderAlignment = self.doorInputViewBaseStyleModel.placeHolderAlignment;
    _textField.placeHolderOffset = self.doorInputViewBaseStyleModel.placeHolderOffset;
    _textField.leftViewOffsetX = self.doorInputViewBaseStyleModel.leftViewOffsetX;
    _textField.offset = self.doorInputViewBaseStyleModel.offset;
    _textField.objBindingParams = self.textFieldInputModel;
    _textField.placeholderColor = self.doorInputViewBaseStyleModel.placeholderColor;
    _textField.placeholderFont = self.doorInputViewBaseStyleModel.placeholderFont;
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsWidth(305), JobsWidth(14 + 36 + 4));
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
        self.textField.isShowDelBtn = self.doorInputViewBaseStyleModel.isShowDelBtn;/// ❎
        [self configTextField];
    }
}
#pragma mark —— JobsDoorInputViewProtocol
-(ZYTextField *_Nullable)getTextField{
    return _textField;
}

-(NSString *_Nullable)getTextFieldValue{
    return _textField.text;
}

-(UIButton *)getSecurityModeBtn{
    return _securityModeBtn;
}
#pragma mark —— lazyLoad
-(UIButton *)securityModeBtn{
    if (!_securityModeBtn) {
        _securityModeBtn = UIButton.new;
        
        [_securityModeBtn normalImage:self.doorInputViewBaseStyleModel.selectedSecurityBtnIMG ? : [UIImage imageWithColor:UIColor.redColor]];
        [_securityModeBtn normalImage:self.doorInputViewBaseStyleModel.unSelectedSecurityBtnIMG ? : [UIImage imageWithColor:UIColor.blueColor]];
        
        BtnClickEvent(_securityModeBtn, {
            x.selected = !x.selected;
            self.textField.secureTextEntry = x.selected;
            if (x.selected && !self.textField.isEditing) {
                self.textField.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
            }
        });
        
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
        _btnTimerConfigModel.labelShowingType = UILabelShowingType_05;//【换行模式】
        
        /// 计时器未开始【静态值】
        _btnTimerConfigModel.readyPlayValue.layerBorderWidth = 1;
        _btnTimerConfigModel.readyPlayValue.layerCornerRadius = 18;
        _btnTimerConfigModel.readyPlayValue.bgCor = KYellowColor;
        _btnTimerConfigModel.readyPlayValue.layerBorderColour = kClearColor;
        _btnTimerConfigModel.readyPlayValue.textCor = kBlackColor;
        _btnTimerConfigModel.readyPlayValue.text = Title9;
        _btnTimerConfigModel.readyPlayValue.font = [UIFont systemFontOfSize:JobsWidth(13)
                                                                               weight:UIFontWeightMedium];
        /// 计时器进行中【动态值】
        _btnTimerConfigModel.runningValue.bgCor = kCyanColor;
        /// 计时器结束【静态值】
        _btnTimerConfigModel.endValue.bgCor = kRedColor;
        
    }return _btnTimerConfigModel;
}

-(UIButton *)authCodeBtn{
    if (!_authCodeBtn) {
        _authCodeBtn = [UIButton.alloc initWithConfig:self.btnTimerConfigModel];
        BtnClickEvent(_authCodeBtn, [x startTimer];);//选择时机、触发启动
        [_authCodeBtn actionBlockTimerRunning:^(TimerProcessModel *data) {
            @jobs_strongify(self)
        }];
        [self addSubview:_authCodeBtn];
        [_authCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-JobsWidth(50));
            make.bottom.equalTo(self.textField);
            make.size.mas_equalTo(CGSizeMake(JobsWidth(78), JobsWidth(25)));
        }];
        
        [_authCodeBtn cornerCutToCircleWithCornerRadius:25 / 2];
        
//        [_countDownBtn appointCornerCutToCircleByRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
//                                                     cornerRadii:CGSizeMake(_countDownBtn.height / 2, _countDownBtn.height / 2)];

    }return _authCodeBtn;
}

-(ZYTextField *)textField{
    if (!_textField) {
        _textField = ZYTextField.new;
        _textField.text = self.doorInputViewBaseStyleModel.textModel.text;
        _textField.delegate = self;
        @jobs_weakify(self)
        [[_textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//            @jobs_strongify(self)
            return YES;
        }] subscribeNext:^(NSString * _Nullable x) {
            @jobs_strongify(self)
            self.securityModeBtn.visible = ![NSString isNullString:x] && self.doorInputViewBaseStyleModel.isShowSecurityBtn;/// 👁
            if ([x isContainsSpecialSymbolsString:nil]) {
                [WHToast toastMsg:Internationalization(@"Do not enter special characters")];
            }else{
                if (self.viewBlock) self.viewBlock(self->_textField);
            }
        }];

        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab);
            make.top.equalTo(self.titleLab.mas_bottom);
            make.bottom.equalTo(self).offset(-JobsWidth(8));
            
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
