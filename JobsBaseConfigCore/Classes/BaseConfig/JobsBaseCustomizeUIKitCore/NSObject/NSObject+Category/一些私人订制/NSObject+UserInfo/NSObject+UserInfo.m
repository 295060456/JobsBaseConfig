//
//  NSObject+UserInfo.m
//  Casino
//
//  Created by Jobs on 2021/12/1.
//

#import "NSObject+UserInfo.h"

NSString *const 用户信息 = @"用户信息";
NSString *const 用户名数组 = @"用户名数组";

@implementation NSObject (UserInfo)
/**
  【鉴别是否登录】
  【标准】token是否为空
  【return】 YES(已经登录)、NO（未登录）
 */
-(BOOL)isLogin{
    UserDefaultModel *obj = [NSUserDefaults readWithKey:用户信息];
    if (obj) {
        DDUserModel *userModel = [DDUserModel mj_objectWithKeyValues:obj];
        return ![NSString isNullString:userModel.token];
    }return obj;
}
#pragma mark —— 全局的用户数据(存、取、清)[全局唯一一份用户档案]
/// 登出清空用户数据
-(void)logOut{
    [NSUserDefaults deleteWithKey:用户信息];
}
/// 保存用户数据（用 NSUserDefaults ）
-(void)saveUserInfo:(DDUserModel *)userModel{
    UserDefaultModel *userDefaultModel = UserDefaultModel.new;
    userDefaultModel.obj = userModel;
    userDefaultModel.key = 用户信息;
    [NSUserDefaults updateWithModel:userDefaultModel];
}
/// 读取用户信息
-(DDUserModel *)readUserInfo{
    return [DDUserModel mj_objectWithKeyValues:[NSUserDefaults readWithKey:用户信息]];
}
#pragma mark —— 保存特定的用户数据（不随登出清空数据）[全局多份用户档案]
///【通过特定的用户名】 保存（更新）用户的本地资料（用 NSUserDefaults ）
-(void)userNameToSaveUserInfo:(DDUserModel *)userModel{
    UserDefaultModel *userDefaultModel = UserDefaultModel.new;
    userDefaultModel.obj = userModel;
    userDefaultModel.key = userModel.userName;
    [NSUserDefaults updateWithModel:userDefaultModel];
}
///【通过特定的用户名】 读取用户的本地资料
-(DDUserModel *)readUserInfoByUserName:(NSString *)userName{
    return [DDUserModel mj_objectWithKeyValues:[NSUserDefaults readWithKey:userName]];
}
///【通过特定的用户名】 删除该用户的本地资料
-(void)deleteUserInfoByUserName:(NSString *)userName{
    [NSUserDefaults deleteWithKey:userName];
}
#pragma mark —— 全局保存和删除已经登录成功的用户名
/// 全局保存已经登录成功 且 并未删除的用户名组
-(void)saveUserName:(NSString *_Nullable)userName{
    
    if ([NSString isNullString:userName]) return;

    NSMutableArray *userNameMutArr = [NSMutableArray arrayWithArray:[NSUserDefaults.standardUserDefaults valueForKey:用户名数组]];//取出来的实际上是个不可变数组，所以需要向可变数组进行转化
    if (!userNameMutArr) {
        userNameMutArr = NSMutableArray.array;
    }
    // 保持唯一性
    if (![userNameMutArr containsObject:userName]) {
        [userNameMutArr addObject:userName];
        [NSUserDefaults.standardUserDefaults setObject:userNameMutArr forKey:用户名数组];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
}
/// 读取用户名组
-(NSArray *_Nullable)readUserNameMutArr{
    return [NSUserDefaults.standardUserDefaults valueForKey:用户名数组];
}
/// 全局删除已经登录成功的用户名
-(void)deleteUserName:(NSString *_Nullable)userName{
    NSMutableArray *userNameMutArr = [NSMutableArray arrayWithArray:[NSUserDefaults.standardUserDefaults valueForKey:用户名数组]];
    if (userNameMutArr && ![NSString isNullString:userName]) {
        [userNameMutArr removeObject:userName];
        [NSUserDefaults.standardUserDefaults setObject:userNameMutArr forKey:用户名数组];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
}

@end
