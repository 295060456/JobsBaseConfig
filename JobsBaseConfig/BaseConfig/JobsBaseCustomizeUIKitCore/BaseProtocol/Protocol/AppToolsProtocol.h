//
//  AppToolsProtocol.h
//  Casino
//
//  Created by Jobs on 2021/12/7.
//

#import <Foundation/Foundation.h>
#import "BaseProtocol.h"
#import "JobsAppDoorConfig.h"

NS_ASSUME_NONNULL_BEGIN

/// App工具协议
@protocol AppToolsProtocol <BaseProtocol>

@optional
/// 去登录？去注册？
-(void)toLoginOrRegister:(CurrentPage)appDoorContentType;
/// 去登录
-(void)toLogin;
/// 强制去登录
-(void)forcedLogin;
/// 触发退出登录模块之前，弹窗提示二次确认，确认以后再删除本地用户数据
-(void)popUpViewToLogout;
/// 默认头像👤
-(UIImage *)defaultHeaderImage;

@end

NS_ASSUME_NONNULL_END
