//
//  NSObject+URLManager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NSObject+URLManager.h"

NetworkingEnvir networkingEnvir = DevEnviron_Cambodia_Main;/// 柬埔寨（主要）开发环境
//NetworkingEnvir networkingEnvir = DevEnviron_Cambodia_Minor;/// 柬埔寨（次要）开发环境
//NetworkingEnvir networkingEnvir = DevEnviron_China_Mainland;/// 中国大陆开发环境
//NetworkingEnvir networkingEnvir = TestEnviron;/// 测试环境
//NetworkingEnvir networkingEnvir = ProductEnviron;/// 生产环境
//NetworkingEnvir networkingEnvir = UATEnviron;/// UAT环境

@implementation NSObject (URLManager)
 
+(URLManagerModel *)url:(NSString *)url
               funcName:(NSString *)funcName{
    URLManagerModel *managerModel = URLManagerModel.new;
    managerModel.url = url;
    managerModel.funcName = funcName;
    return managerModel;
}
#pragma mark —— BaseURL
+(NSString *)BaseUrl{
    switch (networkingEnvir) {
        case DevEnviron_Cambodia_Main:{
            /// 柬埔寨（主要）开发环境
            return @"http://okeexx.cn:9200";
//            return @"154.204.57.237:9200";
//            return @"192.168.10.77:9200";
        }break;
        case DevEnviron_Cambodia_Minor:{
            /// 柬埔寨的开发环境(次要)，因为某些代码未合并，柬埔寨的开发环境临时用测试环境替代
            return @"";
        }break;
        case DevEnviron_China_Mainland:{
            /// 中国大陆开发环境
            return @"47.243.60.31:9200";
        }break;
        case TestEnviron:{
            /// 测试环境
            return @"";
        }break;
        case ProductEnviron:{
            /// 生产环境
            return @"";
        }break;
        default:
            return @"";
            break;
    }
}

