//
//  UIView+Animation.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

static char *UIView_Rotate_rotateChangeAngle = "UIView_Rotate_rotateChangeAngle";
@dynamic rotateChangeAngle;

static char *UIView_Rotate_currentAngle = "UIView_Rotate_currentAngle";
@dynamic currentAngle;

static char *UIView_Rotate_durationTime = "UIView_Rotate_durationTime";
@dynamic durationTime;

static char *UIView_Rotate_delayTime = "UIView_Rotate_delayTime";
@dynamic delayTime;

static char *UIView_Rotate_isStopRotateAnimation = "UIView_Rotate_isStopRotateAnimation";
@dynamic isStopRotateAnimation;

/// 开始旋转动画
-(void)startRotateAnimation{
    @jobs_weakify(self)
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.currentAngle * (M_PI / 180.0f));
    [UIView animateWithDuration:self.durationTime
                          delay:self.delayTime
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        @jobs_strongify(self)
        self.transform = endAngle;
    } completion:^(BOOL finished) {
        @jobs_strongify(self)
        self.currentAngle += self.rotateChangeAngle;
        if (!self.isStopRotateAnimation) {
            [self startRotateAnimation];
        }
    }];
}
/// 停止旋转动画
-(void)stopRotateAnimation{
    self.isStopRotateAnimation = !self.isStopRotateAnimation;
}
/// 图片从小放大
-(void)animationAlert{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 1;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f,
                                                                                   0.01f,
                                                                                   1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f,
                                                                                   1.1f,
                                                                                   1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f,
                              @0.5f,
                              @0.75f,
                              @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation
                      forKey:nil];
}
/// 视图上下一直来回跳动的动画
-(void)视图上下一直来回跳动的动画{
    CABasicAnimation *hover = [CABasicAnimation animationWithKeyPath:@"position"];
    hover.additive = YES; // fromValue and toValue will be relative instead of absolute values
    hover.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    hover.toValue = [NSValue valueWithCGPoint:CGPointMake(0.0, -10.0)]; // y increases downwards on iOS
    hover.autoreverses = YES; // Animate back to normal afterwards
    hover.duration = 0.5; // The duration for one part of the animation (0.2 up and 0.2 down)
    hover.repeatCount = INFINITY; // The number of times the animation should repeat
    hover.removedOnCompletion = NO;//锁屏进入继续动画
    [self.layer addAnimation:hover forKey:@"myHoverAnimation"];
}
/// 点击放大再缩小
-(void)addViewAnimationWithCompletionBlock:(MKDataBlock _Nullable)completionBlock{
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:0.5
                                   delay:0
                                 options:0
                              animations:^{
        [UIView addKeyframeWithRelativeStartTime:0
                                relativeDuration:1 / 3.0
                                      animations:^{
            self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0
                                relativeDuration:1/3.0
                                      animations:^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0
                                relativeDuration:1/3.0
                                      animations:^{

            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:^(BOOL finished) {
        if (completionBlock) completionBlock(@1);
    }];
}
/// 逐渐显示
-(void)graduallyShowWithAnimationBlock:(MKDataBlock _Nullable)animationBlock
                       completionBlock:(MKDataBlock _Nullable)completionBlock{
    self.alpha = 0.0;
    @jobs_weakify(self)
    [UIView animateWithDuration:0.3
                          delay:0.05
                        options:0
                     animations:^{
        @jobs_strongify(self)
        self.alpha = 1.0;
        if (animationBlock) animationBlock(@(1));
    } completion:^(BOOL finished) {
        if (completionBlock) completionBlock(@(1));
    }];
}
/// 逐渐消退
-(void)graduallyDisappearWithAnimationBlock:(MKDataBlock _Nullable)animationBlock
                            completionBlock:(MKDataBlock _Nullable)completionBlock{
    @jobs_weakify(self)
    [UIView animateWithDuration:0.3
                          delay:0.05
                        options:0
                     animations:^{
        @jobs_strongify(self)
        self.alpha = 0.0;
        if (animationBlock) animationBlock(@(1));
    } completion:^(BOOL finished) {
        if (completionBlock) completionBlock(@(1));
    }];
}
/// 重力弹跳动画效果
void shakerAnimation (UIView *view,
                      NSTimeInterval duration,
                      float height){
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat currentTx = view.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentTx),
                         @(currentTx + height),
                         @(currentTx-height/3*2),
                         @(currentTx + height/3*2),
                         @(currentTx -height/3),
                         @(currentTx + height/3),
                         @(currentTx)];
    animation.keyTimes = @[@(0),
                           @(0.225),
                           @(0.425),
                           @(0.6),
                           @(0.75),
                           @(0.875),
                           @(1)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}
#pragma mark —— @property(nonatomic,assign)CGFloat rotateChangeAngle;
-(CGFloat)rotateChangeAngle{
    CGFloat RotateChangeAngle = [objc_getAssociatedObject(self, UIView_Rotate_rotateChangeAngle) floatValue];
    if (RotateChangeAngle == 0) {
        RotateChangeAngle = 20;
        objc_setAssociatedObject(self,
                                 UIView_Rotate_rotateChangeAngle,
                                 [NSNumber numberWithFloat:RotateChangeAngle],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return RotateChangeAngle;
}

-(void)setRotateChangeAngle:(CGFloat)rotateChangeAngle{
    objc_setAssociatedObject(self,
                             UIView_Rotate_rotateChangeAngle,
                             [NSNumber numberWithFloat:rotateChangeAngle],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)__block CGFloat currentAngle;
-(CGFloat)currentAngle{
    return [objc_getAssociatedObject(self, UIView_Rotate_currentAngle) floatValue];
}

-(void)setCurrentAngle:(CGFloat)currentAngle{
    objc_setAssociatedObject(self,
                             UIView_Rotate_currentAngle,
                             [NSNumber numberWithFloat:currentAngle],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat durationTime;
-(CGFloat)durationTime{
    CGFloat DurationTime = [objc_getAssociatedObject(self, UIView_Rotate_durationTime) floatValue];
    if (DurationTime == 0) {
        DurationTime = 0.1;//缺省值
    }return DurationTime;
}

-(void)setDurationTime:(CGFloat)durationTime{
    objc_setAssociatedObject(self,
                             UIView_Rotate_durationTime,
                             [NSNumber numberWithFloat:durationTime],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat delayTime;
-(CGFloat)delayTime{
    CGFloat DelayTime = [objc_getAssociatedObject(self, UIView_Rotate_delayTime) floatValue];
    if (DelayTime == 0) {
        DelayTime = 0.01;//缺省值
    }return DelayTime;
}

-(void)setDelayTime:(CGFloat)delayTime{
    objc_setAssociatedObject(self,
                             UIView_Rotate_delayTime,
                             [NSNumber numberWithFloat:delayTime],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)BOOL isStopRotateAnimation;//默认值为NO（一直旋转）
-(BOOL)isStopRotateAnimation{
    return [objc_getAssociatedObject(self, UIView_Rotate_isStopRotateAnimation) boolValue];
}

-(void)setIsStopRotateAnimation:(BOOL)isStopRotateAnimation{
    objc_setAssociatedObject(self,
                             UIView_Rotate_isStopRotateAnimation,
                             [NSNumber numberWithBool:isStopRotateAnimation],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
