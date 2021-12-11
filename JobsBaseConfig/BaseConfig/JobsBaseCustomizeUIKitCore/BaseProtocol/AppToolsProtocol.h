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

-(void)toLogin;

-(void)forcedLogin;

-(UIImage *)defaultHeaderImage;

-(BOOL)isFristpostChannle;

+(void)completeFristpostChannle;
/// 强制展现页面，本类如果是VC则用本类推，否则用JobsTabbarVC来推
/// @param toPushVC 需要进行展现的页面
/// @param requestParams 正向推页面传递的参数
-(void)forceComingToPushVC:(UIViewController *)toPushVC
             requestParams:(id _Nullable)requestParams;

@end

NS_ASSUME_NONNULL_END
