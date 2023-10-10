//
//  NSObject+OpenURL.m
//  UBallLive
//
//  Created by Jobs on 2020/10/11.
//

#import "NSObject+OpenURL.h"

@implementation NSObject (OpenURL)
/// 发送邮件
/// @param mailComposeVC 外界自定义的发送邮件的VC，如传nil则用默认值
-(void)sendMailWithComposeVC:(MFMailComposeViewController *_Nullable)mailComposeVC
                  completion:(void (^ __nullable)(void))completion{
    if (MFMailComposeViewController.canSendMail) {
        [self.jobsGetCurrentViewController forceComingToPresentVC:mailComposeVC requestParams:nil completion:completion];
    }else{
        [WHToast jobsToastMsg:Internationalization(@"打开邮件失败,请确保设备上至少启用了一个电子邮件帐户！")];
    }
}
#pragma mark —— MFMessageComposeViewControllerDelegate
/**
    推出页面的方式用presentViewController，pushViewController可能会崩溃
    [self presentViewController:self.messageComposeVC animated:YES completion:nil];
 */
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark —— MFMailComposeViewControllerDelegate
/**
 [self presentViewController:self.messageComposeVC animated:YES completion:nil];
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}
/// 调用系统电话☎️拨号功能，会以sheet的形式，确认后进行拨号
/// @param telephoneNumber 电话号码
/// @param dialFinishBackToApp 电话结束后是否会留在电话界面【tel留在打电话页面。telprompt返回App（上架App Store🈶被拒的案例）】
/// @param successBlock 成功回调
/// @param failBlock 失败回调
-(void)dialWithTelephoneNumber:(NSString *_Nullable)telephoneNumber
           dialFinishBackToApp:(BOOL)dialFinishBackToApp
                  successBlock:(jobsByIDBlock _Nullable)successBlock
                     failBlock:(jobsByIDBlock _Nullable)failBlock{
    /// WKWebView默认禁止了跳转到appStore, 拨打电话, 唤起邮箱等一系列操作
    NSString *tel = dialFinishBackToApp ? @"telprompt://" : @"tel://";
    [NSObject openURL:[tel stringByAppendingString:telephoneNumber]
              options:@{}
completionOpenSuccessHandler:^{
        if (successBlock) successBlock(@1);
    }
completionOpenFailHandler:^{
        if (failBlock) failBlock(@1);
    }];
}
/// 跳转系统设置
/// 在iOS10更新后，跳转到系统设置的具体的子页面被禁用，只能跳转到系统设置根目录
/// 但是苹果又更新了URLscheme，亲测不可用
-(void)pushToSysConfig{
    [self openURL:UIApplicationOpenSettingsURLString];
}
/// 软性打开URL：【不会处理打开成功和打开失败两种情况】如果URL有误则无法打开
-(void)openURL:(NSString *_Nullable)URLStr{
    [self openURL:URLStr
              options:@{}
completionOpenSuccessHandler:nil
completionOpenFailHandler:nil];
}
/// 软性打开URL：【只处理打开成功的情况】
-(void)openURL:(NSString *_Nullable)URLStr
  successBlock:(jobsByIDBlock _Nullable)successBlock{
    [self openURL:URLStr
              options:@{}
completionOpenSuccessHandler:^{
        if (successBlock) successBlock(@1);
    }
completionOpenFailHandler:nil];
}
/// 软性打开URL：【只处理打开失败的情况】
-(void)openURL:(NSString *_Nullable)URLStr
     failBlock:(jobsByIDBlock _Nullable)failBlock{
    [self openURL:URLStr
              options:@{}
completionOpenSuccessHandler:nil
completionOpenFailHandler:^{
        if (failBlock) failBlock(@1);
    }];
}
/// 软性打开URL：【会处理打开成功和打开失败两种情况】如果URL有误，可以做其他事，比如打开一个备用URL
-(void)openURL:(NSString *_Nullable)URLStr
  successBlock:(jobsByIDBlock _Nullable)successBlock
     failBlock:(jobsByIDBlock _Nullable)failBlock{
    [self openURL:URLStr
              options:@{}
completionOpenSuccessHandler:^{
        if (successBlock) successBlock(@1);
    }
completionOpenFailHandler:^{
        if (failBlock) failBlock(@1);
    }];
}
/// 硬性打开URL：【会处理打开成功和打开失败两种情况】如果URL有误，可以做其他事，比如打开一个备用URL
-(BOOL)openURL:(NSString *_Nullable)URLStr
       options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *_Nullable)options
completionOpenSuccessHandler:(jobsByVoidBlock _Nullable)openSuccessBlock
completionOpenFailHandler:(jobsByVoidBlock _Nullable)openFailBlock{
    /// URLStr不是字符串、为空、不能打开均不走以下逻辑判断
    if (![URLStr isKindOfClass:NSString.class]) {
        [WHToast jobsToastMsg:Internationalization(@"URL类型不匹配，请检查")];
        return NO;
    }
    if ([NSString isNullString:URLStr]) {
        [WHToast jobsToastMsg:Internationalization(@"URL为空，请检查！")];
        return NO;
    }
    BOOL canOpen = [UIApplication.sharedApplication canOpenURL:URLStr.jobsUrl];
    if (!canOpen) {
        [WHToast jobsToastMsg:[NSString stringWithFormat:Internationalization(@"打开%@失败，请检查"),URLStr]];
        return NO;
    }

    options = options ? options : @{};

    if (@available(iOS 10.0, *)) {
        if ([UIApplication.sharedApplication respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (canOpen) {
                [UIApplication.sharedApplication openURL:URLStr.jobsUrl
                                                 options:options
                                       completionHandler:^(BOOL success) {
                    NSLog(@"打开成功");
                    if (openSuccessBlock) openSuccessBlock();
                }];return YES;
            }else{
                if (openFailBlock)  openFailBlock();
                return NO;
            }
        }else {
            if (openFailBlock) openFailBlock();
            return NO;
        }
    }else {
        if (canOpen) {
            SuppressWdeprecatedDeclarationsWarning([UIApplication.sharedApplication openURL:[NSURL URLWithString:URLStr]]);
        }else if (openFailBlock) openFailBlock();
        return canOpen;
    }
}
#pragma mark —— @property(nonatomic,strong)MFMessageComposeViewController *messageComposeVC;
JobsKey(_messageComposeVC)
@dynamic messageComposeVC;
-(MFMessageComposeViewController *)messageComposeVC{
    MFMessageComposeViewController *MessageComposeVC = Jobs_getAssociatedObject(_messageComposeVC);
    if (!MessageComposeVC) {
        MessageComposeVC = MFMessageComposeViewController.new;
        //设置短信内容
        MessageComposeVC.body = Internationalization(@"吃饭了没");
        //设置收件人列表
        MessageComposeVC.recipients = @[@"10010",@"10086"];
        //设置代理
        MessageComposeVC.messageComposeDelegate = self;
        Jobs_setAssociatedRETAIN_NONATOMIC(_messageComposeVC, MessageComposeVC)
    }return MessageComposeVC;
}

-(void)setMessageComposeVC:(MFMessageComposeViewController *)messageComposeVC{
    Jobs_setAssociatedRETAIN_NONATOMIC(_messageComposeVC, messageComposeVC)
}
#pragma mark —— @property(nonatomic,strong)MFMailComposeViewController *mailComposeVC;
JobsKey(_mailComposeVC)
@dynamic mailComposeVC;
-(MFMailComposeViewController *)mailComposeVC{
    MFMailComposeViewController *MailComposeVC = Jobs_getAssociatedObject(_mailComposeVC);
    if (!MailComposeVC) {
        MailComposeVC = MFMailComposeViewController.new;
        //设置邮件主题
        [MailComposeVC setSubject:Internationalization(@"测试邮件")];
        //设置邮件内容
        [MailComposeVC setMessageBody:Internationalization(@"测试内容") isHTML:NO];
        //设置收件人列表
        [MailComposeVC setToRecipients:@[@"test@qq.com"]];
        //设置抄送人列表
        [MailComposeVC setCcRecipients:@[@"test1@qq.com"]];
        //设置代理
        MailComposeVC.mailComposeDelegate = self;
        Jobs_setAssociatedRETAIN_NONATOMIC(_mailComposeVC, MailComposeVC)
    }return MailComposeVC;
}

-(void)setMailComposeVC:(MFMailComposeViewController *)mailComposeVC{
    Jobs_setAssociatedRETAIN_NONATOMIC(_mailComposeVC, mailComposeVC)
}

@end
