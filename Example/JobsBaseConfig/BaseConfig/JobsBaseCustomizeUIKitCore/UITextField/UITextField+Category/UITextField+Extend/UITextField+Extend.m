//
//  UITextField+Extend.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "UITextField+Extend.h"

@implementation UITextField (Extend)
#pragma mark —— 一些功能方法
/// RAC 回调封装
-(void)textFieldEventFilterBlock:(JobsReturnBOOLByIDBlock)filterBlock
              subscribeNextBlock:(jobsByIDBlock)subscribeNextBlock{
    [[self.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return filterBlock ? filterBlock(value) : YES;
    }] subscribeNext:^(NSString * _Nullable x) {
        if (subscribeNextBlock) subscribeNextBlock(x);
    }];
}

-(NSString *)getCurrentTextFieldValueByReplacementString:(NSString *)replacementString{
    if (self.text.length >= 1) {
        return [replacementString isEqualToString:@""] ? [self.text substringToIndex:(self.text.length - 1)] : [self.text stringByAppendingString:replacementString];
    }else{
        return replacementString;
    }
}
/// 自定义系统的清除按钮
- (void)modifyClearButtonWithImage:(UIImage *)image{
    [self.customSysClearBtn setImage:image
                            forState:UIControlStateNormal];
    self.rightView = self.customSysClearBtn;
    self.rightViewMode = UITextFieldViewModeWhileEditing;
}
#pragma mark —— SET | GET
static char *UITextField_Extend_customSysClearBtn = "UITextField_Extend_customSysClearBtn";
@dynamic customSysClearBtn;
-(UIButton *)customSysClearBtn{
    UIButton *CustomSysClearBtn = objc_getAssociatedObject(self, UITextField_Extend_customSysClearBtn);
    if (!CustomSysClearBtn) {
        CustomSysClearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (HDDeviceSystemVersion.floatValue >= 15.0) {
#warning UIButtonConfiguration 怎么适配使用？
//            'adjustsImageWhenHighlighted' is deprecated: first deprecated in iOS 15.0 - This property is ignored when using UIButtonConfiguration, you may customize to replicate this behavior via a configurationUpdateHandler
        }
        SuppressWdeprecatedDeclarationsWarning(CustomSysClearBtn.adjustsImageWhenHighlighted = NO;);
        
        [CustomSysClearBtn setFrame:CGRectMake(0.0f,
                                               0.0f,
                                               15.0f,
                                               15.0f)];
        @jobs_weakify(self)
        [[CustomSysClearBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @jobs_strongify(self)
            self.text = @"";
        }];
        objc_setAssociatedObject(self,
                                 UITextField_Extend_customSysClearBtn,
                                 CustomSysClearBtn,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return CustomSysClearBtn;
}

-(void)setCustomSysClearBtn:(UIButton *)customSysClearBtn{
    objc_setAssociatedObject(self,
                             UITextField_Extend_customSysClearBtn,
                             customSysClearBtn,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
