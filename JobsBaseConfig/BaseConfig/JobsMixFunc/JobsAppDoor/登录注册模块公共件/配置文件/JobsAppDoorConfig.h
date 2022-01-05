//
//  JobsAppDoorConfig.h
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import <Foundation/Foundation.h>
#import "MacroDef_Func.h"

typedef NS_ENUM(NSInteger, CurrentPage) {
    CurrentPage_login = 0,//登录
    CurrentPage_register,//注册
    CurrentPage_forgotCode//忘记密码
};

typedef NS_ENUM(NSInteger, JobsAppDoorBgType){
    JobsAppDoorBgType_Image = 0,//背景只是一张图
    JobsAppDoorBgType_video//背景是视频资源
};

/// 页面1：登录
#define JobsAppDoorContentViewLoginX JobsWidth(20)
#define JobsAppDoorContentViewLoginY JobsSCREEN_HEIGHT / (isiPhoneX_series() ? 4 : 5)
#define JobsAppDoorContentViewLoginWidth JobsSCREEN_WIDTH - JobsAppDoorContentViewLoginX * 2
#define JobsAppDoorContentViewLoginHeight JobsSCREEN_HEIGHT / (isiPhoneX_series() ? 2.3 : 2.0)
/// 页面2：注册
#define JobsAppDoorContentViewRegisterX JobsWidth(20)
#define JobsAppDoorContentViewRegisterY JobsSCREEN_HEIGHT / (isiPhoneX_series() ? 4 : 5)
#define JobsAppDoorContentViewRegisterWidth JobsSCREEN_WIDTH - JobsAppDoorContentViewRegisterX * 2
#define JobsAppDoorContentViewRegisterHeight JobsSCREEN_HEIGHT / (isiPhoneX_series() ? 1.6 : 1.3)
/// 页面3：忘记密码
#define JobsAppDoorContentViewFindPasswordX JobsWidth(20)
#define JobsAppDoorContentViewFindPasswordY JobsSCREEN_HEIGHT / 4
#define JobsAppDoorContentViewFindPasswordWidth JobsSCREEN_WIDTH - JobsAppDoorContentViewFindPasswordX * 2
#define JobsAppDoorContentViewFindPasswordHeight JobsSCREEN_HEIGHT / (isiPhoneX_series() ? 1.6 : 1.3)

#define Cor1 [UIColor.blackColor colorWithAlphaComponent:0.9007f]
#define Cor2 [UIColor.blackColor colorWithAlphaComponent:0.5984f]
#define Cor3 HEXCOLOR(0xE1CD62)
#define Cor4 [UIColor.whiteColor colorWithAlphaComponent:0.9007f]
#define Cor5 HEXCOLOR(0x502600)

#define ThingsHeight JobsWidth(50)//边角半圆形控件的高度
#define RegisterBtnWidth JobsWidth(64)//竖形按钮的宽度
#define InputViewOffset JobsWidth(20)//输入框承接控件之间的上下间距

#define Title1 Internationalization(@"B\na\nc\nk\nT\no\nL\no\ng\ni\nn")
#define Title2 Internationalization(@"L\no\ng\ni\nn")
#define Title3 Internationalization(@"Forgot code")
#define Title4 Internationalization(@"Back to HomePage")
#define Title5 Internationalization(@"Save the user name")
#define Title6 Internationalization(@"Register")
#define Title7 Internationalization(@"Login")
#define Title8 Internationalization(@"Customer service")
#define Title9 Internationalization(@"Get")
#define Title10 Internationalization(@"Online customer service")
#define Title11 Internationalization(@"You can also contact customer service through the following ways")
#define Title12 Internationalization(@"Later")

/**
 
 1.账号密码长度提示为默认固定存在。
 2.玩家输入框中没有输入信息后，提示“账号不能为空”“密码不能为空”
 3.玩家输入的账号密码长度不够或者超出后，框显示为红色提示。
 4.玩家输入特殊字符后，提示玩家“账号密码不能使用特殊字符”
 5.密码和确定密码不同时，提示玩家：两次的输入密码不匹配，请仔细确认。
 6.电话号码可以最多20位数，超过后无法输入。且电话号码中无法包含特殊字符或者空格

 1.用户账号由6-15个字符组成，只能输入字母大小写和数字。
 2.用户密码由6-15个字符组成，只能输入字母大小写和数字。
 3.会员输入有误时，提示对应的错误码。
 4.手机验证错误时，提示玩家验证码有误。
 */

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorConfig : NSObject

@end

NS_ASSUME_NONNULL_END
