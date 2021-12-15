//
//  AppToolsProtocol.h
//  Casino
//
//  Created by Jobs on 2021/12/7.
//

#import <Foundation/Foundation.h>
#import "BaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/// App工具协议
@protocol AppToolsProtocol <BaseProtocol>

@optional
/// 去登录
-(void)toLogin;
/// 强制去登录
-(void)forcedLogin;
/// 默认头像👤
-(UIImage *)defaultHeaderImage;
/// 强制展现页面，本类如果是VC则用本类推，否则用JobsTabbarVC来推
/// @param toPushVC 需要进行展现的页面
/// @param requestParams 正向推页面传递的参数
-(void)forceComingToPushVC:(UIViewController *)toPushVC
             requestParams:(id _Nullable)requestParams;
/// 判断是否是此版本App的首次启动
-(BOOL)isAppFirstLaunch;
/// 判断是否是App今日的首次启动
-(BOOL)isTodayAppFirstLaunch;

@end

NS_ASSUME_NONNULL_END
