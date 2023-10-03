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
#import "UIView+Extras.h"

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

NS_ASSUME_NONNULL_BEGIN
/// ⚠️当font描绘的文字,或者文字大于UIButton的frame,UIButton的Title将不会显现⚠️
@interface UIButton (UI)<BaseProtocol,BaseButtonProtocol>
#pragma mark —— 一些功能性
/// 为了兼容新的Api，批量设定UIButton
/// 资料来源：https://www.jianshu.com/p/12426709420e
/// - Parameters:
///   - btnConfiguration: 来自新Api的配置文件。UIButtonConfiguration.filledButtonConfiguration;
///   - normalImage: 正常情况下的image
///   - highlightImage: 高亮情况下的image
///   - attributedTitle: 主标题的富文本（优先级高于普通文本）
///   - selectedAttributedTitle: UIControlStateSelected状态下的标题富文本
///   - attributedSubtitle: 副标题的富文本（优先级高于普通文本）
///   - title: 主标题
///   - subTitle: 副标题（新Api才有的）
///   - titleFont: 主标题字体
///   - subTitleFont: 副标题字体
///   - titleCor: 主标题文字颜色
///   - subTitleCor: 副标题文字颜色
///   - baseBackgroundColor: 背景颜色
///   - imagePlacement: 表示一个矩形的边缘或方向
///   - imagePadding: 图像与标题之间的间距
///   - contentInsets: 定位内边距的方向
///   - cornerRadiusValue: 圆切角—作用于所有的角
///   - roundingCorners: 圆切角—作用于指定的方位
///   - roundingCornersRadii: 圆切角—指定方位的Size大小
///   - layerBorderCor: 描边的颜色
///   - borderWidth: 描边线的宽度
///   - primaryAction: 新Api的点击事件
///   - clickEventBlock: 老Api的点击事件，利用RAC实现
///   如果同时设置 clickEventBlock 和 primaryAction，会优先响应新的Api，再响应老的Api
-(instancetype)jobsInitBtnByConfiguration:(UIButtonConfiguration *_Nullable)btnConfiguration
                              normalImage:(UIImage *_Nullable)normalImage
                           highlightImage:(UIImage *_Nullable)highlightImage
                          attributedTitle:(NSAttributedString *_Nullable)attributedTitle
                  selectedAttributedTitle:(NSAttributedString *_Nullable)selectedAttributedTitle
                       attributedSubtitle:(NSAttributedString *_Nullable)attributedSubtitle
                                    title:(NSString *_Nullable)title
                                 subTitle:(NSString *_Nullable)subTitle
                                titleFont:(UIFont *_Nullable)titleFont
                             subTitleFont:(UIFont *_Nullable)subTitleFont
                                 titleCor:(UIColor *_Nullable)titleCor
                              subTitleCor:(UIColor *_Nullable)subTitleCor
                      baseBackgroundColor:(UIColor *_Nullable)baseBackgroundColor
                           imagePlacement:(NSDirectionalRectEdge)imagePlacement
                             imagePadding:(CGFloat)imagePadding
                            contentInsets:(NSDirectionalEdgeInsets)contentInsets
                        cornerRadiusValue:(CGFloat)cornerRadiusValue
                          roundingCorners:(UIRectCorner)roundingCorners
                     roundingCornersRadii:(CGSize)roundingCornersRadii
                           layerBorderCor:(UIColor *_Nullable)layerBorderCor
                              borderWidth:(CGFloat)borderWidth
                            primaryAction:(UIAction *_Nullable)primaryAction
                          clickEventBlock:(JobsReturnIDByIDBlock _Nullable)clickEventBlock;
/// RAC 点击事件2次封装
-(RACDisposable *)jobsBtnClickEventBlock:(JobsReturnIDByIDBlock)subscribeNextBlock;
/// 方法名字符串（带参数、参数之间用"："隔开）、作用对象、参数
-(JobsReturnIDByThreeIDBlock)btnClickActionWithParamarrays;
/// 方法名字符串（不带参数）、作用对象
-(JobsReturnIDByTwoIDBlock)btnClickActionWithMethodName;
/// 代码触发点击调用
-(void)actionByCode;
/// UIButton 上的 image 旋转一定的角度angle
-(void)changeAction:(CGFloat)angle;
/// 当Button不可用的时候，需要做些什么
-(jobsByBOOLBlock _Nonnull)enabledBlock;
#pragma mark —— UIButton普通文本的通用设置
/// 代码触发点击调用
-(void)titleFont:(UIFont *)font;
-(void)titleAlignment:(NSTextAlignment)textAlignment;
/// 换行显示
-(void)makeNewLineShows:(BOOL)breakLine;
#pragma mark —— UIButton.UIControlStateNormal.set
-(void)normalImage:(UIImage *)image;
-(void)normalBackgroundImage:(UIImage *)backgroundImage;
-(void)normalTitle:(NSString *)title;
-(void)normalTitleColor:(UIColor *)titleColor;
-(void)normalAttributedTitle:(NSAttributedString *)title;
#pragma mark —— UIButton.UIControlStateNormal.get
-(nullable UIImage *)imageForNormalState;
-(nullable UIImage *)backgroundImageForNormalState;
-(nullable NSString *)titleForNormalState;
-(nullable UIColor *)titleColorForNormalState;
-(nullable NSAttributedString *)attributedTitleForNormalState;
#pragma mark —— UIButton.UIControlStateSelected.set
-(void)selectedImage:(UIImage *)image;
-(void)selectedBackgroundImage:(UIImage *)backgroundImage;
-(void)selectedTitle:(NSString *)title;
-(void)selectedTitleColor:(UIColor *)titleColor;
/// 富文本
-(void)selectedAttributedTitle:(NSAttributedString *)title;
#pragma mark —— UIButton.UIControlStateSelected.get
-(nullable UIImage *)imageForSelectedState;
-(nullable UIImage *)backgroundImageForSelectedState;
-(nullable NSString *)titleForSelectedState;
-(nullable UIColor *)titleColorForSelectedState;
-(nullable NSAttributedString *)attributedTitleForSelectedState;

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
             [_btn1 layoutButtonWithEdgeInsetsStyle:NSDirectionalRectEdgeLeading imagePadding:JobsWidth(8)];
         }
     }return _btn1;
 }
 */
