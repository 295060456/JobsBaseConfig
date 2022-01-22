//
//  UIView+AutoSelfAdaptionSize.h
//  Casino
//
//  Created by Jobs on 2021/12/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
/**
 https://github.com/zhuchenglong/LabelDemo
 https://www.jianshu.com/p/37b3e382dcab
 */
NS_ASSUME_NONNULL_BEGIN
/// UIView & UIButton 文字自适应
@interface UIView (AutoSelfAdaptionSize)
#pragma mark —— UILabel
/// 确定Label的字体大小，使其宽度自适应
-(void)labelAutoWidthByFont;
/// 确定Label的宽度，使字体大小自适应
-(void)labelAutoFontByWidth;
#pragma mark —— UIButton
/*
 特别说明：
 【优先级】 @implementation UIView (Measure) > Masonry,因为Masonry刷新后才有frame
 -(void)buttonAutoWidthByFont 和 -(void)buttonAutoFontByWidth 也会刷新UI ❤️请结合Masonry进行使用❤️ layoutIfNeeded出最终结果
 如果使用  @implementation UIView (Measure)，则有可能会刷新异常。比如，buttonAutoWidthByFont 会得出0宽度
 */
/// 确定Button的字体大小，使其宽度自适应
-(void)buttonAutoWidthByFont;
/// 确定Button的宽度，使字体大小自适应
-(void)buttonAutoFontByWidth;
/****自适应宽度****/
-(CGRect)getFrameWithFreeWidth:(CGPoint)origin
                      maxHight:(CGFloat)maxHight;
/****自适应高度****/
-(CGRect)getFrameWithFreeHight:(CGPoint)origin
                      maxWidth:(CGFloat)maxWidth;
/****自适应宽度--->可调整字间距****/
-(CGRect)getFrameWithFreeWidth:(CGPoint)origin
                      maxHight:(CGFloat)maxHight
                     textSpace:(CGFloat)textSpace;
/****自适应高度--->可调整字间距和行间距****/
-(CGRect)getFrameWithFreeHight:(CGPoint)origin
                      maxWidth:(CGFloat)maxWidth
                     textSpace:(CGFloat)textSpace
                     lineSpace:(CGFloat)lineSpace;
@end

NS_ASSUME_NONNULL_END
