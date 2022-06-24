//
//  UIButton+UI.h
//  Casino
//
//  Created by Jobs on 2021/11/29.
//

#import <UIKit/UIKit.h>
#import "MacroDef_Strong@Weak.h"
#import "JobsBlock.h"
#import "MacroDef_Cor.h"
/// For RAC
/// @jobs_weakify(self) 在内层定义
#define BtnClickEvent(button,action)\
@jobs_weakify(self)\
[[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {\
    @jobs_strongify(self)\
    action\
}];\
/// @jobs_weakify(self) 在外层定义
#define btnClickEvent(button,action)\
[[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {\
    @jobs_strongify(self)\
    action\
}];\
/// For UIKit
#define BtnAction(button,target,action)\
[button addTarget:target\
           action:action\
 forControlEvents:UIControlEventTouchUpInside];\

NS_ASSUME_NONNULL_BEGIN
/// ⚠️当font描绘的文字,或者文字大于UIButton的frame,UIButton的Title将不会显现⚠️
@interface UIButton (UI)
/// 为了迎合点语法而故意把下列方法属性化
/// Common
@property(nonatomic,strong)UIFont *titleFont;
@property(nonatomic,assign)NSTextAlignment titleAlignment;
@property(nonatomic,assign)BOOL makeNewLineShows;
/// Normal
@property(nonatomic,strong)UIImage *normalImage;
@property(nonatomic,strong)UIImage *normalBackgroundImage;
@property(nonatomic,strong)NSString *normalTitle;
@property(nonatomic,strong)UIColor *normalTitleColor;
@property(nonatomic,strong)NSAttributedString *normalAttributedTitle;
/// Selected
@property(nonatomic,strong)UIImage *selectedImage;
@property(nonatomic,strong)UIImage *selectedBackgroundImage;
@property(nonatomic,strong)NSString *selectedTitle;
@property(nonatomic,strong)UIColor *selectedTitleColor;
@property(nonatomic,strong)NSAttributedString *selectedAttributedTitle;
/// Endable
@property(nonatomic,strong)UIColor *endableNormalTitleColor;

#pragma mark —— 一些功能性
-(void)btnClickEventBlock:(jobsByIDBlock)subscribeNextBlock;
/// 方法名字符串（带参数、参数之间用"："隔开）、作用对象、参数
-(jobsByThreeIDBlock)btnClickActionWithParamarrays;
/// 方法名字符串（不带参数）、作用对象
-(jobsByTwoIDBlock)btnClickActionWithMethodName;
/// 代码触发点击调用
-(void)actionByCode;
/// 这个方法还有待完善
-(void)handelAdjustsImageWhenHighlighted;
/// UIButton 上的 image 旋转一定的角度angle
-(void)changeAction:(CGFloat)angle;
/// 当Button不可用的时候，需要做些什么
-(jobsByBOOLBlock _Nonnull)enabledBlock;
#pragma mark —— Common
-(void)titleFont:(UIFont *)font;
-(void)titleAlignment:(NSTextAlignment)textAlignment;
-(void)makeNewLineShows:(BOOL)breakLine;/// 换行显示
#pragma mark —— Normal
// set
-(void)normalImage:(UIImage *)image;
-(void)normalBackgroundImage:(UIImage *)backgroundImage;
-(void)normalTitle:(NSString *)title;
-(void)normalTitleColor:(UIColor *)titleColor;
-(void)normalAttributedTitle:(NSAttributedString *)title;
// get
-(nullable NSString *)titleForNormalState;
-(nullable NSAttributedString *)attributedTitleForNormalState;
-(nullable UIColor *)titleColorForNormalState;
-(nullable UIImage *)imageForNormalState;
-(nullable UIImage *)backgroundImageForNormalState;
#pragma mark —— Selected
// set
-(void)selectedImage:(UIImage *)image;
-(void)selectedBackgroundImage:(UIImage *)backgroundImage;
-(void)selectedTitle:(NSString *)title;
-(void)selectedTitleColor:(UIColor *)titleColor;
-(void)selectedAttributedTitle:(NSAttributedString *)title;
// get
-(nullable NSString *)titleForSelectedState;
-(nullable NSAttributedString *)attributedTitleForSelectedState;
-(nullable UIColor *)titleColorForSelectedState;
-(nullable UIImage *)imageForSelectedState;
-(nullable UIImage *)backgroundImageForSelectedState;

@end

NS_ASSUME_NONNULL_END
