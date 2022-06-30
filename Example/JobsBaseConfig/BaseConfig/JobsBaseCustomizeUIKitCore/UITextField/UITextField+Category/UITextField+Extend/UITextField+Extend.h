//
//  UITextField+Extend.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "JobsString.h"

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

#define ARC_TextField(textField,action)\
@jobs_weakify(self)\
[[_textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {\
    return YES;\
}] subscribeNext:^(NSString * _Nullable x) {\
    @jobs_strongify(self)\
    action\
}];

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Extend)

@property(nonatomic,strong)UIButton *customSysClearBtn;
/// RAC 回调封装
-(void)textFieldEventFilterBlock:(JobsReturnBOOLByIDBlock)filterBlock
              subscribeNextBlock:(jobsByIDBlock)subscribeNextBlock;
/// 自定义系统的清除按钮
-(void)modifyClearButtonWithImage:(UIImage *)image;
/// 过滤删除最科学的做法,获得当前TextField当前时刻的具体文本值
-(NSString *)getCurrentTextFieldValueByReplacementString:(NSString *)replacementString;

@end

NS_ASSUME_NONNULL_END
