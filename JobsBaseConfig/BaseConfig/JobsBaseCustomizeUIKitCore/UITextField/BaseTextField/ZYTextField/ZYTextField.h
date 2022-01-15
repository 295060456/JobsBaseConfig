#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "NSObject+CurrentDevice.h"
#import "NSObject+RichText.h"
#import "UITextField+Extend.h"
#import "LoadingImage.h"
#import "MacroDef_Cor.h"
#import "TextFieldDefine.h"

@interface ZYTextField : UITextField

@property(nonatomic,assign)CGFloat TFRiseHeight; /// 键盘在此手机上的最高弹起，区别于全面屏结合非全面屏，有一个安全区域34
@property(nonatomic,assign)CGFloat offset; /// 光标的起始距离距离控件左边的差值
@property(nonatomic,assign)CGFloat leftViewOffsetX;
@property(nonatomic,assign)CGFloat rightViewOffsetX;
@property(nonatomic,assign)PlaceHolderAlignment placeHolderAlignment; ///PlaceHolder的位置
@property(nonatomic,assign)CGFloat placeHolderOffset; /// 左/右/居中 对齐的时候的偏移量 传正值
@property(nonatomic,assign)CGFloat ZYTextFieldCornerRadius;
@property(nonatomic,assign)CGFloat ZYTextFieldBorderWidth;
@property(nonatomic,assign)UIColor *ZYTextFieldBorderColor;
@property(nonatomic,assign)BOOL ZYTextFieldMasksToBounds;
@property(nonatomic,assign)BOOL isShowDelBtn;/// 是否显示删除按钮，默认不显示
@property(nonatomic,assign)BOOL useCustomClearButton;/// 是否使用自定义的删除按钮 默认不使用
@property(nonatomic,assign)BOOL isShowMenu; ///是否显示菜单 默认不显示

@end

/**

 过滤字符请结合RAC，是目前的最优解
 
 @jobs_weakify(self)
 [[tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
     return YES;
 }] subscribeNext:^(NSString * _Nullable x) {
//            @jobs_strongify(self)
     NSLog(@"输入的字符为 = %@",x);
     if ([x isContainsSpecialSymbolsString:nil]) {
         [WHToast toastMsg:Internationalization(@"Do not enter special characters")];
     }else{
         NSLog(@"AAA输入的字符为 = %@",x);
     }
 }];
 
**/
