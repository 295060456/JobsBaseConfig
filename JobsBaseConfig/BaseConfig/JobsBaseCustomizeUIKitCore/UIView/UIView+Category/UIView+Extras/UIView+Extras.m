//
//  UIView+Extension.m
//  MJRefreshExample
//
//  Created by Aalto on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIView+Extras.h"

static const void *leftLittleButtonEventBlockKey = &leftLittleButtonEventBlockKey;
static const void *leftButtonEventBlockKey = &leftButtonEventBlockKey;
static const void *rightButtonEventBlockKey = &rightButtonEventBlockKey;

@implementation UIView (Extras)

static char *UIView_Extras_visible = "UIView_Extras_visible";
@dynamic visible;

/// 指定描边
/// @param view 作用view
/// @param color 作用颜色
/// @param width 线宽
/// @param borderType 作用方向
+ (void)setBorderWithView:(UIView *__nonnull)view
              borderColor:(UIColor *__nonnull)color
              borderWidth:(CGFloat)width
               borderType:(UIBorderSideType)borderType{
    /// 左
    if (borderType & UIBorderSideTypeLeft) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0,
                                 0,
                                 width,
                                 view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    /// 右
    if (borderType & UIBorderSideTypeRight){
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width,
                                 0,
                                 width,
                                 view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    /// 上
    if (borderType & UIBorderSideTypeTop) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0,
                                 0,
                                 view.frame.size.width,
                                 width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    /// 下
    if (borderType & UIBorderSideTypeBottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0,
                                 view.frame.size.height - width,
                                 view.frame.size.width,
                                 width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}
/**
 切角
 
 @param view TargetView
 @param cornerRadiusValue 切角参数
 */
+(void)cornerCutToCircleWithView:(UIView *__nonnull)view
                 andCornerRadius:(CGFloat)cornerRadiusValue{
    view.layer.cornerRadius = cornerRadiusValue;
    view.layer.masksToBounds = YES;
}
/**
 描边
 
 @param view TargetView
 @param colour 颜色
 @param WidthOfBorder 边线宽度
 */
+(void)colourToLayerOfView:(UIView *__nonnull)view
                withColour:(UIColor *__nonnull)colour
            andBorderWidth:(CGFloat)WidthOfBorder{
    view.layer.borderColor = colour.CGColor;
    view.layer.borderWidth = WidthOfBorder;
}
/**
 *  指定圆切角
 */
+(void)appointCornerCutToCircleWithTargetView:(UIView *__nonnull)targetView
                            byRoundingCorners:(UIRectCorner)corners
                                  cornerRadii:(CGSize)cornerRadii{
    //设置切哪个直角
    //    UIRectCornerTopLeft     = 1 << 0,  左上角
    //    UIRectCornerTopRight    = 1 << 1,  右上角
    //    UIRectCornerBottomLeft  = 1 << 2,  左下角
    //    UIRectCornerBottomRight = 1 << 3,  右下角
    //    UIRectCornerAllCorners  = ~0UL     全部角
    if (CGSizeEqualToSize(cornerRadii, CGSizeZero)) {
        cornerRadii = CGSizeMake(10,10);
    }
    //得到view的遮罩路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:targetView.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    //创建 layer
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = targetView.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    targetView.layer.mask = maskLayer;
}

-(void)transformByRadians:(CGFloat)radians{
    self.transform = CGAffineTransformMakeRotation(M_PI * radians);
    //    使用:例如逆时针旋转40度
    //    [setTransform:40/180 forLable:label]
}

+ (UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,
                                           NO,
                                           [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
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
          layerShadowRadius:(CGFloat)layerShadowRadius{
    
    targetShadowview.layer.cornerRadius = cornerRadius;//圆切角
    
    if (superview && CGRectEqualToRect(targetShadowview.frame,CGRectZero)) {
        [superview layoutIfNeeded];//targetShadowview当在某些masonry约束的时候，没有frame,需要进行刷新得到frame，否则不会出现阴影效果
    }
    
    targetShadowview.layer.shadowOpacity = (shadowOpacity != 0) ? : 0.7f;//shadowOpacity设置了阴影的不透明度,取值范围在0~1;
    targetShadowview.layer.shadowOffset = shadowOffset;//阴影偏移量
    targetShadowview.layer.shadowColor = (layerShadowColor ? :KDarkGrayColor).CGColor;//阴影颜色   KLightGrayColor.CGColor;
    targetShadowview.layer.shadowRadius = (layerShadowRadius != 0) ? : 8.0f;//模糊计算的半径
    
    UIBezierPath *path = UIBezierPath.bezierPath;

    //偏移量保持为正数，便于后续计算
    offsetX = offsetX >= 0 ? offsetX : -offsetX;
    offsetY = offsetY >= 0 ? offsetY : -offsetY;
    //偏移量默认值
    offsetX = offsetX != 0 ? :20;
    offsetY = offsetY != 0 ? :20;

    switch (ShadowDirection) {
        case ShadowDirection_top:{
            [path moveToPoint:CGPointMake(0, -offsetY)];//左上角为绘制的贝塞尔曲线原点
            [path addLineToPoint:CGPointMake(0, targetShadowview.height)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width, targetShadowview.height)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width, -offsetY)];//👆
        }break;
        case ShadowDirection_down:{
            [path moveToPoint:CGPointMake(0, 0)];//左上角为绘制的贝塞尔曲线原点
            [path addLineToPoint:CGPointMake(0, targetShadowview.height + offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width, targetShadowview.height + offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width, 0)];//👆
        }break;
        case ShadowDirection_left:{
            [path moveToPoint:CGPointMake(offsetX, 0)];//左上角
            [path addLineToPoint:CGPointMake(offsetX, targetShadowview.height)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width, targetShadowview.height)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width, 0)];//👆
        }break;
        case ShadowDirection_right:{
            [path moveToPoint:CGPointMake(0, 0)];//左上角
            [path addLineToPoint:CGPointMake(0, targetShadowview.height)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, targetShadowview.height)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, 0)];//👆
        }break;
        case ShadowDirection_leftTop:{
            [path moveToPoint:CGPointMake(-offsetX, -offsetY)];//左上角
            [path addLineToPoint:CGPointMake(-offsetX, targetShadowview.height - offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width - offsetX, targetShadowview.height - offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width - offsetX, -offsetY)];//👆
        }break;
        case ShadowDirection_leftDown:{
            [path moveToPoint:CGPointMake(-offsetX, offsetY)];//左上角
            [path addLineToPoint:CGPointMake(-offsetX, targetShadowview.height + offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width - offsetX, targetShadowview.height + offsetX)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width - offsetX, offsetY)];//👆
        }break;
        case ShadowDirection_rightTop:{
            [path moveToPoint:CGPointMake(offsetX, -offsetY)];//左上角
            [path addLineToPoint:CGPointMake(offsetX, targetShadowview.height - offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, targetShadowview.height - offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, -offsetY)];//👆
        }break;
        case ShadowDirection_rightDown:{
            [path moveToPoint:CGPointMake(offsetX, offsetY)];//左上角
            [path addLineToPoint:CGPointMake(offsetX, targetShadowview.height + offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, targetShadowview.height + offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, offsetY)];//👆
        }break;
        case ShadowDirection_All:{
            [path moveToPoint:CGPointMake(-offsetX, -offsetY)];//左上角
            [path addLineToPoint:CGPointMake(-offsetX, targetShadowview.height + offsetY)];//👇
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, targetShadowview.height + offsetY)];//👉
            [path addLineToPoint:CGPointMake(targetShadowview.width + offsetX, -offsetY)];//👆
        }break;
            
        default:
            break;
    }
    
    targetShadowview.layer.shadowPath = path.CGPath;
}
/// 监听键盘事件
-(void)monitorKeyboardAction{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];

}

-(void)keyboardWillShow:(NSNotification *)notification {}
-(void)keyboardWillHide:(NSNotification *)notification {}
#pragma mark —— @property(nonatomic,assign)BOOL visible;
-(BOOL)visible{
    BOOL Visible = [objc_getAssociatedObject(self, UIView_Extras_visible) boolValue];
    return Visible;
}

-(void)setVisible:(BOOL)visible{
    self.hidden = !visible;
    self.alpha = visible;
    objc_setAssociatedObject(self,
                             UIView_Extras_visible,
                             [NSNumber numberWithBool:visible],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

