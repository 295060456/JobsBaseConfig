//
//  DDUserModel.h
//  DouDong-II
//
//  Created by xxx on 2021/1/10.
//

#import <Foundation/Foundation.h>
#import "DefineStructure.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUserModel : NSObject

@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userHeader;// 用户头像URL
@property(nonatomic,copy)NSString *userRacnkClass;// 用户等级
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *deviceId;// 设备ID
@property(nonatomic,copy)NSString *validate;// 网易云盾
@property(nonatomic,copy)NSString *resourcesAddress;// 文件服务器地址

@end

NS_ASSUME_NONNULL_END

