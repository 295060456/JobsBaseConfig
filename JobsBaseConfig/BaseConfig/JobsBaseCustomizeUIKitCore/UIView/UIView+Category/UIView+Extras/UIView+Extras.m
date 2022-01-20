//
//  UIView+Extension.m
//  MJRefreshExample
//
//  Created by Aalto on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIView+Extras.h"

@implementation UIView (Extras)

static char *UIView_Extras_visible = "UIView_Extras_visible";
@dynamic visible;

/// 指定描边
/// @param color 作用颜色
/// @param width 线宽
/// @param borderType 作用方向
-(void)setBorderWithColor:(UIColor *__nonnull)color
              borderWidth:(CGFloat)width
               borderType:(UIBorderSideType)borderType{
    /// 左
    if (borderType & UIBorderSideTypeLeft) {
        CALayer *layer = CALayer.layer;
        layer.frame = CGRectMake(0,
                                 0,
                                 width,
                                 self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    /// 右
    if (borderType & UIBorderSideTypeRight){
        CALayer *layer = CALayer.layer;
        layer.frame = CGRectMake(self.frame.size.width - width,
                                 0,
                                 width,
                                 self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    /// 上
    if (borderType & UIBorderSideTypeTop) {
        CALayer *layer = CALayer.layer;
        layer.frame = CGRectMake(0,
                                 0,
                                 self.frame.size.width,
                                 width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    /// 下
    if (borderType & UIBorderSideTypeBottom) {
        CALayer *layer = CALayer.layer;
        layer.frame = CGRectMake(0,
                                 self.frame.size.height - width,
                                 self.frame.size.width,
                                 width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}
/// 切角
/// @param cornerRadiusValue 切角参数
-(void)cornerCutToCircleWithCornerRadius:(CGFloat)cornerRadiusValue{
    self.layer.cornerRadius = cornerRadiusValue;
    self.layer.masksToBounds = YES;
}
/// 描边
/// @param colour 颜色
/// @param WidthOfBorder 边线宽度
-(void)colourToLayerwithColour:(UIColor *__nonnull)colour
                andBorderWidth:(CGFloat)WidthOfBorder{
    self.layer.borderColor = colour.CGColor;
    self.layer.borderWidth = WidthOfBorder;
}
/// 指定圆切角
-(void)appointCornerCutToCircleByRoundingCorners:(UIRectCorner)corners
                                     cornerRadii:(CGSize)cornerRadii{
    // 设置切哪个直角
    //    UIRectCornerTopLeft     = 1 << 0,  左上角
    //    UIRectCornerTopRight    = 1 << 1,  右上角
    //    UIRectCornerBottomLeft  = 1 << 2,  左下角
    //    UIRectCornerBottomRight = 1 << 3,  右下角
    //    UIRectCornerAllCorners  = ~0UL     全部角
    if (CGSizeEqualToSize(cornerRadii, CGSizeZero)) {
        cornerRadii = CGSizeMake(self.width / 2,self.height / 2);
    }
    /// 得到view的遮罩路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    /// 创建 layer
    CAShapeLayer *maskLayer = CAShapeLayer.new;
    maskLayer.frame = self.bounds;
    /// 赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)transformByRadians:(CGFloat)radians{
    self.transform = CGAffineTransformMakeRotation(M_PI * radians);
    // 使用:例如逆时针旋转40度
    // [setTransform:40/180 forLable:label]
}

-(UIImage *_Nullable)getImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,
                                           NO,
                                           UIScreen.mainScreen.scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
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
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];

}

-(void)keyboardWillShow:(NSNotification *)notification {}
-(void)keyboardWillHide:(NSNotification *)notification {}
/// 根据文字长短自动判断是否需要显示TextLayer，并且滚动
-(void)setTextLayerScroll{
    CATextLayer * textLayer = self.getTextLayer;
    if (self.shouldAutoScroll){
        CABasicAnimation * ani = self.getAnimation;
        [textLayer addAnimation:ani forKey:nil];
        [self.layer addSublayer:textLayer];
    }else{
        [textLayer removeAllAnimations];
        [textLayer removeFromSuperlayer];
    }
}
/// runtime存放textLayer，避免多次生成
-(CATextLayer *_Nonnull)getTextLayer{
    CATextLayer * layer = objc_getAssociatedObject(self, _cmd);
    if (!layer) {
        layer = CATextLayer.layer;
        objc_setAssociatedObject(self,
                                 _cmd,
                                 layer,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    if ([self isKindOfClass:UILabel.class]) {
        UILabel *label = (UILabel *)self;
        CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
        CGFloat stringWidth = size.width;
        layer.frame = CGRectMake(0, 0, stringWidth, self.frame.size.height);
        layer.alignmentMode = kCAAlignmentCenter;
        layer.font = (__bridge CFTypeRef _Nullable)(label.font.fontName);
        layer.fontSize = label.font.pointSize;
        layer.foregroundColor = label.textColor.CGColor;
        layer.string = label.text;
    }else if ([self isKindOfClass:UIButton.class]){
        UIButton *button = (UIButton *)self;
        CGSize size = [button.titleForNormalState sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
        CGFloat stringWidth = size.width;
        layer.frame = CGRectMake(0, 0, stringWidth, self.frame.size.height);
        layer.alignmentMode = kCAAlignmentCenter;
        layer.font = (__bridge CFTypeRef _Nullable)(button.titleLabel.font.fontName);
        layer.fontSize = button.titleLabel.font.pointSize;
        layer.foregroundColor = button.titleLabel.textColor.CGColor;
        layer.string = button.titleForNormalState;
    }else{}
    layer.contentsScale = UIScreen.mainScreen.scale;// 不写这句可能导致layer的文字在某些情况下不清晰
    return layer;
}
/// runtime存放动画对象，避免多次生成
-(CABasicAnimation *_Nonnull)getAnimation{
    
    CABasicAnimation * ani = objc_getAssociatedObject(self, _cmd);
    if (!ani) {
        ani = [CABasicAnimation animationWithKeyPath:@"position.x"];
        objc_setAssociatedObject(self,
                                 _cmd,
                                 ani,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    CATextLayer * textLayer = self.getTextLayer;
    CGPoint point = textLayer.position;
    CGFloat lenth = textLayer.frame.size.width - self.frame.size.width;
    // 起点位置
    CGPoint pointSrc = CGPointMake(point.x + 20, point.y);
    // 终点位置
    CGPoint pointDes = CGPointMake(pointSrc.x - lenth - 30, pointSrc.y);
    id toValue = [NSValue valueWithCGPoint:pointDes];
    id fromValue = [NSValue valueWithCGPoint:pointSrc];
    ani.toValue = toValue;
    ani.fromValue = fromValue;
    ani.duration = 2;
    ani.fillMode = kCAFillModeBoth;
    ani.repeatCount = HUGE_VALF;
    // 结束后逆向执行动画
    ani.autoreverses = YES;
    ani.removedOnCompletion = false;
    return ani;
}
/// 判断是否需要滚动
-(BOOL)shouldAutoScroll{
    BOOL shouldScroll = false;
    if ([self isKindOfClass:UILabel.class]) {
        UILabel *label = (UILabel *)self;
        if (label.numberOfLines == 1) {
            CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
            CGFloat stringWidth = size.width;
            CGFloat labelWidth = self.frame.size.width;
            if (labelWidth < stringWidth) {
                shouldScroll = true;
            }
        }
    }else if ([self isKindOfClass:UIButton.class]){
        UIButton *button = (UIButton *)self;
        if (button.titleLabel.numberOfLines == 1) {
            CGSize size = [button.titleForNormalState sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
            CGFloat stringWidth = size.width;
            CGFloat labelWidth = self.frame.size.width;
            if (labelWidth < stringWidth) {
                shouldScroll = true;
            }
        }
    }else{}

    Class ModelClass = NSClassFromString(@"_UIAlertControllerActionView");
    if ([self.superview.superview isKindOfClass:ModelClass]) {
        shouldScroll = false;
    }
    
    return shouldScroll;
}
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

