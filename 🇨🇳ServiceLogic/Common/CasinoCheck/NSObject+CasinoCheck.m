//
//  NSObject+CasinoCheck.m
//  Casino
//
//  Created by Jobs on 2022/1/10.
//

#import "NSObject+CasinoCheck.h"

@implementation NSObject (CasinoCheck)

#pragma mark —— 通过验证返回YES

-(BOOL)userAndPasswordNotUpTo:(NSString *)value{
    return value.length < 6;
}

-(BOOL)telNotUpTo:(NSString *)value{
    return value.length < 20;
}
/// 用户账号由6-15个字符组成，只能输入字母大小写和数字
-(BOOL)checkUserName:(NSString *)userName{
    return ![self userAndPasswordNotUpTo:userName] && userName.length <= 15 && userName.isAlnum;
}
/// 用户密码由6-15个字符组成，只能输入字母大小写和数字
-(BOOL)checkUserPassword:(NSString *)userPassword{
    return ![self userAndPasswordNotUpTo:userPassword] && userPassword.length <= 15 && userPassword.isAlnum;
}
/// 登录的数据检验
-(BOOL)checkLoginData:(JobsAppDoorModel *)model{
    if ([self checkUserName:model.userName] &&
        [self checkUserPassword:model.password]) {
        return YES;
    }else{
        if ([NSString isNullString:model.userName] &&
            [NSString isNullString:model.password]) {
            [WHToast toastErrMsg:Internationalization(@"Please complete the login information")];
        }else if (![NSString isNullString:model.userName] &&
                  [NSString isNullString:model.password]){
            [WHToast toastErrMsg:Internationalization(@"Please enter your password")];
        }else if ([NSString isNullString:model.userName] &&
                  ![NSString isNullString:model.password]){
            [WHToast toastErrMsg:Internationalization(@"Please enter a user name")];
        }else{
            [WHToast toastErrMsg:Internationalization(@"The password consists of 6 to 15 characters and can only be letters and numbers")];
        }return NO;
    }
}
/// 注册的数据检验
-(BOOL)checkRegisterData:(JobsAppDoorModel *)model{
    if ([self checkUserName:model.userName] &&
        [self checkUserPassword:model.password] &&
        [self checkUserPassword:model.confirmPassword] &&
        ![NSString isNullString:model.verificationCode] &&
        ![NSString isNullString:model.tel]) {
        return YES;
    }else{
        if ([NSString isNullString:model.userName] &&
                  ![NSString isNullString:model.password] &&
                  ![NSString isNullString:model.confirmPassword] &&
                  ![NSString isNullString:model.tel] &&
                  ![NSString isNullString:model.verificationCode]){
            [WHToast toastErrMsg:Internationalization(@"Please enter a user name")];
        }else if (![NSString isNullString:model.userName] &&
                  [NSString isNullString:model.password] &&
                  ![NSString isNullString:model.confirmPassword] &&
                  ![NSString isNullString:model.tel] &&
                  ![NSString isNullString:model.verificationCode]){
            [WHToast toastErrMsg:Internationalization(@"Please enter your password")];
        }else if (![NSString isNullString:model.userName] &&
                  ![NSString isNullString:model.password] &&
                  [NSString isNullString:model.confirmPassword] &&
                  ![NSString isNullString:model.tel] &&
                  ![NSString isNullString:model.verificationCode]){
            [WHToast toastErrMsg:Internationalization(@"Please confirm your password")];
        }else if (![NSString isNullString:model.userName] &&
                  ![NSString isNullString:model.password] &&
                  ![NSString isNullString:model.confirmPassword] &&
                  [NSString isNullString:model.tel] &&
                  ![NSString isNullString:model.verificationCode]){
            [WHToast toastErrMsg:Internationalization(@"Please enter your mobile phone number")];
        }else if (![NSString isNullString:model.userName] &&
                  ![NSString isNullString:model.password] &&
                  ![NSString isNullString:model.confirmPassword] &&
                  ![NSString isNullString:model.tel] &&
                  [NSString isNullString:model.verificationCode]){
            [WHToast toastErrMsg:Internationalization(@"Please enter the verification code")];
        }else if ([self checkUserName:model.userName] ||
                  [self checkUserPassword:model.password] ||
                  [self checkUserPassword:model.confirmPassword]){
            [WHToast toastErrMsg:Internationalization(@"The password consists of 6 to 15 characters and can only be letters and numbers")];
        }else{
            [WHToast toastErrMsg:Internationalization(@"Please complete the registration information")];
        }
    }return NO;
}
/// 电话号码可以最多20位数，超过后无法输入，且电话号码中无法包含特殊字符或者空格
-(BOOL)checkTelNum:(NSString *)telNum{
    return ![telNum isContainsSpecialSymbolsString:nil] &&// 不包含特殊字符
    telNum.length <= 20 &&// 长度小于20位
    telNum.isContainBlank;// 不包含空格
}

@end
