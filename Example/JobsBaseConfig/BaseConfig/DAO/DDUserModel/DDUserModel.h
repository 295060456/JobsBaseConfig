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
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *deviceId;// 设备ID
@property(nonatomic,copy)NSString *validate;// 网易云盾

@end

NS_ASSUME_NONNULL_END

