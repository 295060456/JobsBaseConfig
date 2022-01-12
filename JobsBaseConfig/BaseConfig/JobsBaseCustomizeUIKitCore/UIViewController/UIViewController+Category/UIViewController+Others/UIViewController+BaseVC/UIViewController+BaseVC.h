//
//  UIViewController+BaseVC.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UIViewModelProtocol.h"
#import "BaseViewControllerProtocol.h"
#import "JobsBlock.h"
#import "MacroDef_Func.h"
#import "LoadingImage.h"
#import "UIViewModel.h"

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

@interface UIViewController (BaseVC)
<
BaseViewControllerProtocol
,UIViewModelProtocol
>

#pragma mark —— present
/// 简洁版强制present展现一个控制器页面【不需要正向传参】
-(void)comingToPresentVC:(UIViewController *_Nonnull)viewController;
/// 简洁版强制present展现一个控制器页面【需要正向传参】
-(void)comingToPresentVC:(UIViewController *_Nonnull)viewController
           requestParams:(id _Nullable)requestParams;
#pragma mark —— push
/// 简洁版强制展现一个控制器页面【不需要正向传参】
-(void)comingToPushVC:(UIViewController *_Nonnull)viewController;
/// 简洁版强制展现一个控制器页面【需要正向传参】
-(void)comingToPushVC:(UIViewController *_Nonnull)viewController
        requestParams:(id _Nullable)requestParams;
/**
     推控制器的一种封装，可以适配App多语言化
     
     需要在具体的VC里面做如下配置：
     -(void)loadView{
         [super loadView];
         if ([self.requestParams isKindOfClass:UIViewModel.class]) {
             self.viewModel = (UIViewModel *)self.requestParams;
         }
     }
 */
-(void)comingToPushVC:(UIViewController *)viewController
         withNavTitle:(NSString *)navTitle;
/// 携带一个资源推控制器
-(void)comingToPushVC:(UIViewController *)viewController
         withNavTitle:(NSString *)navTitle
        requestParams:(id _Nullable)requestParams;
/**
 ❤️【强制推控制器】❤️
 1、自定义是PUSH还是PRESENT展现控制器，如果自定义PUSH但是navigationController不存在，则换用PRESENT展现控制器
 2、定位于@implementation UINavigationController (SafeTransition)，交换系统的push方法，防止某些情况下系统资源紧张导致的多次推控制器
 @param fromVC 从A控制器（上一个页面）
 @param toVC  推到B控制器 （下一个页面）
 @param comingStyle 自定义展现的方式
 @param presentationStyle  如果是PRESENT情况下的一个系统参数设定
 @param requestParams  A控制器—>B控制器，正向传值
 @param hidesBottomBarWhenPushed 跳转子页面的时候隐藏tabbar
 @param animated  是否动画展现
 @param successBlock 在推控制器之前，反向block(B控制器），以便对B控制器的一些自定义修改
 */
+(instancetype _Nullable)comingFromVC:(UIViewController *_Nonnull)fromVC
                                 toVC:(UIViewController *_Nonnull)toVC
                          comingStyle:(ComingStyle)comingStyle
                    presentationStyle:(UIModalPresentationStyle)presentationStyle
                        requestParams:(id _Nullable)requestParams
             hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
                             animated:(BOOL)animated
                              success:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
