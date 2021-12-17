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

@end

NS_ASSUME_NONNULL_END
