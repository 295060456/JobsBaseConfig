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
#import "NetworkingConstant.h"

@class JobsHotLabelWithSingleLine;

NS_ASSUME_NONNULL_BEGIN

/// App工具协议
@protocol AppToolsProtocol <BaseProtocol>

@optional

#pragma mark —— <AppToolsProtocol> 关于注册登录
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
#pragma mark —— <AppToolsProtocol> 关于 TabBar
/// TabBar
-(UITabBar *)getTabBar;
/// JobsTabbarVC 关闭手势
-(void)tabBarClosePan;
/// JobsTabbarVC 打开手势
-(void)tabBarOpenPan;
/// 获取Tabbar管理的，不含导航的根控制器
-(NSMutableArray <UIViewController *>*)appRootVC;
/// 当前对象是否是 Tabbar管理的，不含导航的根控制器
-(BOOL)isRootVC;
/// 跳到首页
-(void)jumpToHome;
#pragma mark —— <AppToolsProtocol> 其他
-(UIViewModel *)configViewModelWithTitle:(NSString *_Nullable)title
                                subTitle:(NSString *_Nullable)subTitle;
/// 打开游戏
-(void)openGameWithUrl:(NSString *)url;
/// 默认头像👤
-(UIImage *)defaultHeaderImage;
/// 当前语言【字符串形式】
-(NSString *)currentLanguage;
/// 当前语言【枚举形式】
-(HTTPRequestHeaderLanguageType)currentLanguageType;
/// App 升级弹窗：在根控制器下实现，做到覆盖全局的统一
-(void)appUpdateWithData:(CasinoGetiOSNewestVersionModel *_Nonnull)updateData
               sureBlock:(jobsByIDBlock _Nullable)sureBlock
             cancelBlock:(jobsByIDBlock _Nullable)cancelBlock;

-(void)actionForHotLabel:(JobsHotLabelWithSingleLine *)hl;


@end

NS_ASSUME_NONNULL_END
