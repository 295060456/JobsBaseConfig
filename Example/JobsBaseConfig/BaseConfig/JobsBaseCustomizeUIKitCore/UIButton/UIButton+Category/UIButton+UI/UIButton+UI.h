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

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

NS_ASSUME_NONNULL_BEGIN
/// ⚠️当font描绘的文字,或者文字大于UIButton的frame,UIButton的Title将不会显现⚠️
@interface UIButton (UI)<BaseProtocol>
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
/// RAC 点击事件2次封装
-(void)jobsBtnClickEventBlock:(jobsByIDBlock)subscribeNextBlock;
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
/**
 关于UIButtonConfiguration 和 configurationUpdateHandler 的使用
 
 #import <UIKit/UIKit.h>

 // 创建一个 UIButtonConfiguration
 UIButtonConfiguration *buttonConfig = [UIButtonConfiguration plainButtonConfiguration];
 buttonConfig.title = @"按钮标题";
 buttonConfig.baseBackgroundColor = [UIColor blueColor];
 buttonConfig.contentInsets = NSDirectionalEdgeInsetsMake(10, 20, 10, 20);

 UIImage *normalImage = [UIImage imageNamed:@"normal_image"];
 buttonConfig.image = normalImage;

 // 创建一个按钮并应用配置
 UIButton *button = [UIButton buttonWithConfiguration:buttonConfig primaryAction:nil];

 // 在按钮高亮状态变化时，使用 configurationUpdateHandler 来自定义图像样式
 button.configurationUpdateHandler = ^(UIButton * _Nonnull updatedButton) {
     if (updatedButton.isHighlighted) {
         // 按钮处于高亮状态，切换到高亮状态的图像样式
         UIImage *highlightedImage = [UIImage imageNamed:@"highlighted_image"];
         updatedButton.configuration.image = highlightedImage;
     } else {
         // 按钮处于正常状态，切换到正常状态的图像样式
         UIImage *normalImage = [UIImage imageNamed:@"normal_image"];
         updatedButton.configuration.image = normalImage;
     }
 };
 */
