//
//  AppToolsProtocol.h
//  Casino
//
//  Created by Jobs on 2021/12/7.
//

#import <Foundation/Foundation.h>
#import "BaseProtocol.h"
#import "JobsAppDoorConfig.h"
#import "RequestTool.h"
#import "CasinoGetiOSNewestVersionModel.h"

@class JobsHotLabel;

NS_ASSUME_NONNULL_BEGIN

/// App工具协议
@protocol AppToolsProtocol <BaseProtocol>

@optional
/// 去登录？去注册？
-(void)toLoginOrRegister:(CurrentPage)appDoorContentType;
/// 在某些页面不调取登录页
-(void)toLoginOrRegisterWithRestricted:(NSArray <Class>*_Nullable)dataArr
                    appDoorContentType:(CurrentPage)appDoorContentType;
/// 去登录
-(void)toLogin;
/// 强制去登录
-(void)forcedLogin;
/// 触发退出登录模块之前，弹窗提示二次确认，确认以后再删除本地用户数据
-(void)popUpViewToLogout;
/// 默认头像👤
-(UIImage *)defaultHeaderImage;
/// 跳到首页
-(void)jumpToHome;
/// 当前语言【字符串形式】
-(NSString *)currentLanguage;
/// 当前语言【枚举形式】
-(HTTPRequestHeaderLanguageType)currentLanguageType;
/// App 升级弹窗：在根控制器下实现，做到覆盖全局的统一
-(void)appUpdateWithData:(CasinoGetiOSNewestVersionModel *_Nonnull)updateData
               sureBlock:(MKDataBlock _Nullable)sureBlock
             cancelBlock:(MKDataBlock _Nullable)cancelBlock;

-(void)actionForHotLabel:(JobsHotLabel *)hl;

@end

NS_ASSUME_NONNULL_END
