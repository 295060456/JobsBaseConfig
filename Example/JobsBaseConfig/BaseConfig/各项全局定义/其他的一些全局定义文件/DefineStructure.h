//
//  DefineStructure.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#ifndef DefineStructure_h
#define DefineStructure_h
// 此文件用来存储记录全局的一些枚举
typedef enum : NSInteger {
    /// 柬埔寨（主要）开发环境
    DevEnviron_Cambodia_Main = 0,
    /// 柬埔寨（次要）开发环境
    DevEnviron_Cambodia_Minor,
    /// 中国大陆开发环境
    DevEnviron_China_Mainland,
    /// 测试环境
    TestEnviron,
    /// 生产环境
    ProductEnviron,
    /// UAT环境地址
    UATEnviron
} NetworkingEnvir;

typedef enum : NSInteger {
    /// 正常
    CasinoPlatformMaintenanceStyle_Off = 0,
    /// 维护中
    CasinoPlatformMaintenanceStyle_On
} CasinoPlatformMaintenanceStyle;// 平台维护状态

typedef enum : NSInteger {
    /// 维护中
    CasinoGamesStatus_Maintenance = 0,
    /// 正常
    CasinoGamesStatus_OK,
    /// 关闭
    CasinoGamesStatus_Close
} CasinoGamesStatus;// 游戏状态：0、维护;1、正常;2、关闭

typedef enum : NSInteger {
    /// 维护
    GamesStatus_Maintain = 0,
    /// 正常
    GamesStatus_OK
} GamesStatus;// 游戏状态

typedef enum : NSInteger {
    TerminalTypeNone = 0,
    TerminalType_Android,
    TerminalType_iOS
} TerminalType;// 终端类型

typedef enum : NSInteger {
    ForcedUpdate_YES = 1,
    ForcedUpdate_NO
} ForcedUpdateType;// 强制更新

typedef NS_ENUM(NSInteger,BankCardStyle) {
    BankCardStyleUnselect = 0,
    BankCardStyleSelect
};

typedef enum : NSInteger {
    /// 未定义
    MsgStyle_None = 0,
    /// 通知
    MsgStyle_Notify,
    /// 活动
    MsgStyle_Activity,
    /// 公告
    MsgStyle_Notice,
    /// 红利
    MsgStyle_Bonus,
} MsgStyle;

typedef enum : NSInteger {
    ChangePasswordType_Login = 0,
    ChangePasswordType_Withdrawal,
} ChangePasswordType;// 密码修改

typedef enum : NSInteger {
    /// 今天
    CasinoDateToday = 0,
    /// 昨天
    CasinoDateYesterday,
    /// 近7天内
    CasinoDateIn7Days,
    CasinoDateAll
} CasinoDate;

typedef enum : NSInteger {
    /// 今天
    CasinoChargeOrderDateToday = 0,
    /// 昨天
    CasinoChargeOrderDateYesterday,
    /// 一个月内
    CasinoChargeOrderDateInMonth,
    /// 全部
    CasinoChargeOrderDateAll
} CasinoChargeOrderDate;
/// 收款方式
typedef NS_ENUM(NSInteger,RemitType) {
    RemitType_银行卡 = 1,
    RemitType_支付宝,
    RemitType_微信,
    RemitType_人工操作
};
/// 游戏类型
typedef NS_ENUM(NSInteger,GameStyle) {
    GameStyle_DG真人 = 1,
    GameStyle_Super体育默认单关,
    GameStyle_Super体育串关,
    GameStyle_AT电子,
    GameStyle_好路棋牌,
    GameStyle_Super彩球
};
/// 通道类型
typedef NS_ENUM(NSInteger,PayStyle) {
    PayStyle_银行卡,
    PayStyle_虚拟币,
    PayStyle_人工下分,
};
/// 订单状态
typedef NS_ENUM(NSInteger,OrderStyle) {
    PayStyle_待审核,
    PayStyle_已完成,
    PayStyle_出款错误,
    PayStyle_已注销,
};
/// 等级
typedef NS_ENUM(NSInteger,RankClass) {
    RankClass_current,
    RankClass_VIP0,
    RankClass_VIP1,
    RankClass_VIP2,
    RankClass_VIP3,
    RankClass_VIP4,
    RankClass_VIP5,
    RankClass_VIP6,
    RankClass_VIP7,
    RankClass_VIP8,
    RankClass_VIP9,
    RankClass_VIP10
};
/// 活动状态
typedef NS_ENUM(NSInteger,ActiveState) {
    ActiveState_参与活动,
    ActiveState_等级不符,
    ActiveState_正在参与活动,
    ActiveState_已参与过活动,
    ActiveState_未定义
};

typedef enum : NSInteger {
    /// 缺省值
    BaiShaETProjTopupCVCellStyle_00 = 0,
    /// 存款金额01
    BaiShaETProjTopupCVCellStyle_01,
    /// 存款金额02
    BaiShaETProjTopupCVCellStyle_02,
    /// 收起 & 查看更多
    BaiShaETProjTopupCVCellStyle_TurnONOff
} BaiShaETProjTopupCVCellStyle;

typedef enum : NSInteger {
    BaiShaETProjUSDTCellStyle_Normal = 0,
    BaiShaETProjUSDTCellStyle_Add
} BaiShaETProjUSDTCellStyle;
/// ==============
typedef enum : NSInteger {
    /// QQ
    CustomerContactStyle_QQ = 1,
    /// Skype
    CustomerContactStyle_Skype,
    /// Telegram
    CustomerContactStyle_Telegram,
    /// whatsApp
    CustomerContactStyle_whatsApp,
    /// 手机号码
    CustomerContactStyle_手机号码,
    /// onlineURL
    CustomerContactStyle_onlineURL
} CustomerContactStyle;// 客服平台标识

typedef enum : NSInteger {
    /// 停用
    CustomerContactStateStyle_Close = 0,
    /// 启用
    CustomerContactStateStyle_Open
} CustomerContactStateStyle;// 客服平台状态

typedef enum : NSInteger {
    /// 真实姓名
    UpdateUserInfoType_RealName = 0,
    /// 邮箱地址
    UpdateUserInfoType_Mail,
    /// 微信账号
    UpdateUserInfoType_Wechat,
    /// QQ账号
    UpdateUserInfoType_QQ,
    /// 未定义
    UpdateUserInfoType_Undefined
} UpdateUserInfoType;

#endif /* DefineStructure_h */
