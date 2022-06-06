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
    ForcedUpdate_YES = 1,
    ForcedUpdate_NO
} ForcedUpdateType;// 强制更新

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

#endif /* DefineStructure_h */
