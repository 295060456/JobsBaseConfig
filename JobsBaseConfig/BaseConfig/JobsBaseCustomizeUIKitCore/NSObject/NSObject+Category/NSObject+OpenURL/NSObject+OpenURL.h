//
//  NSObject+OpenURL.h
//  UBallLive
//
//  Created by Jobs on 2020/10/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>// 发短信、发邮件
#import "JobsBlock.h"
#import "MacroDef_SysWarning.h"
#import "NSString+JudgeNull.h"
#import "NSObject+WHToast.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OpenURL)
<
MFMessageComposeViewControllerDelegate
,MFMailComposeViewControllerDelegate
>
/// 发短信、发邮件系统专用VC
@property(nonatomic,strong)MFMessageComposeViewController *messageComposeVC;
@property(nonatomic,strong)MFMailComposeViewController *mailComposeVC;
/// 发送邮件📮
/// @param mailComposeVC 外界自定义的发送邮件的VC，如传nil则用默认值
-(void)sendMailWithComposeVC:(MFMailComposeViewController *_Nullable)mailComposeVC
                  completion:(void (^ __nullable)(void))completion;
/// 调用系统电话☎️拨号功能，会以sheet的形式，确认后进行拨号
/// @param telephoneNumber 电话号码
/// @param dialFinishBackToApp 电话结束后是否会留在电话界面【tel留在打电话页面。telprompt返回App（上架App Store🈶被拒的案例）】
/// @param successBlock 成功回调
/// @param failBlock 失败回调
-(void)dialWithTelephoneNumber:(NSString *_Nullable)telephoneNumber
           dialFinishBackToApp:(BOOL)dialFinishBackToApp
                  successBlock:(MKDataBlock _Nullable)successBlock
                     failBlock:(MKDataBlock _Nullable)failBlock;
/**
    跳转系统设置
    在iOS10更新后，跳转到系统设置的具体的子页面被禁用，只能跳转到系统设置根目录
    但是苹果又更新了URLscheme，亲测不可用
 */
-(void)pushToSysConfig;
/// 软性打开URL：【不会处理打开成功和打开失败两种情况】如果URL有误则无法打开
-(void)openURL:(NSString *_Nullable)URLStr;
/// 软性打开URL：【只处理打开成功的情况】
-(void)openURL:(NSString *_Nullable)URLStr
  successBlock:(MKDataBlock _Nullable)successBlock;
/// 软性打开URL：【只处理打开失败的情况】
-(void)openURL:(NSString *_Nullable)URLStr
     failBlock:(MKDataBlock _Nullable)failBlock;
/// 软性打开URL：【会处理打开成功和打开失败两种情况】如果URL有误，可以做其他事，比如打开一个备用URL
-(void)openURL:(NSString *_Nullable)URLStr
  successBlock:(MKDataBlock _Nullable)successBlock
     failBlock:(MKDataBlock _Nullable)failBlock;
/// 硬性打开URL：【会处理打开成功和打开失败两种情况】如果URL有误，可以做其他事，比如打开一个备用URL
-(BOOL)openURL:(NSString *_Nullable)URLStr
       options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *_Nullable)options
completionOpenSuccessHandler:(NoResultBlock _Nullable)openSuccessBlock
completionOpenFailHandler:(NoResultBlock _Nullable)openFailBlock;

@end

NS_ASSUME_NONNULL_END
