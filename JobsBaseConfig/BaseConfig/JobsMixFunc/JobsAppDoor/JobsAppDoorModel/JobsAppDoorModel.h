//
//  JobsAppDoorModel.h
//  Casino
//
//  Created by Jobs on 2021/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorModel : NSObject

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *confirmPassword;
@property(nonatomic,strong)NSString *tel;
@property(nonatomic,strong)NSString *verificationCode;

@end

NS_ASSUME_NONNULL_END
