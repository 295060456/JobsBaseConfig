//
//  BaseVCProtocol.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
#import "JobsBlock.h"

#if __has_include(<SPAlertController/SPAlertController.h>)
#import <SPAlertController/SPAlertController.h>
#else
#import "SPAlertController.h"
#endif

@class JobsBasePopupView;

typedef enum : NSUInteger {
    ComingStyle_PUSH = 0,
    ComingStyle_PRESENT
} ComingStyle;

typedef id _Nullable (^JobsViewControllerLifeCycleBlock)(NSString * _Nonnull lifeCycleName,id _Nullable data);

NS_ASSUME_NONNULL_BEGIN

@protocol BaseViewControllerProtocol<BaseViewProtocol>

@optional
/// UI
@property(nonatomic,weak)UIViewController *fromVC;
@property(nonatomic,strong,nullable)SPAlertController *alertController;
@property(nonatomic,assign)ComingStyle pushOrPresent;
@property(nonatomic,assign)BOOL setupNavigationBarHidden;
@property(nonatomic,copy)JobsViewControllerLifeCycleBlock vcLifeCycleBlock;/// 用于检测生命周期
/// 查看用户数据
-(void)showUserInfo;
/// 配置GKNavigationBar
-(void)setGKNav;
/// 配置GKNavigationBar的返回按钮
-(void)setGKNavBackBtn;
/// 铺满全屏展示的策略
-(void)fullScreenConstraintTargetView:(nonnull __kindof UIView *)view
                        topViewOffset:(CGFloat)topViewOffset;
/// 用于检测生命周期
-(void)actionVCLifeCycleBlock:(JobsViewControllerLifeCycleBlock)vcLifeCycleBlock;

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize BaseViewControllerProtocol
#ifndef BaseViewControllerProtocol_synthesize
#define BaseViewControllerProtocol_synthesize \
@synthesize fromVC = _fromVC;\
@synthesize alertController = _alertController;\
@synthesize pushOrPresent = _pushOrPresent;\
@synthesize setupNavigationBarHidden = _setupNavigationBarHidden;\

#endif

#pragma mark —— @dynamic BaseViewControllerProtocol
#ifndef BaseViewControllerProtocol_dynamic
#define BaseViewControllerProtocol_dynamic \
@dynamic fromVC;\
@dynamic alertController;\
@dynamic pushOrPresent;\
@dynamic setupNavigationBarHidden;\

#endif
