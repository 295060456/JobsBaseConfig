//
//  JobsBtnModel.h
//  MataShop
//
//  Created by Jobs Hi on 9/21/23.
//

#import <Foundation/Foundation.h>
#import "BaseButtonProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsBtnModel : NSObject<BaseButtonProtocol>

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
 
 调用示例：
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
