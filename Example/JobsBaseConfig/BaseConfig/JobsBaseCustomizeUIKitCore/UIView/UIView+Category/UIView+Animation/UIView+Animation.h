//
//  UIView+Animation.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "JobsBlock.h"

#if __has_include(<ReactiveObjC/RACmetamacros.h>)
#import <ReactiveObjC/RACmetamacros.h>
#else
#import "RACmetamacros.h"
#endif

#if __has_include(<ReactiveObjC/RACEXTScope.h>)
#import <ReactiveObjC/RACEXTScope.h>
#else
#import "RACEXTScope.h"
#endif

#if __has_include(<ReactiveObjC/RACEXTKeyPathCoding.h>)
#import <ReactiveObjC/RACEXTKeyPathCoding.h>
#else
#import "RACEXTKeyPathCoding.h"
#endif

//#if __has_include(<ReactiveObjC/RACEXTRuntimeExtensions.h>)
//#import <ReactiveObjC/RACEXTRuntimeExtensions.h>
//#else
//#import "RACEXTRuntimeExtensions.h"
//#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)

#pragma mark —— 旋转动画
@property(nonatomic,assign)CGFloat rotateChangeAngle;
@property(nonatomic,assign)__block CGFloat currentAngle;
@property(nonatomic,assign)CGFloat durationTime;
@property(nonatomic,assign)CGFloat delayTime;
@property(nonatomic,assign)BOOL isStopRotateAnimation;//默认值为NO（一直旋转）

/// 开始旋转动画
-(void)startRotateAnimation;
/// 停止旋转动画
-(void)stopRotateAnimation;
/// 图片从小放大
-(void)animationAlert;
/// 视图上下一直来回跳动的动画
-(void)视图上下一直来回跳动的动画;
/// 点击放大再缩小
-(void)addViewAnimationWithCompletionBlock:(MKDataBlock _Nullable)completionBlock;
/// 逐渐显示
-(void)graduallyShowWithAnimationBlock:(MKDataBlock _Nullable)animationBlock
                       completionBlock:(MKDataBlock _Nullable)completionBlock;
/// 逐渐消退
-(void)graduallyDisappearWithAnimationBlock:(MKDataBlock _Nullable)animationBlock
                            completionBlock:(MKDataBlock _Nullable)completionBlock;
/// 重力弹跳动画效果
void shakerAnimation (UIView *view,
                      NSTimeInterval duration,
                      float height);

@end

NS_ASSUME_NONNULL_END
