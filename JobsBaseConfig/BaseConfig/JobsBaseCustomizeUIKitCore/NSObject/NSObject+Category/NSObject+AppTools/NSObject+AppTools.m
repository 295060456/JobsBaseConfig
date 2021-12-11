//
//  NSObject+AppTools.m
//  DouYin
//
//  Created by Jobs on 2021/4/6.
//

#import "NSObject+AppTools.h"

@implementation NSObject (AppTools)

#pragma mark —— BaseProtocol
/// 【通知监听】国际化语言修改UI
/// @param targetView 需要铆定的UI
/// @param aSelector 相关逻辑
+(void)targetView:(UIView *)targetView
languageSwitchNotificationWithSelector:(SEL)aSelector{
    NotificationAdd(targetView, aSelector, LanguageSwitchNotification, nil);
}
/// 【App语言国际化】更改UITabBarItem的标题
+(void)changeTabBarItemTitle:(NSIndexPath *)indexPath{
    id appDelegate = getSysAppDelegate();
    if (!appDelegate) {
        extern AppDelegate *appDelegate;
    }
    if ([appDelegate isKindOfClass:AppDelegate.class]) {
        AppDelegate *ad = (AppDelegate *)appDelegate;
        
        if (ad.tabBarTitleMutArr.count) {
            [ad.tabBarTitleMutArr removeAllObjects];
            ad.tabBarTitleMutArr = nil;
        }
        
        for (int i = 0; i < ad.tabBarTitleMutArr.count; i ++) {
            UIViewController *vc = ad.tabBarVC.childMutArr[i];
            vc.tabBarItem.title = ad.tabBarTitleMutArr[i];
        }
    }
}
/// 设置App语言环境
+(void)setAppLanguageAtIndexPath:(nonnull NSIndexPath *)indexPath
              byNotificationName:(nullable NSString *)NotificationName{
    
    if (!NotificationName) {
        NotificationName = LanguageSwitchNotification;
    }
    
    switch (indexPath.row) {
        case 0:{
            [CLLanguageManager setUserLanguage:@"en"];
        }break;
        case 1:{
            [CLLanguageManager setUserLanguage:@"zh-Hans"];
        }break;
        case 2:{
            [CLLanguageManager setUserLanguage:@"en"];
        }break;
            
        default:
            break;
    }
    /// 发通知，通知需要更改的地方进行修改
    if (CLLanguageManager.userLanguage) {
        NotificationPostOnMainThread(LanguageSwitchNotification, CLLanguageManager.userLanguage, nil);
    }else{
        NSLog(@"CLLanguageManager.userLanguage不存在");
    }
}
/// 接收通知并相应的方法【在分类或者基类中实现会屏蔽具体子类的相关实现】
//-(void)languageSwitchNotification:(nonnull NSNotification *)notification{
//    NSLog(@"通知传递过来的 = %@",notification.object);
//}
#pragma mark —— AppToolsProtocol
-(void)toLogin{
//    AppDelegate *appDelegate = getSysAppDelegate();
//    [UIViewController comingFromVC:appDelegate.tabBarVC
//                              toVC:JobsAppDoorVC.new
//                       comingStyle:ComingStyle_PRESENT
//                 presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
//                     requestParams:@(JobsAppDoorBgType_video)
//          hidesBottomBarWhenPushed:YES
//                          animated:YES
//                           success:^(id data) {}];
}

-(void)forcedLogin{
    if (!self.isLogin) {
        [self toLogin];
    }
}

-(UIImage *)defaultHeaderImage{
    if ([NSObject isLogin]) {
        return KIMG(@"default_avatar_white");
    }else{
        return KIMG(@"未登录默认头像（灰）");
    }
}

-(BOOL)isFristpostChannle{
    NSString *frist = [NSUserDefaults.standardUserDefaults valueForKey:@"fristpostChannle"];
    if([NSString isNullString:frist]) {
        return YES;
    }return NO;
}

+(void)completeFristpostChannle {
    [NSUserDefaults.standardUserDefaults setValue:@"fristpostChannle"
                                           forKey:@"fristpostChannle"];
}
/// 强制展现页面，本类如果是VC则用本类推，否则用JobsTabbarVC来推
/// @param toPushVC 需要进行展现的页面
/// @param requestParams 正向推页面传递的参数
-(void)forceComingToPushVC:(UIViewController *)toPushVC
             requestParams:(id _Nullable)requestParams{
    extern AppDelegate *appDelegate;
    UIViewController *viewController = [self isKindOfClass:UIViewController.class] ? (UIViewController *)self :(UIViewController *)appDelegate.tabBarVC;
    if (viewController) {
        [viewController comingToPushVC:toPushVC
                         requestParams:requestParams];
    }else{
        NSLog(@"%@强制展现页面%@失败,携带的参数%@",viewController,toPushVC,requestParams);
        [WHToast toastErrMsg:@"强制展现页面失败,请检查控制台"];
    }
}

@end

