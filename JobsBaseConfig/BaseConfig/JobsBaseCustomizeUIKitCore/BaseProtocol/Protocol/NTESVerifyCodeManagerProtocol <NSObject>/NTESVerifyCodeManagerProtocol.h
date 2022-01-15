//
//  NTESVerifyCodeManagerProtocol.h
//  Casino
//
//  Created by Jobs on 2022/1/12.
//

#import <Foundation/Foundation.h>

#if __has_include(<VerifyCode/NTESVerifyCodeManager.h>)
#import <VerifyCode/NTESVerifyCodeManager.h>
#else
#import "NTESVerifyCodeManager.h"
#endif

typedef enum : NSInteger {
    VerifyCodeInitFinish = 0,/// 验证码组件初始化完成
    VerifyCodeInitFailed,/// 验证码组件初始化出错
    VerifyCodeValidateFinish,/// 完成验证之后的回调
    VerifyCodeCloseWindow,/// 关闭验证码窗口后的回调
} NTESVerifyCodeManagerStyle;

NS_ASSUME_NONNULL_BEGIN

@protocol NTESVerifyCodeManagerProtocol <NSObject>

/// 【功能性】网易云盾回调数据
@property(nonatomic,assign)BOOL ntesVerifyCodeFinishResult;
@property(nonatomic,assign)NTESVerifyCodeManagerStyle ntesVerifyCodeManagerStyle;
@property(nonatomic,strong)NSString *ntesVerifyCodeValidate;
@property(nonatomic,strong)NSString *ntesVerifyCodeMessage;
@property(nonatomic,strong)NSArray *ntesVerifyCodeError;
@property(nonatomic,assign)NTESVerifyCodeClose ntesVerifyCodeClose;

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize NTESVerifyCodeManagerProtocol
#ifndef NTESVerifyCodeManagerProtocol_synthesize
#define NTESVerifyCodeManagerProtocol_synthesize \
@synthesize ntesVerifyCodeFinishResult = _ntesVerifyCodeFinishResult;\
@synthesize ntesVerifyCodeManagerStyle = _ntesVerifyCodeManagerStyle;\
@synthesize ntesVerifyCodeValidate = _ntesVerifyCodeValidate;\
@synthesize ntesVerifyCodeMessage = _ntesVerifyCodeMessage;\
@synthesize ntesVerifyCodeError = _ntesVerifyCodeError;\
@synthesize ntesVerifyCodeClose = _ntesVerifyCodeClose;\

#endif

#pragma mark —— @dynamic NTESVerifyCodeManagerProtocol
#ifndef NTESVerifyCodeManagerProtocol_dynamic
#define NTESVerifyCodeManagerProtocol_dynamic \
@dynamic ntesVerifyCodeFinishResult = _ntesVerifyCodeFinishResult;\
@dynamic ntesVerifyCodeManagerStyle;\
@dynamic ntesVerifyCodeValidate;\
@dynamic ntesVerifyCodeMessage;\
@dynamic ntesVerifyCodeError;\
@dynamic ntesVerifyCodeClose;\

#endif
