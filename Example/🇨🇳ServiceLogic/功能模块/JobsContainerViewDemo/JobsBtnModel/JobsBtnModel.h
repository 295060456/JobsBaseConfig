//
//  JobsBtnModel.h
//  MataShop
//
//  Created by Jobs Hi on 9/21/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsBtnModel : NSObject

@property(nonatomic,strong)UIColor *backgroundColor;
@property(nonatomic,strong)UIImage *backgroundImage;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,assign)CGSize imageSize;
@property(nonatomic,assign)UIControlContentHorizontalAlignment contentHorizontalAlignment;/// 结合下列属性来实现改变Button文字位置
@property(nonatomic,assign)UIEdgeInsets contentEdgeInsets;/// iOS 15以前可以用
@property(nonatomic,readwrite,assign)NSDirectionalEdgeInsets contentInsets;/// iOS 15以后 结合UIButtonConfiguration 以替换属性：UIEdgeInsets contentEdgeInsets;
@property(nonatomic,assign)CGFloat contentSpacing;
@property(nonatomic,assign)NSLineBreakMode lineBreakMode;
@property(nonatomic,assign)CGFloat btnWidth;/// 预设值，父视图的宽度不能大于这个值

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
 [button setTitle:@"Centered Text" forState:UIControlStateNormal];
 [button setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];

 // 设置内容水平居中对齐
 button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

 */
