//
//  UIView+Extension.h
//  MJRefreshExample
//
//  Created by Aalto on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Measure.h"
#import "MacroDef_App.h"
#import "MacroDef_Size.h"
#import "MacroDef_Cor.h"
#import "UIButton+UI.h"

typedef enum : NSUInteger {
    ShadowDirection_top = 0,
    ShadowDirection_down,
    ShadowDirection_left,
    ShadowDirection_right,
    ShadowDirection_leftTop,
    ShadowDirection_leftDown,
    ShadowDirection_rightTop,
    ShadowDirection_rightDown,
    ShadowDirection_All
} ShadowDirection;

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@interface UIView (Extras)
#pragma mark —— 键盘
/// 监听键盘事件
-(void)monitorKeyboardAction;
#pragma mark —— 截屏
/*
 1、将图片存本地相册 UIImageWriteToSavedPhotosAlbum
 2、iOS安全 —— 录屏、截屏判断
    2.1、UIApplicationUserDidTakeScreenshotNotification iOS7+ 截屏事件通知
    2.2、UIScreenCapturedDidChangeNotification 判断是否在录屏状态 而当录屏状态改变时，UIKit会发送录屏通知
 */
/// 获取屏幕截图
-(UIImage *_Nullable)screenShot;
/// 获取启动页的截图
-(UIImage *_Nullable)lanuchScreenShot;
/// 获取某个view 上的截图
-(UIImage *_Nullable)viewShots;
/// 获取某个scrollview 上的截图
-(UIImage *_Nullable)scrollViewShot;
/// 获取某个 范围内的 截图
-(UIImage *_Nullable)innerViewShotAtFrame:(CGRect)rect;
#pragma mark —— 描边
/// 指定描边 【在使用这个方法的一个前提是被描边的view刷新后存在frame】
/// @param color 作用颜色
/// @param borderWidth 线宽
/// @param borderType 作用方向
-(void)setBorderWithColor:(UIColor *__nonnull)color
              borderWidth:(CGFloat)borderWidth
               borderType:(UIBorderSideType)borderType;
/// 切角
/// @param cornerRadiusValue 切角参数
-(void)cornerCutToCircleWithCornerRadius:(CGFloat)cornerRadiusValue;
/// 描边
/// @param colour 颜色
/// @param borderWidth 边线宽度
-(void)layerBorderColour:(UIColor *__nonnull)colour
          andBorderWidth:(CGFloat)borderWidth;
/// 指定圆切角
-(void)appointCornerCutToCircleByRoundingCorners:(UIRectCorner)corners
                                     cornerRadii:(CGSize)cornerRadii;
#pragma mark —— @implementation UILabel (AutoScroll)
/// 根据文字长短自动判断是否需要显示TextLayer，并且滚动
-(void)setTextLayerScroll;
/// runtime存放textLayer，避免多次生成
-(CATextLayer *_Nonnull)getTextLayer;
/// runtime存放动画对象，避免多次生成
-(CABasicAnimation *_Nonnull)getAnimation;
/// 判断是否需要滚动
-(BOOL)shouldAutoScroll;
#pragma mark —— 其他
-(BOOL)jobsVisible;
-(void)setJobsVisible:(BOOL)jobsVisible;
/// popView取消按钮常规处理方法
-(void)cancelBtnActionForPopView:(id _Nullable)object;
-(void)transformByRadians:(CGFloat)radians;
-(UIImage *_Nullable)getImage;
/// iOS 阴影效果 添加了shadowPath后消除了离屏渲染问题 。特别提示：不能存在 -(void)drawRect:(CGRect)rect 或者在-(void)drawRect:(CGRect)rect里面写，否则无效
/// @param targetShadowview 需要作用阴影效果的View
/// @param superview 该阴影效果的View的父View
/// @param ShadowDirection 阴影朝向
/// @param offsetX 贝塞尔曲线X轴偏移量
/// @param offsetY 贝塞尔曲线Y轴偏移量
/// @param cornerRadius 圆切角参数，传0表示不切
/// @param shadowOffset  阴影偏移量
/// @param shadowOpacity 阴影的不透明度,取值范围在0~1
/// @param layerShadowColor 阴影颜色
/// @param layerShadowRadius  模糊计算的半径
+(void)makeTargetShadowview:(UIView *__nonnull)targetShadowview
                  superView:(UIView *__nullable)superview
            shadowDirection:(ShadowDirection)ShadowDirection
          shadowWithOffsetX:(CGFloat)offsetX
                    offsetY:(CGFloat)offsetY
               cornerRadius:(CGFloat)cornerRadius
               shadowOffset:(CGSize)shadowOffset
              shadowOpacity:(CGFloat)shadowOpacity
           layerShadowColor:(UIColor *__nullable)layerShadowColor
          layerShadowRadius:(CGFloat)layerShadowRadius;

@end
