//
//  JobsAppDoorInputViewBaseStyle_4.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyle_4.h"

@interface JobsAppDoorInputViewBaseStyle_4 ()
//UI
@property(nonatomic,strong)ImageCodeView *imageCodeView;
@property(nonatomic,strong)JobsMagicTextField *textField;
//Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;

@end

@implementation JobsAppDoorInputViewBaseStyle_4

- (instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = kRedColor;
        [UIView colourToLayerOfView:self
                         withColour:kWhiteColor
                     andBorderWidth:1];
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
    _textField.placeholderColor = self.doorInputViewBaseStyleModel.placeholderColor;
    _textField.placeholderFont = self.doorInputViewBaseStyleModel.placeholderFont;
    _textField.objBindingParams = _textField.placeholder;
    _textField.leftViewOffsetX = self.doorInputViewBaseStyleModel.leftViewOffsetX ? : JobsWidth(17);
    _textField.animationColor = self.doorInputViewBaseStyleModel.animationColor ? : Cor4;
    _textField.moveDistance = self.doorInputViewBaseStyleModel.moveDistance ? : JobsWidth(35);
    _textField.placeHolderAlignment = self.doorInputViewBaseStyleModel.placeHolderAlignment ? : PlaceHolderAlignmentLeft;
    _textField.placeHolderOffset = self.doorInputViewBaseStyleModel.placeHolderOffset ? : JobsWidth(20);
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsWidth(345), JobsWidth(30));
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

-(void)block:(JobsMagicTextField *)textField
       value:(NSString *)value{
    
    Ivar ivar = class_getInstanceVariable(JobsMagicTextField.class, "_placeholderAnimationLbl");//必须是下划线接属性
    UILabel *label = object_getIvar(textField, ivar);
    
    JobsAppDoorInputViewTFModel *InputViewTFModel = JobsAppDoorInputViewTFModel.new;
    InputViewTFModel.resString = value;
    InputViewTFModel.PlaceHolder = label.text;
    
    if (self.viewBlock) self.viewBlock(InputViewTFModel);
}

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel;
    self.imageCodeView.alpha = 1;
    self.textField.alpha = 1;
    [self configTextField];
}
#pragma mark —— lazyLoad
-(ImageCodeView *)imageCodeView{
    if (!_imageCodeView) {
        _imageCodeView = ImageCodeView.new;
        _imageCodeView.font = kFontSize(16);
        _imageCodeView.alpha = 0.7;
        _imageCodeView.bgColor = kWhiteColor;
        [self addSubview:_imageCodeView];
        [_imageCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JobsWidth(5));
            make.bottom.equalTo(self).offset(-JobsWidth(5));
            make.right.equalTo(self).offset(-JobsWidth(10));
            make.width.mas_equalTo(80);
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_imageCodeView
                          andCornerRadius:20];
    }return _imageCodeView;
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
            make.right.equalTo(self.imageCodeView.mas_left);
        }];
    }return _textField;
}

@end
