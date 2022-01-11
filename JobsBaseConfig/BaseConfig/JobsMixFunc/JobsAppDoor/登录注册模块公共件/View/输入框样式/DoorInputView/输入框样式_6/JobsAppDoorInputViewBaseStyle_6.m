//
//  JobsAppDoorInputViewBaseStyle_6.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/20.
//

#import "JobsAppDoorInputViewBaseStyle_6.h"

@interface JobsAppDoorInputViewBaseStyle_6 ()
//UI
@property(nonatomic,strong)JobsMagicTextField *textField;
@property(nonatomic,strong)AuthCodeLab *authCodeLab;
//Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;

@end

@implementation JobsAppDoorInputViewBaseStyle_6

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kClearColor;
        [UIView colourToLayerOfView:self
                         withColour:kWhiteColor
                     andBorderWidth:1];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [UIView appointCornerCutToCircleWithTargetView:self.authCodeLab
                                 byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                       cornerRadii:CGSizeMake(self.authCodeLab.height / 2, self.authCodeLab.height / 2)];
    [UIView setBorderWithView:self.authCodeLab
                  borderColor:kWhiteColor
                  borderWidth:1
                   borderType:UIBorderSideTypeLeft];
}
#pragma mark —— 一些私有方法
-(void)configTextField{
    _textField.leftView = [UIImageView.alloc initWithImage:self.doorInputViewBaseStyleModel.leftViewIMG];
    _textField.leftViewMode = self.doorInputViewBaseStyleModel.leftViewMode;
    _textField.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
    _textField.keyboardType = self.doorInputViewBaseStyleModel.keyboardType;
    _textField.textColor = self.doorInputViewBaseStyleModel.titleStrCor;
    _textField.returnKeyType = self.doorInputViewBaseStyleModel.returnKeyType;
    _textField.keyboardAppearance = self.doorInputViewBaseStyleModel.keyboardAppearance;
    _textField.useCustomClearButton = self.doorInputViewBaseStyleModel.useCustomClearButton;
    _textField.isShowDelBtn = self.doorInputViewBaseStyleModel.isShowDelBtn;
    _textField.rightViewOffsetX = self.doorInputViewBaseStyleModel.rightViewOffsetX;// 删除按钮的偏移量
    _textField.placeholderColor = self.doorInputViewBaseStyleModel.placeholderColor;
    _textField.placeholderFont = self.doorInputViewBaseStyleModel.placeholderFont;
    _textField.objBindingParams = self.textFieldInputModel;
    _textField.leftViewOffsetX = self.doorInputViewBaseStyleModel.leftViewOffsetX ? : JobsWidth(17);
    _textField.animationColor = self.doorInputViewBaseStyleModel.animationColor ? : kWhiteColor;
    _textField.placeHolderAlignment = self.doorInputViewBaseStyleModel.placeHolderAlignment ? : PlaceHolderAlignmentLeft;
    _textField.placeHolderOffset = self.doorInputViewBaseStyleModel.placeHolderOffset ? : JobsWidth(20);
    _textField.moveDistance = self.doorInputViewBaseStyleModel.moveDistance ? : JobsWidth(40);
}

-(void)block:(JobsMagicTextField *)textField
       value:(NSString *)value{
    
    self.textFieldInputModel.resString = value;
    self.textFieldInputModel.PlaceHolder = self.doorInputViewBaseStyleModel.placeHolderStr;

    textField.objBindingParams = self.textFieldInputModel;
    
    if (self.viewBlock) self.viewBlock(textField);// 对外统一传出TF
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsWidth(345), JobsWidth(30));
}

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel;
    self.authCodeLab.alpha = 1;
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
-(AuthCodeLab *)authCodeLab{
    if (!_authCodeLab) {
        _authCodeLab = AuthCodeLab.new;
        _authCodeLab.textAlignment = NSTextAlignmentCenter;
        _authCodeLab.text = @"ss";
        _authCodeLab.font = kFontSize(16);
        _authCodeLab.alpha = 0.7;
        _authCodeLab.textColor = kWhiteColor;
        _authCodeLab.backgroundColor = kBlackColor;

        [self addSubview:_authCodeLab];
        [_authCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self);
            make.width.mas_equalTo(80);
        }];
    }return _authCodeLab;
}

-(JobsMagicTextField *)textField{
    if (!_textField) {
        _textField = JobsMagicTextField.new;
        _textField.delegate = self;
        @weakify(self)
        [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            NSLog(@"MMM = %@",x);
            [self block:self->_textField
                  value:x];
        }];
        
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self.authCodeLab.mas_left).offset(-JobsWidth(3));
        }];
    }return _textField;
}

@end
