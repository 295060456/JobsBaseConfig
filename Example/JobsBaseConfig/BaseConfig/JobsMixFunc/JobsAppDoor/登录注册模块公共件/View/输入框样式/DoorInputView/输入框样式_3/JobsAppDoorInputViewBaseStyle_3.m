//
//  JobsAppDoorInputViewBaseStyle_3.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyle_3.h"

@interface JobsAppDoorInputViewBaseStyle_3 ()
//UI
@property(nonatomic,strong)UIButton *securityModeBtn;
@property(nonatomic,strong)JobsMagicTextField *textField;
//Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;

@end

@implementation JobsAppDoorInputViewBaseStyle_3

@synthesize thisViewSize = _thisViewSize;

- (instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = kRedColor;
        [self layerBorderColour:Cor4 andBorderWidth:1];
    }return self;
}
#pragma mark —— BaseViewProtocol
- (instancetype)initWithSize:(CGSize)thisViewSize{
    if (self = [super init]) {
//        self.backgroundColor = kRedColor;
        self.thisViewSize = thisViewSize;
        [self layerBorderColour:Cor4 andBorderWidth:1];
    }return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— 一些私有方法
-(void)configTextField{
    if (![NSString isNullString:self.doorInputViewBaseStyleModel.inputStr]) {
        _textField.text = self.doorInputViewBaseStyleModel.inputStr;
    }
    _textField.background = self.doorInputViewBaseStyleModel.background;
    _textField.backgroundColor = self.doorInputViewBaseStyleModel.backgroundColor;
    _textField.disabledBackground = self.doorInputViewBaseStyleModel.disabledBackground;
    _textField.keyboardType = self.doorInputViewBaseStyleModel.keyboardType;
    _textField.leftView = [UIImageView.alloc initWithImage:self.doorInputViewBaseStyleModel.leftViewIMG];
    _textField.leftViewMode = self.doorInputViewBaseStyleModel.leftViewMode;
    _textField.textColor = self.doorInputViewBaseStyleModel.titleStrCor;
    _textField.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
    _textField.returnKeyType = self.doorInputViewBaseStyleModel.returnKeyType;
    _textField.keyboardAppearance = self.doorInputViewBaseStyleModel.keyboardAppearance;
    _textField.useCustomClearButton = self.doorInputViewBaseStyleModel.useCustomClearButton;
    _textField.isShowDelBtn = self.doorInputViewBaseStyleModel.isShowDelBtn;
    _textField.rightViewOffsetX = self.doorInputViewBaseStyleModel.rightViewOffsetX ? : JobsWidth(8);// 删除按钮的偏移量
    _textField.offset = self.doorInputViewBaseStyleModel.offset;
    _textField.placeholderColor = self.doorInputViewBaseStyleModel.placeholderColor;
    _textField.placeholderFont = self.doorInputViewBaseStyleModel.placeholderFont;
    _textField.leftViewOffsetX = self.doorInputViewBaseStyleModel.leftViewOffsetX ? : JobsWidth(17);
    _textField.animationColor = self.doorInputViewBaseStyleModel.animationColor ? : Cor4;
    _textField.placeHolderAlignment = self.doorInputViewBaseStyleModel.placeHolderAlignment ? : PlaceHolderAlignmentLeft;
    _textField.moveDistance = self.doorInputViewBaseStyleModel.moveDistance ? : JobsWidth(35);
    _textField.placeHolderOffset = self.doorInputViewBaseStyleModel.placeHolderOffset ? : JobsWidth(20);
    _textField.fieldEditorOffset = self.doorInputViewBaseStyleModel.fieldEditorOffset ? : JobsWidth(50);
    
    self.textFieldInputModel.PlaceHolder = _textField.placeholder;
}

-(void)block:(JobsMagicTextField *)textField
       value:(NSString *)value{

    self.textFieldInputModel.resString = value;
    self.textFieldInputModel.PlaceHolder = self.doorInputViewBaseStyleModel.placeHolderStr;

    textField.objBindingParams = self.textFieldInputModel;
    
    if (self.objectBlock) self.objectBlock(textField);// 对外统一传出TF
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsWidth(345), JobsWidth(30));
}

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel;
    self.textField.isShowDelBtn = self.doorInputViewBaseStyleModel.isShowDelBtn;/// ❎
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

-(UIButton *)getSecurityModeBtn{
    return _securityModeBtn;
}
#pragma mark —— UITextFieldDelegate
/// 获得焦点成为第一响应者，此时 textField.isEditing == YES
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.objectBlock) self.objectBlock(textField);// 对外统一传出TF
}
#pragma mark —— lazyLoad
-(UIButton *)securityModeBtn{
    if (!_securityModeBtn) {
        _securityModeBtn = UIButton.new;

        _securityModeBtn.selectedImage = self.doorInputViewBaseStyleModel.selectedSecurityBtnIMG ? : [UIImage imageWithColor:UIColor.redColor];
        _securityModeBtn.normalImage = self.doorInputViewBaseStyleModel.unSelectedSecurityBtnIMG ? : [UIImage imageWithColor:UIColor.blueColor];

        BtnClickEvent(_securityModeBtn, {
            x.selected = !x.selected;
            self.textField.secureTextEntry = !x.selected;
            if (x.selected && !self.textField.isEditing) {
                self.textField.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
            }
        });

        [self addSubview:_securityModeBtn];
        [_securityModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(JobsWidth(40));
        }];
    }return _securityModeBtn;
}

-(JobsMagicTextField *)textField{
    if (!_textField) {
        _textField = JobsMagicTextField.new;
        _textField.delegate = self;
        
        self.textField.secureTextEntry = self.doorInputViewBaseStyleModel.isShowSecurityBtn;
        
        @jobs_weakify(self)
        [[_textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//            @jobs_strongify(self)
            return YES;
        }] filter:^BOOL(NSString * _Nullable value) {
            NSLog(@"SSS = %@",self.textFieldInputModel.PlaceHolder);
            @jobs_strongify(self)
            if ([self.textFieldInputModel.PlaceHolder isEqualToString:Internationalization(@"User")]) {
                if ([self checkUserName:value]) {
                    return YES;
                }else{
                    if (![self userAndPasswordNotUpTo:value]) {
                        self.textField.text = [value substringWithRange:NSMakeRange(0, value.length - 1)];
                    }return NO;
                }
            }else if ([self.textFieldInputModel.PlaceHolder isEqualToString:Internationalization(@"Code")] ||
                      [self.textFieldInputModel.PlaceHolder isEqualToString:Internationalization(@"Confirm")]){
                if ([self checkUserPassword:value]) {
                    return YES;
                }else{
                    if (![self userAndPasswordNotUpTo:value]) {
                        self.textField.text = [value substringWithRange:NSMakeRange(0, value.length - 1)];
                    }return NO;
                }
            }else{}return NO;
        }] subscribeNext:^(NSString * _Nullable x) {
            @jobs_strongify(self)
            NSLog(@"输入的字符为 = %@",x);
            self.securityModeBtn.jobsVisible = ![NSString isNullString:x] && self.doorInputViewBaseStyleModel.isShowSecurityBtn;/// 👁
            if ([x isContainsSpecialSymbolsString:nil]) {
                [WHToast toastMsg:Internationalization(@"Do not enter special characters")];
            }else{
                [self block:self->_textField
                      value:x];
            }
        }];
        
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            if (self.doorInputViewBaseStyleModel.isShowSecurityBtn) {
                make.right.equalTo(self.securityModeBtn.mas_left);
            }else{
                make.right.equalTo(self);
            }
        }];
    }return _textField;
}

@end
