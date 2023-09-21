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
@property(nonatomic,assign)UIControlContentHorizontalAlignment contentHorizontalAlignment;
@property(nonatomic,assign)CGFloat contentSpacing;
@property(nonatomic,assign)NSLineBreakMode lineBreakMode;
@property(nonatomic,assign)CGFloat btnWidth;/// 预设值，父视图的宽度不能大于这个值

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
 [button setTitle:@"Centered Text" forState:UIControlStateNormal];
 [button setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];

 // 设置内容水平居中对齐
 button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

 */
