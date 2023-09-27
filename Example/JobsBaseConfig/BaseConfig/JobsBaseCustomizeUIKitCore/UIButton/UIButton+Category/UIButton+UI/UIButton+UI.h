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
#import "BaseButtonProtocol.h"

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

NS_ASSUME_NONNULL_BEGIN
/// ⚠️当font描绘的文字,或者文字大于UIButton的frame,UIButton的Title将不会显现⚠️
@interface UIButton (UI)<BaseProtocol,BaseButtonProtocol>
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
 UIControlContentHorizontalAlignment 是一个枚举类型，用于定义控件中内容（例如文字或图像）在水平方向上的对齐方式。
 这个枚举通常用于控制UIButton等UI控件中内容的水平对齐方式。

 以下是UIControlContentHorizontalAlignment枚举的常见值和它们的含义：
 UIControlContentHorizontalAlignmentLeft：内容水平左对齐。
 UIControlContentHorizontalAlignmentCenter：内容水平居中对齐。
 UIControlContentHorizontalAlignmentRight：内容水平右对齐。
 UIControlContentHorizontalAlignmentFill：内容水平填充整个控件的宽度，通常用于将内容拉伸以填满整个控件。

 这些对齐方式可用于控制按钮内部文本和图像在按钮内的水平位置。
 例如，你可以将按钮的内容水平居中对齐，以确保文本或图像在按钮的中心位置。
 
 示例代码：
 UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 // 设置内容水平居中对齐
 button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
 */

/**
 利用 UIButtonConfiguration 来解决问题，示例：
 -(UIButtonConfiguration *)btnConfig{
     if(!_btnConfig){
         _btnConfig = UIButtonConfiguration.filledButtonConfiguration;
         {// 图片
             _btnConfig.image = JobsIMG(@"入职Mata"); // 替换为你的图像名称
             _btnConfig.imagePlacement = NSDirectionalRectEdgeLeading;// 这里将图像放置在标题的前面
             _btnConfig.imagePadding = 10;// 设置图像与标题之间的间距
         }
         
         {// 一般的文字
             _btnConfig.title = Internationalization(@"入职Mata");
             _btnConfig.subtitle = @"";
             _btnConfig.baseForegroundColor = UIColor.blackColor;// 前景颜色（= 文字颜色）
         }
         
         {// 富文本
             // 设置按钮标题的文本属性
             _btnConfig.titleTextAttributesTransformer = ^NSDictionary<NSAttributedStringKey, id> *(NSDictionary<NSAttributedStringKey, id> *textAttributes) {
                 NSMutableDictionary<NSAttributedStringKey, id> *newTextAttributes = textAttributes.mutableCopy;
                 [newTextAttributes addEntriesFromDictionary:@{
                     NSFontAttributeName:UIFontWeightRegularSize(14), // 替换为你想要的字体和大小
                     NSForegroundColorAttributeName: UIColor.blackColor // 替换为你想要的文本颜色
                 }];
                 return newTextAttributes.copy;
             };
             _btnConfig.attributedTitle = [NSAttributedString.alloc initWithString:Internationalization(@"入职Mata") attributes:@{NSForegroundColorAttributeName:UIColor.blackColor}];
         }
         
         {// 其他
             _btnConfig.baseBackgroundColor = UIColor.whiteColor;// 背景颜色
             _btnConfig.contentInsets = NSDirectionalEdgeInsetsMake(0, 0, 0, 0); // 内边距
         }
     }return _btnConfig;
 }

 -(UIButton *)btn1{
     if(!_btn1){
         if(self.deviceSystemVersion.floatValue >= 15.0){
             _btn1 = [UIButton buttonWithConfiguration:self.btnConfig primaryAction:nil];
         }else{
             _btn1 = UIButton.new;
             _btn1.normalImage = JobsIMG(@"入职Mata");
             _btn1.titleFont = UIFontWeightRegularSize(14);
             _btn1.normalTitle = Internationalization(@"入职Mata");
             _btn1.normalTitleColor = JobsBlackColor;
 
         // 在按钮高亮状态变化时，使用 configurationUpdateHandler 来自定义图像样式
         // 关于UIButtonConfiguration 和 configurationUpdateHandler 的使用
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
         }
         // 添加按钮到视图中
         [self addSubview:_btn1];
         [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(JobsWidth(85), JobsWidth(16)));
             make.centerY.equalTo(self);
             make.left.equalTo(self).offset(JobsWidth(6));
         }];
         if(self.deviceSystemVersion.floatValue < 15.0){
             [_btn1 layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:JobsWidth(8)];
         }
     }return _btn1;
 }
 */
