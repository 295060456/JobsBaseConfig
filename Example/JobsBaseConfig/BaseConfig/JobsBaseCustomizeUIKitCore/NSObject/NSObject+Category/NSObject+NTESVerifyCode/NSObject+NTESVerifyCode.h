//
//  NSObject+NTESVerifyCode.h
//  Casino
//
//  Created by Jobs on 2021/12/2.
//

#import <Foundation/Foundation.h>

#import "MacroDef_Size.h"
#import "MacroDef_App.h"
#import "MacroDef_Func.h"
#import "LoadingImage.h"
#import "NSObject+CallBackInfoByBlock.h"
#import "UIButton+UI.h"
#import "UIViewModel.h"

#import "APIKey.h"

#if __has_include(<VerifyCode/NTESVerifyCodeManager.h>)
#import <VerifyCode/NTESVerifyCodeManager.h>
#else
#import "NTESVerifyCodeManager.h"
#endif

#ifndef NTESVerifyCodeKEY
#define NTESVerifyCodeKEY @"a2eb62e9d6be4d4e945d5a403285b229"/// 网易云盾秘钥
#endif
/**
 *【网易云盾 SDK地址】
 *  https://github.com/yidun/NTESVerifyCode
 *【网易云盾 开发文档地址】
 *  https://support.dun.163.com/documents/15588062143475712?docId=150442931089756160
 */
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NTESVerifyCode)<NTESVerifyCodeManagerDelegate>

@property (nonatomic,strong)NTESVerifyCodeManager *ntesVerifyCodeManager;
@property (nonatomic,strong)UIButton *NTESVerifyCodeCloseBtn;/// 本地化解决网易云验证的一个UI方面的Bug：https://github.com/yidun/captcha-ios-demo/issues/10
#pragma mark —— 一些公有化方法
/// 开启网易云盾
-(void)openVerifyCodeView:(UIView *_Nullable)topView;
/// 关闭网易云盾
-(void)closeVerifyCodeView;

@end

NS_ASSUME_NONNULL_END