+(NSString *)BaseUrl_H5{
    switch (networkingEnvir) {
        case DevEnviron_Cambodia_Main:{
            /// 柬埔寨（主要）开发环境
            return @"";
        }break;
        case DevEnviron_Cambodia_Minor:{
            /// 柬埔寨的开发环境(次要)，因为某些代码未合并，柬埔寨的开发环境临时用测试环境替代
            return @"";
        }break;
        case DevEnviron_China_Mainland:{
            /// 中国大陆开发环境
            return @"";
        }break;
        case TestEnviron:{
            /// 测试环境
            return @"";
        }break;
        case ProductEnviron:{
            /// 生产环境
            return @"";
        }break;
        default:
            return @"";
            break;
    }
}
#pragma mark —— WM游戏厅
/// 查询当前登录用户WM余额
+(URLManagerModel *)wmGetWmBalanceGET{
    return [NSObject url:@"/wm/getWmBalance"
                funcName:NSStringFromSelector(_cmd)];
}
/// 查询用户WM余额外部接口
+(URLManagerModel *)wmGetWmBalanceApiGET{
    return [NSObject url:@"/wm​/getWmBalanceApi"
                funcName:NSStringFromSelector(_cmd)];
}
/// 一键回收当前登录用户WM余额
+(URLManagerModel *)wmOneKeyRecoverGET{
    return [NSObject url:@"/wm​/oneKeyRecover"
                funcName:NSStringFromSelector(_cmd)];
}
/// 一键回收用户WM余额外部接口
+(URLManagerModel *)wmOneKeyRecoverApiGET{
    return [NSObject url:@"/wm/oneKeyRecoverApi"
                funcName:NSStringFromSelector(_cmd)];
}
/// 开游戏
+(URLManagerModel *)wmOpenGamePOST{
    return [NSObject url:@"/wm/openGame"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— inteceptor-controller
/// authorizationNopass GET / PUT / POST / DELETE / OPTIONS / HEAD / PATCH / TRACE
+(URLManagerModel *)inteceptorControllerAuthorizationNopass{
    return [NSObject url:@"/authorizationNopass"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 代理中心
/// 业绩查询
+(URLManagerModel *)proxyCentreFindAchievementListGET{
    return [NSObject url:@"/proxyCentre/findAchievementList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 查询今日，昨日，本周佣金
+(URLManagerModel *)proxyCentreGetCommissionGET{
    return [NSObject url:@"/proxyCentre/getCommission"
                funcName:NSStringFromSelector(_cmd)];
}
/// 我的团队
+(URLManagerModel *)proxyCentreMyTeamGET{
    return [NSObject url:@"/proxyCentre/myTeam"
                funcName:NSStringFromSelector(_cmd)];
}
/// 代理报表
+(URLManagerModel *)proxyCentreProxyReportGET{
    return [NSObject url:@"/proxyCentre/proxyReport"
                funcName:NSStringFromSelector(_cmd)];
}
/// 用户领取分润金额
+(URLManagerModel *)proxyCentreReceiveShareProfitGET{
    return [NSObject url:@"/proxyCentre/receiveShareProfit"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 公告中心
/// 公告/活动
+(URLManagerModel *)noticeNewestGET{
    return [NSObject url:@"/notice/newest"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 客服中心
/// 客服联系方式
+(URLManagerModel *)customerContactGET{
    return [NSObject url:@"/customer/contact"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 应用版本控制
/// 获取Android最新下载链接
+(URLManagerModel *)downloadStationGetAndroidDownloadUrlGET{
    return [NSObject url:@"/downloadStation/getAndroidDownloadUrl"
                funcName:NSStringFromSelector(_cmd)];
}
/// Android最新版本检查
+(URLManagerModel *)downloadStationGetAndroidNewestVersionGET{
    return [NSObject url:@"/downloadStation/getAndroidNewestVersion"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取iOS最新下载链接
+(URLManagerModel *)downloadStationGetIosDownloadUrlGET{
    return [NSObject url:@"/downloadStation/getIosDownloadUrl"
                funcName:NSStringFromSelector(_cmd)];
}
/// iOS最新版本检查
+(URLManagerModel *)downloadStationGetIosNewestVersionGET{
    return [NSObject url:@"/downloadStation/getIosNewestVersion"
                funcName:NSStringFromSelector(_cmd)];
}
/// 推广域名
+(URLManagerModel *)downloadStationGetSpreadUrlGET{
    return [NSObject url:@"/downloadStation/getSpreadUrl"
                funcName:NSStringFromSelector(_cmd)];
}
/// 网页版链接
+(URLManagerModel *)downloadStationGetWebUrlGET{
    return [NSObject url:@"​/downloadStation/getWebUrl"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 洗码
/// 用户洗码列表
+(URLManagerModel *)washCodeGetListGET{
    return [NSObject url:@"/washCode/getList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 用户领取洗码
+(URLManagerModel *)washCodeReceiveWashCodeGET{
    return [NSObject url:@"/washCode/receiveWashCode"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 用户中心
/// 银行列表
+(URLManagerModel *)bankcardBanklistGET{
    return [NSObject url:@"​/bankcard/banklist"
                funcName:NSStringFromSelector(_cmd)];
}
/// 用户增加银行卡
+(URLManagerModel *)bankcardBoundPOST{
    return [NSObject url:@"/bankcard/bound"
                funcName:NSStringFromSelector(_cmd)];
}
/// 根据ID删除银行卡
+(URLManagerModel *)bankcardDeleteBankCardByIdGET{
    return [NSObject url:@"/bankcard/deleteBankCardById"
                funcName:NSStringFromSelector(_cmd)];
}
/// 根据ID设置默认银行卡
+(URLManagerModel *)bankcardSetDefaultBankCardByIdPOST{
    return [NSObject url:@"/bankcard/setDefaultBankCardById"
                funcName:NSStringFromSelector(_cmd)];
}
/// 直接开户
+(URLManagerModel *)​user​DirectOpenAccountPOST{
    return [NSObject url:@"/user/directOpenAccount"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取当前用户人人代推广链接
+(URLManagerModel *)userEveryoneSpreadGET{
    return [NSObject url:@"/user/everyoneSpread"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取当前用户的余额,打码量,可提现金额,洗码金额,分润金额
+(URLManagerModel *)userGetMoneyGET{
    return [NSObject url:@"/user/getMoney"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取当前用户的基本信息(不包含 余额，打码量，可提现金额,洗码金额)
+(URLManagerModel *)userInfoGET{
    return [NSObject url:@"/user​/info"
                funcName:NSStringFromSelector(_cmd)];
}
/// 登录用户修改信息
+(URLManagerModel *)userUpdateUserInfoPOST{
    return [NSObject url:@"/user/updateUserInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// web端登录用户修改信息
+(URLManagerModel *)userWebUpdateUserInfoPOST{
    return [NSObject url:@"/user​/webUpdateUserInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取用户已绑定银行卡
+(URLManagerModel *)withdrawBanklistGET{
    return [NSObject url:@"/withdraw​/banklist"
                funcName:NSStringFromSelector(_cmd)];
}
/// 提款提交
+(URLManagerModel *)​withdrawSubmitPOST{
    return [NSObject url:@"/withdraw/submit"
                funcName:NSStringFromSelector(_cmd)];
}
/// 当前登录用户修改登录密码
+(URLManagerModel *)withdrawUpdateLoginPasswordPOST{
    return [NSObject url:@"/withdraw/updateLoginPassword"
                funcName:NSStringFromSelector(_cmd)];
}
/// 当前登录用户修改取款密码
+(URLManagerModel *)withdrawUpdateWithdrawPasswordPOST{
    return [NSObject url:@"/withdraw​/updateWithdrawPassword"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 认证中心
/// 谷歌图形验证码
+(URLManagerModel *)authCaptchaGET{
    return [NSObject url:@"/auth/captcha"
                funcName:NSStringFromSelector(_cmd)];
}
/// 校验邀请码
+(URLManagerModel *)authCheckInviteCodeGET{
    return [NSObject url:@"/auth/checkInviteCode"
                funcName:NSStringFromSelector(_cmd)];
}
/// 开发者通过此令牌调试接口。不可用于正式请求
+(URLManagerModel *)​authGetJwtTokenGET{
    return [NSObject url:@"/auth/getJwtToken"
                funcName:NSStringFromSelector(_cmd)];
}
/// 查询注册通道状态
+(URLManagerModel *)​authGetRegisterStatusGET{
    return [NSObject url:@"/auth/getRegisterStatus"
                funcName:NSStringFromSelector(_cmd)];
}
/// 通过手机号获取验证码
+(URLManagerModel *)authGetVerificationCodeGET{
    return [NSObject url:@"/auth/getVerificationCode"
                funcName:NSStringFromSelector(_cmd)];
}
/// 帐密登陆.谷歌验证码
+(URLManagerModel *)authLoginAPOST{
    return [NSObject url:@"/auth/loginA"
                funcName:NSStringFromSelector(_cmd)];
}
/// 前台用户注册
+(URLManagerModel *)authRegisterPOST{
    return [NSObject url:@"/auth/register"
                funcName:NSStringFromSelector(_cmd)];
}
/// 服务健康状态监测
+(URLManagerModel *)authServiceHealthCheckGET{
    return [NSObject url:@"/auth/serviceHealthCheck"
                funcName:NSStringFromSelector(_cmd)];
}
/// 推广用户注册
+(URLManagerModel *)authSpreadRegisterPOST{
    return [NSObject url:@"/auth/spreadRegister"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 资金中心
/// 用户资金详情
+(URLManagerModel *)accountChangeAccountChangeListGET{
    return [NSObject url:@"/accountChange​/accountChangeList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 用户充值列表
+(URLManagerModel *)chargeOrderChargeOrderListGET{
    return [NSObject url:@"/chargeOrder​_chargeOrderList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 充值订单流水详情
+(URLManagerModel *)rechargeTurnoverFindPageGET{
    return [NSObject url:@"/rechargeTurnover/findPage"
                funcName:NSStringFromSelector(_cmd)];
}
/// 提现列表
+(URLManagerModel *)withdrawWithdrawListGET{
    return [NSObject url:@"/withdraw/withdrawList"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 轮播图
/// 轮播图.返回的URL为相对路径。需加上项目域名访问
+(URLManagerModel *)picLunboGET{
    return [NSObject url:@"/pic/lunbo"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 银行卡线下充值
/// 收款银行卡列表
+(URLManagerModel *)chargeCollectBankcardsGET{
    return [NSObject url:@"/charge/collect_bankcards"
                funcName:NSStringFromSelector(_cmd)];
}
/// 提交充值
+(URLManagerModel *)chargeSubmitPOST{
    return [NSObject url:@"/charge/submit"
                funcName:NSStringFromSelector(_cmd)];
}

@end
